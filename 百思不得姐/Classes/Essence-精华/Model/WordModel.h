//
//  WordModel.h
//  百思不得姐
//
//  Created by 施永辉 on 16/4/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Commend;
@interface WordModel : NSObject

/**id */
@property (nonatomic,strong)NSString * ID;
/**名称 */
@property (nonatomic,strong)NSString * name;

/**头像 */
@property (nonatomic,strong)NSString * profile_image;

/**发帖时间 */
@property (nonatomic,strong)NSString * create_time;

/**文字内容 */
@property (nonatomic,strong)NSString * text;

/**顶的数量 */
@property (nonatomic,assign)NSInteger ding;

/**踩得数量 */
@property (nonatomic,assign)NSInteger cai;

/**转发数量 */
@property (nonatomic,assign)NSInteger repost;

/**评论数量 */
@property (nonatomic,assign)NSInteger comment;
//图片的高度
@property (nonatomic,assign)CGFloat height;
//图片的宽度
@property (nonatomic,assign)CGFloat width;
//图片的路径
@property (nonatomic,strong) NSString * image0;//小图
@property (nonatomic,strong) NSString * image1;//大图
@property (nonatomic,strong) NSString * image2;//中图
//额外的辅助属性
@property (nonatomic,assign,readonly)CGFloat cellHeight;
//帖子类型
@property (nonatomic,strong)NSString * type;
//图片控件的frame
@property (nonatomic,assign,readonly)CGRect pictureF;
//声音控件的frame
@property (nonatomic,assign,readonly)CGRect voiceF;
//图片是否太大
@property (nonatomic,assign,getter=isBigPicture)BOOL bigImage;
//图片下载进度
@property (nonatomic,assign)CGFloat pictureProgress;
//***音频
//播放次数
@property (nonatomic,assign)NSInteger playcount;
//播放时长
@property (nonatomic,assign)NSInteger voicetime;
//****视频
//播放时长
@property (nonatomic,assign)NSInteger videotime;
//视频控件的frame
@property (nonatomic,assign,readonly)CGRect videoF;


//额外的辅助属性

/**热门评论 */
@property (nonatomic,strong)Commend * top_cmt;
//状态
//@property (nonatomic,copy)NSString * qzone_uid;

@end
