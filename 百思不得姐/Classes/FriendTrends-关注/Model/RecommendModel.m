//
//  RecommendModel.m
//  百思不得姐
//
//  Created by 施永辉 on 16/4/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RecommendModel.h"
#import <MJExtension.h>
@implementation RecommendModel

- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
+ (NSDictionary *)replacedKeyFromPropertName
{
    return @{@"ID":@"id"};
}
@end
