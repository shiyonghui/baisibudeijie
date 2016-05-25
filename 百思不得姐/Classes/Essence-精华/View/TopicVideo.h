//
//  TopicVideo.h
//  百思不得姐
//
//  Created by 施永辉 on 16/5/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WordModel;
@interface TopicVideo : UIView
@property (nonatomic,strong)WordModel * topic;
+ (instancetype)videoView;
@end
