//
//  TagsViewCell.h
//  百思不得姐
//
//  Created by 施永辉 on 16/4/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TagModel;
@interface TagsViewCell : UITableViewCell

/**模型数据 */
@property (nonatomic,strong)TagModel * tagModel;
@end
