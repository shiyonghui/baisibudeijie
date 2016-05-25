//
//  UIBarButtonItem+Extension.h
//  百思不得姐
//
//  Created by 施永辉 on 16/4/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)itemWithImage:(NSString *)image target:(id)target highImage:(NSString *)highImage action:(SEL)action;
@end
