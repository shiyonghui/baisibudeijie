//
//  TagModel.h
//  百思不得姐
//
//  Created by 施永辉 on 16/4/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagModel : NSObject

/**图片 */
@property (nonatomic,strong)NSString * image_list;

/**名字 */
@property (nonatomic,strong)NSString * theme_name;

/**订阅数 */
@property (nonatomic,assign)NSInteger sub_number;
@end
