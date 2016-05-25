//
//  WordModel.m
//  百思不得姐
//
//  Created by 施永辉 on 16/4/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WordModel.h"
#import <MJExtension.h>
#import "User.h"
#import "Commend.h"
@implementation WordModel
//.h中设置了readonly 因此这边要设置
{
    CGFloat _cellHeight;
    CGRect _pictureF;
}
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id",
             @"top_cmt":@"top_cmt[0]",
             @"ctime" :@"top_cmt[0]"};
}
- (NSString *)create_time
{
    //日期格式化类
    //NSString ->> NSDate
    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
    //设置日期格式
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //帖子创建时间
    NSDate * create = [fmt dateFromString:_create_time];
    if (create.isThisYear) {//今年
        
        if (create.isToday) {//今天
            NSDateComponents * cmps = [[NSDate date]deltaFrom:create];
            
            if (cmps.hour>= 1) {//时间差距 >= 1小时
                return  [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute >= 1){ //1小时 > 时间差距 >= 1分钟
                return  [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else{//一分钟 > 时间差距
                return @"刚刚";
            }
        }else if (create.isYesterday){//昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
           return   [fmt stringFromDate:create];
        }else{//其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    }else{//非今年
        return _create_time;
    }
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"top_cmt":@"Commend"};
}



- (CGFloat)cellHeight
{
    if (!_cellHeight) {
    
    //文字的Y值
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width -4 *TopicCellMargin, MAXFLOAT);
    //    CGFloat textH = [topic.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxSize].height;
        //计算文字高度
    CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
    //文字部分高度
    _cellHeight = TopicCellTextY + textH  +  TopicCellMargin ;
        //根据段子的类型计算cell的高度
        if ([self.type isEqualToString:@"10"]) {//图片
           //图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            //图片显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            if (pictureH >= TopicCellPicMaxH) {//图片高度过长
                pictureH = TopicCellPicBreakH;
                self.bigImage = YES;
            }
            //        计算图片的fame
            CGFloat pictureX = TopicCellMargin;
            CGFloat pictureY = TopicCellTextY + textH + TopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            _cellHeight += pictureH + TopicCellMargin;
        }else if ([self.type isEqualToString:@"31"])//声音帖子
        {
            CGFloat voiceX = TopicCellMargin;
            CGFloat voiceY = TopicCellTextY + textH + TopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW,voiceH);
            _cellHeight += voiceH + TopicCellMargin;
        //底部工具条高度
        _cellHeight += TopicCellBottomBarH + TopicCellMargin;
         }else if ([self.type isEqualToString:@"41"])//视频帖子
         {
             CGFloat videoX = TopicCellMargin;
             CGFloat videoY = TopicCellTextY + textH + TopicCellMargin;
             CGFloat videoW = maxSize.width;
             CGFloat videoH = videoW * self.height / self.width;;
             _videoF = CGRectMake(videoX, videoY, videoW,videoH);
             _cellHeight += videoH + TopicCellMargin;
             
         }
//        Commend * cmt = [self.top_cmt firstObject];
        if (self.top_cmt) {
            NSString * content = [NSString stringWithFormat:@"%@ : %@",self.top_cmt.user.username,self.top_cmt.content];
             CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += TopicCellTopCmtTitleH + TopicCellMargin  + contentH ;
        }
        //底部工具条高度
        _cellHeight += TopicCellBottomBarH + TopicCellMargin;
 }
    return _cellHeight;

}
@end
