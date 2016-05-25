//
//  RecommendRIGHTTableViewCell.m
//  百思不得姐
//
//  Created by 施永辉 on 16/4/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RecommendRIGHTTableViewCell.h"
#import "RecommendUser.h"
#import <UIImageView+WebCache.h>

@interface RecommendRIGHTTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@end
@implementation RecommendRIGHTTableViewCell

- (void)setUser:(RecommendUser *)user
{
    _user = user;
    self.screenNameLabel.text = user.screen_name;
    NSString * fansCount = nil;
    if (user.fans_count <10000) {
        fansCount = [NSString stringWithFormat:@"%zd关注",user.fans_count];
    }else
    {
        fansCount = [NSString stringWithFormat:@"%.1f万人关注",user.fans_count/10000.0];
    }
    self.fansCountLabel.text = fansCount;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:user.header]placeholderImage:[UIImage imageNamed:@"friendsRecommentIcon-click_19x17_"]];
}

@end
