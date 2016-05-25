//
//  PlaceholderTextView.h
//  百思不得姐
//
//  Created by 施永辉 on 16/5/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView
//占位文字
@property (nonatomic,strong)NSString * placeholder;
//占位文字颜色
@property (nonatomic,strong)UIColor * placeholderColor;
@end
