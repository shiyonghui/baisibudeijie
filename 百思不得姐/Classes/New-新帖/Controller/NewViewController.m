//
//  NewViewController.m
//  框架
//
//  Created by 施永辉 on 16/4/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NewViewController.h"
#import <AFNetworking.h>
@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏内容
    self.navigationItem.titleView= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle_107x19_"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon_18x15_" target:self highImage:@"MainTagSubIconClick_18x15_" action:@selector(NewClick)];
    //设置背景色
    self.view.backgroundColor = GlobalBg;

    NSDictionary * result = [NSDictionary dictionary];
    result = @{};
}

- (void)NewClick
{
    NSLog(@"111");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
