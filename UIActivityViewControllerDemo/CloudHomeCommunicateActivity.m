//
//  CloudHomeCommunicateActivity.m
//  UIActivityViewControllerDemo
//
//  Created by shenjx on 14-10-8.
//  Copyright (c) 2014年 shenjx. All rights reserved.
//

#import "CloudHomeCommunicateActivity.h"
#import "NSString+URLEncode.h"

#define appName @"销管家"
#define appId   @"601602"
@implementation CloudHomeCommunicateActivity

//活动列表项的类型
- (NSString *)activityType
{
    return NSStringFromClass([self class]);
}

+ (UIActivityCategory)activityCategory {
    return UIActivityCategoryShare;
}

- (NSString *)activityTitle
{
     return NSLocalizedString(@"云之家沟通", nil);
}

- (UIImage *)activityImage
{
    UIImage *image =[UIImage imageNamed:@"3.png"];
    return image;
}
- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    //如果没有安装云之家是不会出现云之家分享按钮的
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"kdweiboavailable://"]])
    {
        return YES;
    }
    
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems)
    {
        if ([activityItem isKindOfClass:[NSURL class]])
        {
            _url = activityItem;
        }
    }
}
- (void)performActivity
{

    BOOL completed = [[UIApplication sharedApplication] openURL:_url];
    [self activityDidFinish:completed];
}
@end
