//
//  ViewController.m
//  Weather
//
//  Created by geek-Xiao on 14-6-21.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#define CS_LATITUDE 28.12
#define CS_LONGITUDE 112.59
@interface ViewController ()<CLLocationManagerDelegate>
{
//    NSXMLParser *xmlPar;//xml解析器
//    NSData *parserdata;//保存将被xml解析到数据
//    NSMutableArray *AllCities;//保存所有城市到属性
//    NSString *currentElement;//存储每个节点的名字
//    NSString *currentValue;//存储每个节点的内容
//    NSMutableDictionary *personDic;//保存每个节点
    CLLocationManager * locationM;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    AllCities =[NSMutableArray array];
    [self setMapIP];
}
- (void)SetCity
{
    NSArray *arr=[[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"china" ofType:@"plist"]];
    NSLog(@"%@",_chengshi.text);
    for(id obj in arr)
    {
        for (id obj1 in obj) {
            if ([obj1 isKindOfClass:[NSArray class]]) {
                for (id obj2 in obj1){
                    if ([obj2 isKindOfClass:[NSArray class]]) {
                        for (NSDictionary *Dic in obj2) {
                            if ([Dic[@"name"] isEqualToString:_chengshi.text]) {
                                NSLog(@"+++++++");
                                [self SetWeather:Dic[@"weatherCode"]];
                            }
                        }
                    }
                }
            }
        }
    }
}
- (void)SetWeather:(NSString *)code
{
    
    //http://flash.weather.com.cn/wmaps/xml/china.xml显示风度，只有省份
    //http://www.weather.com.cn/data/cityinfo/%@.html没有风度，有城市
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://m.weather.com.cn/atad/%@.html",code]];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSData *data1=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    if ([data1 isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic=[NSDictionary dictionary];
        dic = (NSDictionary *)data1;
        NSLog(@"weather: %@",[dic objectForKey:@"weatherinfo"]);
        NSDictionary *weather=[dic objectForKey:@"weatherinfo"];
        _chengshi.text=[weather objectForKey:@"city"];
        _wendu.text=[weather objectForKey:@"temp1"];
        _tianqi.text=[weather objectForKey:@"weather1"];
        _time.text=[weather objectForKey:@"date_y"];
        _fengdu.text=[weather objectForKey:@"wind1"];
        _xinqi.text=[weather objectForKey:@"week"];
        _jianyi.text=[weather objectForKey:@"index_d"];
    }
}
-(void)setMapIP
{
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:CS_LATITUDE longitude:CS_LONGITUDE];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *array, NSError *error) {
        
        if (array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            NSString *city = placemark.locality;//locality地区长沙
            city =[city substringToIndex:city.length-1];
            NSLog(@"位于:%@",city);
            // NSLog(@"%@",placemark);
            _chengshi.text = city;
            [self SetCity];
        }
    }];
}
- (IBAction)SelectCity:(id)sender {
    NSArray *arr=[[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"china" ofType:@"plist"]];
    NSLog(@"%@",_SelCity.text);
    for(id obj in arr)
    {
        for (id obj1 in obj) {
            if ([obj1 isKindOfClass:[NSArray class]]) {
                for (id obj2 in obj1){
                    if ([obj2 isKindOfClass:[NSArray class]]) {
                        for (NSDictionary *Dic in obj2) {
                            if ([Dic[@"name"] isEqualToString:_SelCity.text]) {
                                NSLog(@"+++++++");
                                [self SetWeather:Dic[@"weatherCode"]];
                            }
                        }
                    }
                }
            }
        }
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_SelCity resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//    NSURL *url = [NSURL URLWithString:@"http://flash.weather.com.cn/wmaps/xml/china.xml"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    //通过同步网络请求到数据
//    parserdata = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    xmlPar = [[NSXMLParser alloc]initWithData:parserdata];
//    xmlPar.delegate = self;
//    BOOL bol = [xmlPar parse];
//    if(bol){
//        NSLog(@"解析成功");
//    }else
//    {
//        NSLog(@"解析失败");
//    }
//
//    //将城市中的城市名，通过遍历数组进行打印
//    for (NSDictionary * dic in AllCities) {
//        //NSLog(@"%@",[dic objectForKey:@"cityname"]);
//        if([code isEqual:[dic objectForKey:@"cityname"]])
//        {
//            NSLog(@"%@",[dic objectForKey:@"windState"]);
//            _chengshi.text = [dic objectForKey:@"cityname"];
//            NSString *tem = [NSString stringWithFormat:@"%@~%@度",[dic objectForKey:@"tem1"],[dic objectForKey:@"tem2"]];
//            _wendu.text = tem;
//            _tianqi.text = [dic objectForKey:@"stateDetailed"];
//            _Fendu.text = [dic objectForKey:@"windState"];
//        }
//    }

//-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
//{
//    [AllCities addObject:attributeDict];
//}
//-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
//{
//    currentValue = string;
//}
//
//#pragma mark 解析完一个节点时执行
//- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
//{
//    if (currentElement) {
//        [personDic setObject:currentValue forKey:currentElement];
//        currentElement = nil;
//        currentValue = nil;
//    }
//}
@end
