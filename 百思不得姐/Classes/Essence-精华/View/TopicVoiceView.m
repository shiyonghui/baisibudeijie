//
//  TopicVoiceView.m
//  百思不得姐
//
//  Created by 施永辉 on 16/5/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TopicVoiceView.h"
#import "WordModel.h"
#import <UIImageView+WebCache.h>
#import "ShowPictureViewController.h"
@interface TopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *voicelengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@end

@implementation TopicVoiceView

+ (instancetype)VoiceView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
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
-(void)setTopic:(WordModel *)topic
{
    _topic =topic;
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image2]];
    //播放次数
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    //播放时长
   
    NSInteger minute = topic.voicetime /60;
     NSInteger second = topic.voicetime % 60;
    self.voicelengthLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}
@end
