//
//  PicView.m
//  百思不得姐
//
//  Created by 施永辉 on 16/4/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PicView.h"
#import <UIImageView+WebCache.h>
#import "WordModel.h"
#import <DALabeledCircularProgressView.h>
#import "ShowPictureViewController.h"
@interface PicView ()
//图片
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//gif
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
//查看大图
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *ProgressView;

@end

@implementation PicView

+ (instancetype)PicView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)setTopic:(WordModel *)topic
{
    _topic = topic;
    //立马显示最新的进度值（防止网速慢 导致显示的是其他图片的下载进度）
    [self.ProgressView setProgress:topic.pictureProgress animated:NO];
//    ImageIO - GIF -> N 个UImage ImageIO gif框架
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image2]placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.ProgressView.hidden = NO;
      //计算进度值
        CGFloat progress = 1.0 * receivedSize / expectedSize ;
       //显示进度值
           [self.ProgressView setProgress:progress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.ProgressView.hidden = YES;
        //如果是大图片才需要进行绘图处理
        if (topic.bigImage == NO)return;
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
        
        //降下载完的image对象绘制到图形上下文
        CGFloat width = topic.pictureF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0,width,height)];
        //获取图片
       self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        //结束图形上下文
        UIGraphicsEndImageContext();
    }];
    
    //判断是否为GIF
    NSString * extension = topic.image2.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    //判断是否点击查看全图
  
 if (topic.isBigPicture )
 {//如果是大图
     self.seeBigButton.hidden = NO;
     self.imageView.contentMode = UIViewContentModeScaleAspectFill;
 }else{//非大图
     self.seeBigButton.hidden = YES;
     self.imageView.contentMode = UIViewContentModeScaleToFill;
    
 }
    
}
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.ProgressView.roundedCorners =2 ;
    self.ProgressView.progressLabel.textColor = [UIColor whiteColor];
    //给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)]];
    
}
- (void)tapAction
{
    ShowPictureViewController * showPic = [[ShowPictureViewController alloc]init];
    showPic.model = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPic animated:YES completion:nil];
}
@end
