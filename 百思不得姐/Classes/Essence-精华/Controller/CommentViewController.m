//
//  CommentViewController.m
//  百思不得姐
//
//  Created by 施永辉 on 16/5/6.
//  Copyright © 2016年 mac. All rights reserved.
//
#import "TopicsCell.h"
#import "CommentViewController.h"
#import "WordModel.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import "Commend.h"
#import "CommendCell.h"
static NSInteger const HeaderLabelTag =99;
static NSString * const commendID = @"comment";
@interface CommentViewController ()
//工具条底部间距
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//最热评论
@property (nonatomic,strong) NSArray * hotComments;
//最新评论
@property (nonatomic,strong) NSMutableArray * latestComments;
//保存天的的top——cmt
@property (nonatomic,strong) Commend * top_cmtsave;
//保存当前的页码
@property (nonatomic,assign)NSInteger page;
//管理者
@property (nonatomic,strong) AFHTTPSessionManager * manager;
@end

@implementation CommentViewController
-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    基本设置
    [self setupBasic];
    [self setupHeader];
    //添加刷新控件
    [self setupRefresh];
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommendCell class]) bundle:nil] forCellReuseIdentifier:commendID];

}
//添加刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];

    //一进入就刷新
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.mj_footer.hidden = YES;

   
}
//更多评论
- (void)loadMoreComments
{
    //结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel) ];
    //yema
    NSInteger page = self.page + 1;
    //参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
   
    Commend * cmt = [self.latestComments lastObject];
     params[@"lastcid"] = cmt.ID;
    params[@"page"] = @(page);
    //发送请求
    [self.manager GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //没有数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_footer.hidden = YES;
            
            return;
        }//说明没有评论数

//        //最热评论
//        self.hotComments = [Commend mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        //最新评论
        NSArray * newComments = [Commend mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newComments];
        
               //页码
        self.page = page;
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >=total) {
            //全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }else{
            [self.tableView.mj_footer endRefreshing];

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];

}
- (void)loadNewTopics
{
    //结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
//    params[@"page"] = @(page);
    //发送请求
    [self.manager GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]){
            self.tableView.mj_footer.hidden = YES;
            
            return;
        }//说明没有评论数
            
        
        //最热评论
        self.hotComments = [Commend mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        //最新评论
        self.latestComments = [Commend mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        //页码
        self.page = 1;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >=total) {
            //全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [self.tableView.mj_header endRefreshing];
    }];
 
}
- (void)setupHeader
{
//    设置header
    UIView * header = [[UIView alloc]init];
  //清空top_cmt
    if (self.topic.top_cmt) {
        self.top_cmtsave = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKey:@"cellHeight"];

    }
   //    添加cell
    TopicsCell * cell = [TopicsCell cell];
    cell.topic = self.topic;
    cell.height = self.topic.cellHeight;
    cell.size = CGSizeMake(kWindowWidth, TopicCellMargin);
    cell.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    header的高度
    header.height = self.topic.cellHeight + TopicCellMargin;
    //设置header
    self.tableView.tableHeaderView = header;
    self.tableView.tableHeaderView = cell;
}

- (void)setupBasic
{
    self.title = @"评论";
    self.navigationItem .rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_iconN_20x3_" target:nil highImage:@"comment_nav_item_share_icon_clickN_20x4_" action:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keybordWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.tableView.backgroundColor = GlobalBg;
    //cell的高度设置
    self.tableView.estimatedRowHeight = 44;//估计高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;//自动变换高度
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, TopicCellMargin, 0);
}
- (void)keybordWillChangeFrame:(NSNotification *)note
{
    //键盘显示、隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //修改底部约束
    self.bottomSapce.constant = kWindowHeight - frame.origin.y;
    //动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    //动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];//强制布局
    }];
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    //恢复帖子的top_cmt
    if (self.top_cmtsave)
    {
        self.topic.top_cmt = self.top_cmtsave;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    //取消所有任务 
    [self.manager invalidateSessionCancelingTasks:YES];
}
- (Commend *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}
//返回第section组的所有评论
- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0){
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}
#pragma mark -- <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
}
#pragma mark -- <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latesCount = self.latestComments.count;
    if (hotCount)return 2;//有最热评论 + 最新评论 2组
    if (latesCount)return 1;//有最新评论 1组
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger hotCount = self.hotComments.count;
    NSInteger latesCount = self.latestComments.count;
    //隐藏尾部控件
    tableView.mj_footer.hidden =  (latesCount == 0);
    if (section == 0){
        return hotCount ? hotCount : latesCount;
    }
//    if (section == 1) return latesCount;
    //非第0 组
    return latesCount;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSInteger hotCount = self.hotComments.count;
//
//    if (section == 0) {
//        return hotCount ? @"最热评论" : @"最新评论";
//    }
//    return @"最新评论";
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    static NSString * ID = @"header";
    //先从缓存池中找header
    UITableViewHeaderFooterView * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    UILabel * label = nil;
    if (header == nil) {//缓存中没有，自己创建
        header = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:ID];
        header.contentView.backgroundColor = GlobalBg;
        //创建label
        label = [[UILabel alloc]init];
            label.textColor = RGBColor(67, 67, 67);
            header.backgroundColor = GlobalBg;
            label.width = 200;
            label.x = TopicCellMargin;
        label.tag = HeaderLabelTag;
            label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            [header.contentView addSubview:label];
    }else
    {//从缓存池中取出来的
        label = (UILabel *)[header viewWithTag:HeaderLabelTag];
    }
    //设置label的数据
    NSInteger hotCount = self.hotComments.count;
    
            if (section == 0) {
                label.text = hotCount ? @"最热评论" : @"最新评论";
            }else{
                label.text = @"最新评论";
            }

    return header;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    CommendCell *cell=[tableView dequeueReusableCellWithIdentifier:commendID];
   
    
    cell.commend = [self commentInIndexPath:indexPath];
    return cell;
}
@end
