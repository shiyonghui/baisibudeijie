//
//  TopicsCell.m
//  百思不得姐
//
//  Created by 施永辉 on 16/4/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TopicsCell.h"
#import "WordModel.h"
#import <UIImageView+WebCache.h>
#import "PicView.h"
#import "TopicVoiceView.h"
#import "TopicVideo.h"
#import "Commend.h"
#import "User.h"
@interface TopicsCell()
//头像
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
//名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//时间
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
//顶
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
//踩
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
//分享
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
//评论
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
//文字内容
@property (weak, nonatomic) IBOutlet UILabel *TextLabel;
//评论内容
@property (weak, nonatomic) IBOutlet UILabel *commendLabel;
//最热评论的整体
@property (weak, nonatomic) IBOutlet UIView *topCmpView;

/**图片帖子中间的内容 */
@property (nonatomic,strong)PicView * pictureView;

/**声音帖子的内容 */
@property (nonatomic,strong)TopicVoiceView * voiceView;
/**视频帖子的内容 */
@property (nonatomic,strong)TopicVideo * videoView;
@end
@implementation TopicsCell

- (void)awakeFromNib {
    UIImageView * bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground_50x50_"];
    self.backgroundView =bgView;
}
+ (instancetype)cell
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}
- (PicView *)pictureView
{
    if (!_pictureView) {
        PicView * pictureView = [PicView PicView];
        [self.contentView addSubview:pictureView];
         _pictureView = pictureView;
    }
         return _pictureView;
}
- (TopicVoiceView *)voiceView
{
    if (!_voiceView) {
        TopicVoiceView * voiceView = [TopicVoiceView VoiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}
- (TopicVideo *)videoView
{
    if (!_videoView) {
        TopicVideo * videoView = [TopicVideo videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}
- (void)setTopic:(WordModel *)topic
{
    _topic = topic;
    //设置其他控件
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image]];
    
    self.nameLabel.text = topic.name;
    //帖子的创建时间
    self.createTimeLabel.text = topic.create_time;
    //设置帖子文字内容
    self.TextLabel.text = topic.text;
    
    topic.ding = 0;
    topic.repost = 0;
    //设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    
    
    //根据帖子类型 添加对应的内容到cell中间
    if ([topic.type isEqualToString:@"10"]) {//图片帖子
         self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;

    }else if ([topic.type isEqualToString:@"31"]){//声音帖子
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
    }else if ([topic.type isEqualToString:@"41"]){//视频帖子
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
    }else{
        //段子帖子
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    }
    //处理最热评论to
//    Commend * cmt = [topic.top_cmt firstObject];
    if (topic.top_cmt) {
        self.topCmpView.hidden = NO;
        self.commendLabel.text = [NSString stringWithFormat:@"%@ : %@",topic.top_cmt.user.username,topic.top_cmt.content];

        
    }else{
        self.topCmpView.hidden = YES;
        
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = TopicCellMargin;
    frame.size.width -= 2 * TopicCellMargin;
//    frame.size.height -= TopicCellMargin;
    frame.size.height = self.topic.cellHeight - TopicCellMargin;
    frame.origin.y += TopicCellMargin;
    [super setFrame:frame];
}
//设置底部按钮文字
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString * )placeholder
{
     if (count>10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }else{
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}
- (IBAction)clickButton:(id)sender {
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"取消", nil];
    
    [sheet showInView:self.self.window];
}
@end
