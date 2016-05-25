//
//  TopicsCell.h
//  百思不得姐
//
//  Created by 施永辉 on 16/4/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WordModel;
@interface TopicsCell : UITableViewCell
@property (nonatomic,strong)WordModel * topic;


- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString * )placeholder;
+ (instancetype)cell;
@end
