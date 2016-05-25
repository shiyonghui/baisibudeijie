//
//  AddTagToolBarController.h
//  百思不得姐
//
//  Created by 施永辉 on 16/5/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTagToolBarController : UIViewController
//获取tags的block
@property (nonatomic,copy)void (^ tagsBlock)(NSArray *tags);
//所有的标签
@property (nonatomic,strong)NSArray * tags;
@end
