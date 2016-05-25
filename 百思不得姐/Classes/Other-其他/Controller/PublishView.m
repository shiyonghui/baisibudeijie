//
//  PublishView.m
//  百思不得姐
//
//  Created by 施永辉 on 16/5/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PublishView.h"
#import "VerticalButton.h"
#import "SendWordViewController.h"
#import "NavigationController.h"
#import <POP.h>
#define RootView [UIApplication sharedApplication].keyWindow.rootViewController.view
static CGFloat const AnimationDelay = 0.1;
static CGFloat const SpringFactor = 10;
@interface PublishView ()

@end

@implementation PublishView

+ (instancetype)publishView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib {
   //让控制器的view不能被点击
    self.userInteractionEnabled = NO;
    RootView.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.7;
    //数据
    NSArray * images = @[@"publish-video_75x75_",@"publish-picture_75x75_",@"publish-text_75x75_",@"publish-audio_75x75_",@"publish-review_75x75_",@"publish-link_72x72_"];
    NSArray * titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线下载"];
    
    //中间6个按钮
     int maxCols = 3;
    CGFloat buttonW = 75;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (kWindowHeight - 2 * buttonH) * 0.5;//228
    CGFloat buttonStartX  = 20;
    CGFloat xMargin = (kWindowWidth - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0 ; i <6 ; i++) {
        VerticalButton * button = [[VerticalButton alloc]init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
         [self addSubview:button];
        //设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
         [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]]forState:UIControlStateNormal];
      
       //计算X/Y
        int row = i/ maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
       CGFloat buttonBeginY = buttonEndY - kWindowHeight;//334
       
       
        //添加动画
        POPSpringAnimation * anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = SpringFactor;
        anim.springSpeed = SpringFactor;
        anim.beginTime = CACurrentMediaTime() + 0.2 * i;
        [button pop_addAnimation:anim forKey:nil];
        
    }
    
    //添加标语
    UIImageView * sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan_245x25_@1x"]];
    
    [self addSubview:sloganView];
    POPSpringAnimation * aniam = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = kWindowWidth * 0.5;
    CGFloat centerEndY = kWindowHeight * 0.2;
    CGFloat centerBeginY = centerEndY - kWindowHeight ;
    aniam.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    aniam.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    aniam.beginTime = CACurrentMediaTime() + images.count * AnimationDelay;
    aniam.springBounciness = SpringFactor;
    aniam.springSpeed = SpringFactor;
    [aniam setCompletionBlock:^(POPAnimation * anim , BOOL finished) {
        //标语动画执行完毕 恢复点击事件
        self.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:aniam forKey:nil];
    
}
- (IBAction)cancel {

    [self cancelWithCompletionBlock:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancelWithCompletionBlock:nil];
}
//先执行退出动画 动画完毕后执行completionBlock
- (void)cancelWithCompletionBlock:(void(^)())completionBlock{
    //让控制器的view不能被点击
    self.userInteractionEnabled = NO;
    RootView.userInteractionEnabled = NO;
    //视图里面的控件
    int beginIndex = 1;
    
    for (int i = beginIndex; i <self.subviews.count; i++) {
        UIView * subview = self.subviews[i];
        //添加动画
        POPBasicAnimation * anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + kWindowHeight;
        //动画的执行节奏(一开始很慢，后面很快)
//        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime =CACurrentMediaTime() + (i -beginIndex) * AnimationDelay;
        
        [subview pop_addAnimation:anim forKey:nil];
        //监听最后一个动画
        if (i == self.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation * anim , BOOL finished) {
                RootView.userInteractionEnabled = YES;
                [self removeFromSuperview];
                
                //执行传进来的completionBlock 参数
//                if (completionBlock) {
//                    completionBlock();
//                }或者下面的方法
                !completionBlock ? : completionBlock();
            }];
        }
    }

}

- (void)buttonClick:(UIButton *)button
{
    [self cancelWithCompletionBlock:^{
        if (button.tag == 2) {
            SendWordViewController * sendVC = [[SendWordViewController alloc]init];
            NavigationController * naVC = [[NavigationController alloc]initWithRootViewController:sendVC];
          UIViewController * root = [UIApplication sharedApplication].keyWindow.rootViewController;
             [root presentViewController:naVC animated:YES completion:nil];
            
        }
    }];
  
}
/**
   pop和Core Animation的区别
   1.Core Animationde 的动画只能添加到layer上
   2.pop的动画能添加到任何对象
   3.pop的底层并非基于Core Animation ，是基于CADisplayLink
   4.CoreAnimation 的动画仅仅是表象， 并不会真正修改对象的frame、size等值
   5.pop的动画实时修改对象的属性，真正地修改了对象的属性值
 */


@end
