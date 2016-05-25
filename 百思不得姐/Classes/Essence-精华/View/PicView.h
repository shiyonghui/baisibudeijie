//
//  PicView.h
//  百思不得姐
//
//  Created by 施永辉 on 16/4/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WordModel;
@interface PicView : UIView
//帖子数据
@property (nonatomic,strong)WordModel * topic;
+ (instancetype)PicView;
@end
