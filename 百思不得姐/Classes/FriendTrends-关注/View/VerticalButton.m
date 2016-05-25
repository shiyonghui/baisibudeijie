//
//  VerticalButton.m
//  百思不得姐
//
//  Created by 施永辉 on 16/4/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "VerticalButton.h"

@implementation VerticalButton

- (void)setup
{
    //让文字居中
     self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)awakeFromNib
{
    
    [self setup];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;

}

@end
