//
//  ViewController.h
//  Weather
//
//  Created by geek-Xiao on 14-6-21.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController<NSXMLParserDelegate>
//@property (weak, nonatomic) IBOutlet UILabel *chengshi;
@property (weak, nonatomic) IBOutlet UITextField *chengshi;
@property (weak, nonatomic) IBOutlet UITextField *time;
@property (weak, nonatomic) IBOutlet UITextField *xinqi;
@property (weak, nonatomic) IBOutlet UITextField *tianqi;
@property (weak, nonatomic) IBOutlet UITextField *wendu;
@property (weak, nonatomic) IBOutlet UITextField *fengdu;
@property (weak, nonatomic) IBOutlet UITextField *SelCity;
@property (weak, nonatomic) IBOutlet UITextView *jianyi;






@end
