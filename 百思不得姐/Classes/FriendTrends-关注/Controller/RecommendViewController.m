//
//  RecommendViewController.m
//  百思不得姐
//
//  Created by 施永辉 on 16/4/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "RecommendModel.h"
#import "RecommendTableViewCell.h"
#import "RecommendRIGHTTableViewCell.h"
#import "RecommendUser.h"
#import <MJRefresh.h>

#define SelectedData  self.leftData[self.leftTableView.indexPathForSelectedRow.row]

@interface RecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
//左边控制器
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;

//右边控制器
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@property (nonatomic,strong)RecommendModel * c ;
/**左边的类别数据 */
@property (nonatomic,strong)NSArray * leftData;

/**请求参数 */
@property (nonatomic,strong)NSMutableDictionary * params;


/**AFN请求管理者 */
@property (nonatomic,strong)AFHTTPSessionManager * manager;
@end

@implementation RecommendViewController

static NSString * const ID = @"leftCell";
static NSString * const userid = @"user";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"推荐关注";
    //设置背景色
    self.view.backgroundColor = GlobalBg;
    //添加新控件
    [self setupFresh];
    //显示指示器
    [SVProgressHUD  show];
    //获取数据
    [self getData];
    //注册
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendTableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendRIGHTTableViewCell class]) bundle:nil] forCellReuseIdentifier:userid];
    
    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.rightTableView.contentInset  = UIEdgeInsetsMake(64, 0, 0, 0);
    self.leftTableView.contentInset = self.rightTableView.contentInset;
    //设置高度
    self.rightTableView.rowHeight = 85;
    
}
//添加新控件
- (void)setupFresh
{
    self.rightTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.rightTableView.mj_footer.hidden = YES;
}
#pragma mark - 加载用户数据
- (void)loadMoreUsers
{
    RecommendModel * category = SelectedData;
    //发送请求给服务器 加载右侧数据
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    [self.manager GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        //字典数组-》模型数组
        NSArray * users = [RecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //当添加到当前类对于的数据中
        [category.users addObjectsFromArray:users];
        
         if (self.params != params)return ;
        //刷新右边表格
        [self.rightTableView reloadData];
        //让底部控件结束刷新
        [self checkFooterState];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         if(self.params != params)return;
        //提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        //结束刷新
        [self.rightTableView.mj_footer endRefreshing];
    }];
    
}
//加载用户数据
- (void)loadNewUsers
{
    RecommendModel * rc =SelectedData;
    //设置当前页码为1
    rc.currentPage = 1;
    //发送请求给服务器 加载右侧数据
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
    self.params = params;
    //发送请求给服务器，加载右侧数据
    [self.manager GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典数组-》模型数组
        NSArray * users = [RecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //清除所有旧数据
        [rc.users removeAllObjects];
        //当添加到当前类对于的数据中
        [rc.users addObjectsFromArray:users];
        //保存总数
        rc.total = [responseObject[@"total"]integerValue];
        
        if(self.params != params)return;//不是最后一次请求
        
        
        //刷新右边表格
        [self.rightTableView reloadData];
        //结束刷新
        [self.rightTableView.mj_header endRefreshing];
        //让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         if(self.params != params)return;
        //提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        [self.rightTableView.mj_header endRefreshing];
    }];
}
//加载左侧数据
- (void)getData
{
    //发送请求
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //隐藏指示器
        [SVProgressHUD dismiss];
        //服务器返回的JSON数据
      
        self.leftData = [RecommendModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
       
        //刷新表格
        [self.leftTableView reloadData];
        
        //默认选中首行
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self.rightTableView .mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];

}
//时刻检测footer的状态
- (void)checkFooterState
{
    RecommendModel * rc = SelectedData;
    //每次刷新右边数据时，都控制footer显示或者隐藏
    self.rightTableView.mj_footer.hidden = (rc.users.count == 0);
    //让底部控件结束刷新
    if (rc.users.count == rc.total) {//全部加载完毕
        [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        //还没有加载完毕
        [self.rightTableView.mj_footer endRefreshing];
    }
}
#pragma mark ------<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //左边类别表格
    if (tableView == self.leftTableView) return self.leftData.count;//左边的类别表格
   //监测footer的状态
    [self checkFooterState];
    return [SelectedData users].count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {//左边表格数据
        RecommendTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        cell.model = self.leftData[indexPath.row];
        
        return cell;

    }else{//右边表格数据
        RecommendRIGHTTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:userid];
        
        //右边用户表格
        cell.user = [SelectedData users][indexPath.row];
        return cell;
    }
    
}

#pragma mark ----<UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //结束刷新
    [self.rightTableView.mj_header endRefreshing];
    [self.rightTableView.mj_footer endRefreshing];
    
    RecommendModel * c = self.leftData[indexPath.row];

    if (c.users.count) {
        //显示曾经的数据
        [self.rightTableView reloadData];
    }else{
        //赶紧刷新表格，目的是：马上显示当前用户数据 不让用户看到上一个数据
        [self.rightTableView reloadData];
      //进入下拉刷新状态
        [self.rightTableView.mj_header beginRefreshing];
    }
}
#pragma mark ---控制器的销毁
-(void)dealloc
{
    //停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}
@end
