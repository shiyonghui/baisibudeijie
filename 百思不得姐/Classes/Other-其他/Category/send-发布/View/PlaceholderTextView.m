//
//  PlaceholderTextView.m
//  百思不得姐
//
//  Created by 施永辉 on 16/5/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PlaceholderTextView.h"
@interface PlaceholderTextView()

@property (nonatomic,weak)UILabel * placeholderLabel;

@end
@implementation PlaceholderTextView

-(UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        //添加一个用来显示占位文字的label
        UILabel * placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.numberOfLines = 0;
       
        placeholderLabel.x = 4;
        placeholderLabel.y = 7;
         [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;

    }
    return _placeholderLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        //默认字体
        self.font = [UIFont systemFontOfSize:15];
        //默认占位文字颜色
        self.placeholderColor = [UIColor grayColor];
        //监听文字改变
         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
            }
    
    return self;
}
//监听文字改变
- (void)textDidChange
{
    //擦掉之前的绘画
//    [self setNeedsDisplay];
    self.placeholderLabel.hidden = self.hasText;//只要有文字就隐藏占位文字颜色
}


//更新占位文字的尺寸
- (void)layoutSubviews
{
    [super layoutSubviews];
//        self.placeholderLabel.backgroundColor = [UIColor redColor];
    //    CGSize maxSize = CGSizeMake(kWindowWidth -2 * self.placeholderLabel.x, MAXFLOAT);
    //    self.placeholderLabel.size = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
//    NSLog(@"%f",self.width);
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
   

}
//重新文字颜色
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
//    [self setNeedsDisplay];
    self.placeholderLabel.font = font;
    [self setNeedsLayout];
}
- (void)setText:(NSString *)text
{
    [super setText:text];
//    [self setNeedsDisplay];
    [self textDidChange];
}
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self textDidChange];
    
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placeholderLabel.text =placeholder;
    [self setNeedsLayout];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
