//
//  TopicViewController.m
//  框架
//
//  Created by 施永辉 on 16/4/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TopicViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "WordModel.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "TopicsCell.h"
#import "CommentViewController.h"
#import "NewViewController.h"
@interface TopicViewController ()

/**帖子数据 */
@property (nonatomic,strong)NSMutableArray * topics;

/**页码 */
@property (nonatomic,assign)NSInteger page;

/**当加载下一页数据是需要这个参数 */
@property (nonatomic,strong)NSString * maxtime;

/**上一次的请求参数 */
@property (nonatomic,strong)NSDictionary * parms;
//上次选中的索引 或控制器
@property (nonatomic,assign)NSInteger lastSelectedIndex;
@end
static NSString * const TopicCellId = @"topic";
@implementation TopicViewController
- (NSString *)type
{
    return nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化表格
    [self setupTableView];
    //添加刷新控件
    [self setupRefresh];
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TopicsCell class]) bundle:nil] forCellReuseIdentifier:TopicCellId];
    //监听tabar点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabarClick) name:TaBarDidSelectNotification object:nil];
   
}
- (void)tabarClick
{
    
   //如果是连续选中2次 直接刷新
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex && self.tabBarController.selectedViewController == self.navigationController ) {
        [self.tableView.mj_header beginRefreshing];
    }
    //记录这一次选中的索引
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
}
- (void)setupTableView
{
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    //    CGFloat bottom = 49;
    CGFloat top = TitlesViewY + TitlesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;//取消分割线
    self.tableView.backgroundColor = [UIColor clearColor];
}
- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}
//添加刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    //自动切换透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //一进入就刷新
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    //    self.tableView.mj_footer.hidden = YES;
}
#pragma mark - a参数
- (NSString * )a
{
    return [self.parentViewController isKindOfClass:[NewViewController class]]? @"newlist":@"list";
}
#pragma mark -- 数据处理

//加载新的帖子数量
- (void)loadNewTopics
{
    //结束上啦
    [self.tableView.mj_footer endRefreshing];
    //参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = self.type;
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.parms = params;
    //发送请求
    [[AFHTTPSessionManager manager]GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.parms != params)return;
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典转模型
        self.topics = [WordModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        //清空页码
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parms != params)return;
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}
//加载更多
- (void)loadMoreTopics
{
    //结束下拉
    [self.tableView.mj_header endRefreshing];
    //页面
    self.page  ++;
    //参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = self.type;
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.parms = params;
    //发送请求
    [[AFHTTPSessionManager manager]GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.parms != params)return;
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典转模型
        NSArray * newTopics = [WordModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parms != params)return;
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        //恢复页码
        self.page --;
    }];
    
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TopicsCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicCellId];
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}
#pragma mark -代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出帖子模型
    WordModel * topic = self.topics[indexPath.row];
    
    //返回这个模型对应的帖子的高度
        return topic.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    CommentViewController * commentVc = [[CommentViewController alloc]init];
    commentVc.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVc animated:YES];
}
@end
