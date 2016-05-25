//
//  TabBarController.m
//  框架
//
//  Created by 施永辉 on 16/4/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TabBarController.h"
#import "EssenceViewController.h"
#import "NewViewController.h"
#import "FriendTrendsViewController.h"
#import "MeViewController.h"
#import "TabBar.h"
#import "NavigationController.h"
@interface TabBarController ()

@end

@implementation TabBarController
+ (void)initialize
{
    //通过appearance统一设置所以UITabBarItem得文字属性
    //后面带有UI_APPEARANCE_SELECTOR的方法，都可以通过appearance对象来统一设置
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary * selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem * item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
       //添加子控制器
    [self setupChildVc:[[EssenceViewController alloc]init]title:@"精华" image:@"tabBar_essence_click_icon_37x37_" selectedImage:@"tabBar_essence_click_iconN_37x37_"];
    [self setupChildVc:[[NewViewController alloc]init]title:@"新帖" image:@"tabBar_friendTrends_click_icon_37x37_" selectedImage:@"tabBar_friendTrends_click_iconN_37x37_"];
    [self setupChildVc:[[FriendTrendsViewController alloc]init]title:@"关注" image:@"tabBar_me_click_icon_37x37_" selectedImage:@"tabBar_me_click_iconN_37x37_"];
    [self setupChildVc:[[MeViewController alloc]initWithStyle:UITableViewStyleGrouped]title:@"我" image:@"tabBar_new_click_icon_37x37_" selectedImage:@"tabBar_new_click_iconN_37x37_"];

    //自定义更改tabBar
    //因为TabBar 的属性是只读 我们可以用KVC进行强行的赋值修改
    [self setValue:[[TabBar alloc]init] forKeyPath:@"tabBar"];
    
}

/**
 *  初始化子控件
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.navigationItem.title = title;
    //设置文字和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    //包装导航控制器，添加导航控制器为tabarController的子控制器
    NavigationController * navc = [[NavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:navc];
   
    
}

@end
