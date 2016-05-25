//
//  footerView.m
//  百思不得姐
//
//  Created by 施永辉 on 16/5/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "footerView.h"
#import <AFNetworking.h>
#import "Square.h"
#import <MJExtension.h>
#import "SqaureButton.h"
#import "WebViewController.h"
#import <UIButton+WebCache.h>
@implementation footerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        //参数
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
       
       
        //发送请求
        [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
            NSArray * sqaures = [Square mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
                                [self createSquares:sqaures];
      
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           
        }];
       
    }
    
    return self;
}
- (void)createSquares:(NSArray *)sqaures
{
    //1行最多四列
    int maxCols = 4;
    //宽度和高度
    CGFloat buttonW = kWindowWidth /maxCols;
    CGFloat buttonH = buttonW;
   
    for (int i = 0 ; i<sqaures.count; i ++) {
        
        SqaureButton * button = [SqaureButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        //传递模型
        button.sqaure = sqaures[i];
        [self addSubview:button];
        int col = i % maxCols;
        int row = i/ maxCols;
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height =buttonH ;
        //计算footer的高度
        self.height = CGRectGetMaxY(button.frame);
    }
   
    //重绘
    [self setNeedsDisplay];
}
- (void)buttonClick:(SqaureButton *)button
{//前缀
    if(![button.sqaure.url hasPrefix:@"https"])return;
    WebViewController * web = [[WebViewController alloc]init];
    web.url = button.sqaure.url;
    web.title = button.sqaure.name;
    //去出当前的高航控制器
    UITabBarController * tabBrcv = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController * naV = (UINavigationController *)tabBrcv.selectedViewController;
    [naV pushViewController:web animated:YES];
}
//设置背景图片
//- (void)drawRect:(CGRect)rect
//{
//    [[UIImage imageNamed:@"mainCellBackground_50x50_"]drawInRect:rect];
//}
@end
