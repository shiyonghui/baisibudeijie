//
//  TagButton.m
//  百思不得姐
//
//  Created by 施永辉 on 16/5/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TagButton.h"

@implementation TagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"tag_add_icon_clickN_57x32_@1x"] forState:UIControlStateNormal];
         self.backgroundColor = [UIColor blueColor];
         self.titleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return self;
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.width += 3 *TagMargin;
    self.height = TagH;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = TagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + TagMargin;
}
@end
