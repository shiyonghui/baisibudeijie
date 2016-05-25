//
//  RecommendModel.h
//  百思不得姐
//
//  Created by 施永辉 on 16/4/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendModel : NSObject

/** id */
@property (nonatomic,assign)NSInteger id;

/** 总数 */
@property (nonatomic,assign)NSInteger count;

/** 名字 */
@property (nonatomic,strong)NSString * name;

/**对于用户的数据 */
@property (nonatomic,strong)NSMutableArray *  users;

/**当前页码 */
@property (nonatomic,assign)NSInteger  currentPage;

/**总数 */
@property (nonatomic,assign)NSInteger  total;
@end
