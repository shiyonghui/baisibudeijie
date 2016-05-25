//
//  NavigationController.m
//  百思不得姐
//
//  Created by 施永辉 on 16/4/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController
//当第一次使用这个类的时候会调用一次
+ (void)initialize
{
    //当导航栏用在NavigationController中appearance才会生效
        UINavigationBar * bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite_320x64_@1x"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
     UIBarButtonItem * item = [UIBarButtonItem appearance];
    
    NSMutableDictionary * itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    
    
   
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary * itemAttrsa = [NSMutableDictionary dictionary];
    itemAttrsa[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    itemAttrsa[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:itemAttrsa forState:UIControlStateDisabled];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    
}
//自定义导航栏控制器
//在这个方法中可以拦截所以得push导航控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
        if (self.childViewControllers.count > 0) {//如果push进来的不是第一个控制器
        
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"navigationButtonReturn_15x21_"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick_15x21_"] forState:UIControlStateHighlighted];
            button.size = CGSizeMake(70, 30);
            //[button sizeToFit];
            //往左边偏移
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
            //让按钮内部所以内容左对齐
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
            //隐藏tabBar
            viewController.hidesBottomBarWhenPushed = YES;
          }
    //这句super的push要放在后面，让viewController可以覆盖上面设置的
    [super pushViewController:viewController animated:animated];

}
- (void)back
{
    [self popViewControllerAnimated:YES];
}
@end
