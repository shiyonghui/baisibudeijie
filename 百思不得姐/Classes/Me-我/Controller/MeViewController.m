//
//  MeViewController.m
//  框架
//
//  Created by 施永辉 on 16/4/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MeViewController.h"
#import "MyCell.h"
#import "footerView.h"
#import <AFNetworking.h>
#import "Square.h"
@interface MeViewController ()

@end

@implementation MeViewController
static NSString * MyId = @"my";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self setUpTab];
    
}
- (void)setUpNav
{
    UIBarButtonItem * settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon_20x20_" target:self highImage:@"mine-setting-icon-click_20x20_" action:@selector(settingClick)];
    UIBarButtonItem * moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon_20x20_" target:self highImage:@"mine-moon-icon-click_26x26_" action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems =@[settingItem,moonItem];
    //设置背景色
    self.tableView.backgroundColor = GlobalBg;

}
- (void)setUpTab
{
    [self.tableView registerClass:[MyCell class] forCellReuseIdentifier:MyId];
    //调整header footer
    //    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 10;
    //修改cell 的位置 （向上移动25）
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    //设置footerView
    self.tableView.tableFooterView = [[footerView alloc]init];
}
- (void)settingClick
{
    NSLog(@"111");
}
- (void)moonClick
{
    NSLog(@"111");
}
#pragma mark 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell * cell = [tableView dequeueReusableCellWithIdentifier:MyId];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"commentLikeButtonClick_19x19_@1x"];
        cell.textLabel.text = @"登录注册";
    }else if (indexPath.section == 1)
    {
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}
@end
