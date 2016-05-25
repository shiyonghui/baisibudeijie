//
//  UIView+Extension.h
//  框架
//
//  Created by 施永辉 on 16/4/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;

@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGSize size;
//在分类中声明@property，只会生成方法的声明，不会声明方法的实现和带有_下划线的的成员变量
@end
