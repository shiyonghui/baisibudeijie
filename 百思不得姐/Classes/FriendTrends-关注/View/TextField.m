//
//  TextField.m
//  百思不得姐
//
//  Created by 施永辉 on 16/4/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TextField.h"

static NSString * const PlaceHolderColorKeyPath = @"_placeholderLabel.textColor";

@implementation TextField

//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    [self.placeholder drawInRect:CGRectMake(0, 10, rect.size.width, 25) withAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:self.font}];
//}
-(void)awakeFromNib
{
//    //修改占位文字颜色
//    [self setValue:[UIColor grayColor] forKeyPath:PlaceHolderColorKeyPath];
    //设置光标颜色 和文字颜色一样
    self.tintColor = self.textColor;
    //不成为第一响应者
    [self resignFirstResponder];
}
//当前文本框聚焦时候就会调用
- (BOOL)becomeFirstResponder
{

    //修改占位文字颜色
    [self setValue:self.textColor forKeyPath:PlaceHolderColorKeyPath];
    return [super becomeFirstResponder];
}
//光标不在它身上时候调用
- (BOOL)resignFirstResponder
{
    //修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:PlaceHolderColorKeyPath];
    //不成为第一响应者
  return [super resignFirstResponder];
}
//-(void)setPlaceholderColor:(UIColor *)placeholderColor
//{
//    _placeholderColor =placeholderColor;
//    //修改占位文字颜色
//    [self setValue:placeholderColor forKeyPath:PlaceHolderColorKeyPath];
//
//}
@end
