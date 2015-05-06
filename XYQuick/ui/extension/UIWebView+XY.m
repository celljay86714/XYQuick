//
//  UIWebView+XY.m
//  JoinShow
//
//  Created by Heaven on 14-3-5.
//  Copyright (c) 2014年 Heaven. All rights reserved.
//

#import "UIWebView+XY.h"

@implementation UIWebView (XY)


- (void)uxy_clean:(BOOL)isCleanCache
{
    [self loadHTMLString:@"" baseURL:nil];
    [self stopLoading];
    self.delegate = nil;
    if (isCleanCache)
    {
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[NSURLCache sharedURLCache] setDiskCapacity:0];
        [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    }
}


- (NSString*)uxy_innerHTML
{
    return [self stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerHTML"];
}

- (NSString*)uxy_userAgent
{
    return [self stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];;
}

@end