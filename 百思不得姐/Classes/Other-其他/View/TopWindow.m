//
//  TopWindow.m
//  百思不得姐
//
//  Created by 施永辉 on 16/5/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TopWindow.h"




@implementation TopWindow

static UIWindow * window_;

+ (void)initialize
{
  
}
+ (void)show
{
    window_ = [[UIWindow alloc]init];
    window_.frame = CGRectMake(0, 0, kWindowWidth, 20);
    window_.windowLevel = UIWindowLevelStatusBar;
    window_.backgroundColor = [UIColor yellowColor];
//    window_.hidden = NO;
}
@end
