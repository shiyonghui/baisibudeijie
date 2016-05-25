//
//  EssenceViewController.m
//  框架
//
//  Created by 施永辉 on 16/4/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "EssenceViewController.h"
#import "AllTableViewController.h"
#import "VideoTableViewController.h"
#import "SoundTableViewController.h"
#import "PictureTableViewController.h"
#import "WordTableViewController.h"
#import "RecommendTagsViewController.h"
@interface EssenceViewController ()<UIScrollViewDelegate>
/**
 标签栏底部红色的指示器
 */
@property (nonatomic,strong)UIView * indicatorView;
/**
 当前选中的按钮
 */
@property (nonatomic,strong)UIButton * selectButton;
/**
 顶部的所有标签
 */
@property (nonatomic,strong)UIView * titleView;
/**
 底部的所有标签
 */
@property (nonatomic,strong)UIScrollView * contentView;
@end

@implementation EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航栏
    [self setupNav];
    //初始化子控制器
    [self setupChildView];
    //设置顶部标签栏
    [self setupTitlesView];
    //底部的scrollView
    [self setupContentView];
    
    
}
//初始化子控制器
- (void) setupChildView
{
    AllTableViewController * all = [[AllTableViewController alloc]init];
    [self addChildViewController:all];
    
    VideoTableViewController * video = [[VideoTableViewController alloc]init];
    [self addChildViewController:video];
    
    
    SoundTableViewController * sound = [[SoundTableViewController alloc]init];
    [self addChildViewController:sound];
    
    PictureTableViewController * picture = [[PictureTableViewController alloc]init];
    [self addChildViewController:picture];
   
    WordTableViewController * word = [[WordTableViewController alloc]init];
    [self addChildViewController:word];
}
//设置导航栏
- (void)setupNav
{
    //设置导航栏内容
    self.navigationItem.titleView= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle_107x19_"]];
    
    //设置到含量左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon_18x15_" target:self highImage:@"MainTagSubIconClick_18x15_" action:@selector(EssenceClick)];
    //设置背景色
    self.view.backgroundColor = GlobalBg;
}
- (void)EssenceClick
{
    RecommendTagsViewController * tag = [[RecommendTagsViewController alloc]init];
    [self.navigationController pushViewController:tag animated:YES];
}
//点击标签导航栏事件
- (void)tilteClick:(UIButton *)button
{
    //修改按钮状态
    self.selectButton.enabled = YES;
    button.enabled = NO;
    self.selectButton = button;
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}
//设置顶部标签栏
- (void)setupTitlesView
{
    UIView * titlesView = [[UIView alloc]init];
    //三种设置透明度的方法
    //    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    //    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    titlesView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = TitlesViewH;
    titlesView.y = TitlesViewY;
    
    [self.view addSubview:titlesView];
    //底部的红色指示器
    UIView * indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    
    self.indicatorView = indicatorView;
    //内部的子标签
    NSArray * titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat width = titlesView.width/ titles.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0 ; i<titles.count; i++) {
        UIButton * button = [[UIButton alloc]init];
        button.tag = i;
        button.height =height;
        button.width = width;
        button.x = i * width;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        //        [button layoutIfNeeded];//强制布局(强制更新子控件的frame)
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(tilteClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        //默认点击了一个按钮
        if (i == 0) {
            
            button.enabled = NO;
            self.selectButton = button;
            //让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    self.titleView =titlesView;
   [titlesView addSubview:indicatorView];
}
//设置底部的scrollView
- (void)setupContentView
{
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView * contenView = [[UIScrollView alloc]init];
    contenView.frame = self.view.bounds;
    contenView.delegate = self;
    contenView.pagingEnabled = YES;
    [self.view insertSubview:contenView atIndex:0];
    contenView.contentSize = CGSizeMake(contenView.width * self.childViewControllers.count, 0);
    self.contentView = contenView;
    
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contenView];
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    //当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //取出子控制器
    UITableViewController * vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;//设置控制器的y值为20 默认的
    vc.view.height = scrollView.height;//设置控制器view的height值为整个屏幕高度（默认是比屏幕少20）
   
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self tilteClick:self.titleView.subviews[index]];
}

@end
