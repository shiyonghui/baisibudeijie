//
//  User.h
//  百思不得姐
//
//  Created by 施永辉 on 16/5/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

/**用户名 */
@property (nonatomic,strong)NSString * username;

/**性别 */
@property (nonatomic,strong)NSString * sex;

/**头像 */
@property (nonatomic,strong)NSString * profile_image;
@end
