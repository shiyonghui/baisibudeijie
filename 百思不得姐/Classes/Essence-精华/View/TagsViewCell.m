//
//  TagsViewCell.m
//  百思不得姐
//
//  Created by 施永辉 on 16/4/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TagsViewCell.h"
#import "TagModel.h"
#import <UIImageView+WebCache.h>
@interface TagsViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation TagsViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setTagModel:(TagModel *)tagModel
{
    _tagModel = tagModel;
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:tagModel.image_list]];
    self.themeNameLabel.text = tagModel.theme_name;
    NSString * subNumber = nil;
    if (tagModel.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅",tagModel.sub_number];
    }else{//大于等于10000
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅",tagModel.sub_number/ 10000.0];
    }
    self.subNumberLabel.text = subNumber;
}
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -=1;
    [super setFrame:frame];
    
}
@end
