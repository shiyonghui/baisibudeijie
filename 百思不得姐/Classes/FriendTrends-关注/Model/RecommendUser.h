//
//  RecommendUser.h
//  百思不得姐
//
//  Created by 施永辉 on 16/4/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendUser : NSObject

/**头像 */
@property (nonatomic,strong)NSString * header;

/**粉丝数 */
@property (nonatomic,assign)NSInteger fans_count;

/**昵称 */
@property (nonatomic,strong)NSString * screen_name;
@end
