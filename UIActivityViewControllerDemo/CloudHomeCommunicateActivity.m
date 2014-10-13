//
//  CloudHomeCommunicateActivity.m
//  UIActivityViewControllerDemo
//
//  Created by shenjx on 14-10-8.
//  Copyright (c) 2014年 shenjx. All rights reserved.
//

#import "CloudHomeCommunicateActivity.h"
#import "NSString+URLEncode.h"
#import "NSData+Base64.h"

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
        else if ([activityItem isKindOfClass:[NSString class]])
        {
            _text = activityItem;
        }
        else if([activityItem isKindOfClass:[UIImage class]])
        {
            _image = activityItem;
        }
    }
}
- (void)performActivity
{
    NSURL *urlToOpen = nil;
    if (self.url)
    {
        urlToOpen = self.url;
    }
    else if (self.text)
    {
        NSString *urlStr = [[NSString alloc] initWithFormat:@"kdweiboavailable://p?function=share&appId=%@&appName=%@&shareType=1&text=%@",[appId encodeForURL],[appName encodeForURL],[self.text encodeForURL]];
        urlToOpen = [NSURL URLWithString:urlStr];
    }
    else if (self.image)
    {
        //NSString *imageData = [[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]] base64EncodedString];
        NSData *imageData = UIImagePNGRepresentation(self.image);
        NSString *image = [imageData base64EncodedString];
        NSString *urlStr = [[NSString alloc] initWithFormat:@"kdweiboavailable://p?function=share&appId=%@&appName=%@&shareType=2&imageData=%@",[appId encodeForURL],[appName encodeForURL],[image encodeForURL]];
        urlToOpen = [NSURL URLWithString:urlStr];
    }
    
   BOOL completed = [[UIApplication sharedApplication] openURL:urlToOpen];

    [self activityDidFinish:completed];
}
@end
