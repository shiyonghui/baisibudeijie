
//
//  FriendTrendsViewController.m
//  框架
//
//  Created by 施永辉 on 16/4/20.
//  Copyright © 2016年 mac. All rights reserved.
//
#import "LoginRegistViewController.h"
#import "FriendTrendsViewController.h"
#import "RecommendViewController.h"
@interface FriendTrendsViewController ()

@end

@implementation FriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon_19x17_" target:self highImage:@"friendsRecommentIcon-click_19x17_" action:@selector(friendsClick)];
    //设置背景色
    self.view.backgroundColor = GlobalBg;
}
- (void)friendsClick
{
    RecommendViewController * recommend = [[RecommendViewController alloc]init];
    [self.navigationController pushViewController:recommend animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginBtn:(id)sender {
    LoginRegistViewController * login = [[LoginRegistViewController alloc]init];
    [self presentViewController:login animated:YES completion:nil];
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
