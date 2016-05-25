//
//  PushView.m
//  百思不得姐
//
//  Created by 施永辉 on 16/4/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PushView.h"

@implementation PushView


+ (instancetype)pushView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
- (IBAction)close {
    [self removeFromSuperview];
}
+ (void)show
{
        NSString * key = @"CFBundleShortVersionString";
        //获取当前软件的版本号
        NSString * currentVersion = [NSBundle mainBundle].infoDictionary[key];
        //获取沙盒存储的版本号
        NSString * sanboxVerson = [[NSUserDefaults standardUserDefaults]stringForKey:key];
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
        if (![currentVersion isEqualToString:sanboxVerson]) {
            PushView * view = [PushView pushView];
            view.frame = window.bounds;
            [window addSubview:view];
            //存储版本号
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
}
@end
