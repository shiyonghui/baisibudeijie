//
//  MyCell.m
//  百思不得姐
//
//  Created by 施永辉 on 16/5/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView * bgView = [[UIImageView alloc]init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground_50x50_"];
        self.backgroundView = bgView;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.height *0.5;
}


@end
