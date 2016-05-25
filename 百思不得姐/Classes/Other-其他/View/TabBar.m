//
//  TabBar.m
//  框架
//
//  Created by 施永辉 on 16/4/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TabBar.h"
#import "PublishView.h"
@interface TabBar ()
@property (nonatomic,weak)UIButton * bt;

@end

@implementation TabBar


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置tabbar背景颜色
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light_320x49_@1x"]];
        //添加一个发布按钮
            UIButton * bt  = [UIButton buttonWithType:UIButtonTypeCustom];
            [bt setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon_49x49_"] forState:UIControlStateNormal];
        [bt setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon_49x49_"] forState:UIControlStateHighlighted];
        [bt addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:bt];
        self.bt = bt;
    }
    
    return self;
}
//发布按钮事件
- (void)publishClick
{
    PublishView * publish = [PublishView publishView];
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    publish.frame =window.bounds;
    [window addSubview:publish];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.width;
    CGFloat height = self.height;
    //设置发布按钮的fram
    self.bt.bounds = CGRectMake(0, 0, self.bt.currentBackgroundImage.size.width, self.bt.currentBackgroundImage.size.height);
    self.bt.center = CGPointMake(width * 0.5, height * 0.5);
       //设置其他tabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width/ 5;
    CGFloat buttonH = height;
    NSInteger index = 0 ;
    for (UIView * button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
       //计算按钮的X值
        CGFloat buttonX = buttonW * ((index>1)?(index +1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //增加索引
        index ++;
        
    }
    
}

@end
