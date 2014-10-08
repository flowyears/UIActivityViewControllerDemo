//
//  ViewController.m
//  UIActivityViewControllerDemo
//
//  Created by shenjx on 14-10-8.
//  Copyright (c) 2014年 shenjx. All rights reserved.
//

#import "ViewController.h"
#import "CloudHomeCommunicateActivity.h"
#import "NSString+URLEncode.h"

#define appName @"销管家"
#define appId   @"601602"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 100, 100, 100);
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)share
{
    CloudHomeCommunicateActivity *cloudHomeCommunicateActivity = [[CloudHomeCommunicateActivity alloc] init];

    
    NSString *textToShare = @"请大家登录《iOS云端与网络通讯》服务网站。";
    
    UIImage *imageToShare = [UIImage imageNamed:@"2.jpg"];
    
    NSString *urlStr = [[NSString alloc] initWithFormat:@"kdweiboavailable://p?function=share&appId=%@&appName=%@&shareType=1&text=%@",[appId encodeForURL],[appName encodeForURL],[textToShare encodeForURL]];
    NSURL *url = [NSURL URLWithString:urlStr];
    cloudHomeCommunicateActivity.url = url;
    
    NSURL *urlToShare = [NSURL URLWithString:@"http://www.iosbook3.com"];
    
    NSArray *activityItems = @[textToShare,imageToShare, url];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems
                                            
                                                                            applicationActivities:@[cloudHomeCommunicateActivity]];
    
    
    //不出现在活动项目
    //activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    
    [self presentViewController:activityVC animated:YES completion:nil];
}
@end
