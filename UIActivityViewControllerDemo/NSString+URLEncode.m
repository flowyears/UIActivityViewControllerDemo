//
//  NSString+URLEncode.m
//
//  Created by Scott James Remnant on 6/1/11.
//  Copyright 2011 Scott James Remnant <scott@netsplit.com>. All rights reserved.
//

#import "NSString+URLEncode.h"


@implementation NSString (NSString_URLEncode)

- (NSString *)encodeForURL
{
    // See http://en.wikipedia.org/wiki/Percent-encoding and RFC3986
    // Hyphen, Period, Understore & Tilde are expressly legal
    const CFStringRef legalURLCharactersToBeEscaped = CFSTR("!*'();:@&=+$,/?#[]<>\"{}|\\`^% ");
  return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, legalURLCharactersToBeEscaped, kCFStringEncodingUTF8));
//    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, legalURLCharactersToBeEscaped, kCFStringEncodingUTF8);
}

- (NSString *)encodeForURLReplacingSpacesWithPlus;
{
    // Same as encodeForURL, just without +
    const CFStringRef legalURLCharactersToBeEscaped = CFSTR("!*'();:@&=$,/?#[]<>\"{}|\\`^% ");
    
    NSString *replaced = [self stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)replaced, NULL, legalURLCharactersToBeEscaped, kCFStringEncodingUTF8));
//    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)replaced, NULL, legalURLCharactersToBeEscaped, kCFStringEncodingUTF8);
}

- (NSString *)decodeFromURL
{
//    NSString *decoded = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8);
        NSString *decoded = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8));
    return [decoded stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}

@end
