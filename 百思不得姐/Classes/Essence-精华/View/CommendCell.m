//
//  CommendCell.m
//  百思不得姐
//
//  Created by 施永辉 on 16/5/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CommendCell.h"
#import "Commend.h"
#import <UIImageView+WebCache.h>
#import "User.h"
@interface CommendCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end
@implementation CommendCell
- (void)awakeFromNib {
    UIImageView * bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground_50x50_"];
    self.backgroundView =bgView;
}
- (void)setCommend:(Commend *)commend
{
    _commend = commend;

    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:commend.user.profile_image]placeholderImage:[UIImage imageNamed:@"error"]];
    self.sexView.image = [commend.user.sex isEqualToString:UserSexMale ]? [UIImage imageNamed:@"Profile_manIcon_13x13_"]:[UIImage imageNamed:@"Profile_womanIcon_13x13_"];
    self.contentLabel.text = commend.content;
    self.usernameLabel.text = commend.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",commend.like_count];
    if (commend.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",commend.voicetime] forState:UIControlStateNormal];
    }else{
        self.voiceButton.hidden = YES;
    }
}
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = TopicCellMargin;
    frame.size.width -=2 * TopicCellMargin;
    [super setFrame:frame];
}
@end
