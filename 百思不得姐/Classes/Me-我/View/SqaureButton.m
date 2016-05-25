
//
//  SqaureButton.m
//  百思不得姐
//
//  Created by 施永辉 on 16/5/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SqaureButton.h"
#import <UIButton+WebCache.h>
#import "Square.h"
@implementation SqaureButton

- (void)setup
{
    //让文字居中
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
     
    
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
//    self.imageView.x = 0;
    self.imageView.y = self.height * 0.2;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}
- (void)setSqaure:(Square *)sqaure
{
    _sqaure =sqaure;
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground_50x50_"] forState:UIControlStateNormal];
    [self setTitle:sqaure.name forState:UIControlStateNormal];
    
    //利用SDWebImage给按钮设置image
    [self sd_setImageWithURL:[NSURL URLWithString:sqaure.icon] forState:UIControlStateNormal];

}

@end
