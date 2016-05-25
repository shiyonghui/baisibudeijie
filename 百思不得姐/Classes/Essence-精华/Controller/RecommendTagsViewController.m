//
//  RecommendTagsViewController.m
//  百思不得姐
//
//  Created by 施永辉 on 16/4/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RecommendTagsViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "TagModel.h"
#import <MJExtension.h>
#import "TagsViewCell.h"
@interface RecommendTagsViewController ()

/**标签数据 */
@property (nonatomic,strong)NSArray * tags;
@end
static NSString * const tagsID = @"tags";

@implementation RecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //布局
    [self setTableView];
    //请求数据
    [self loadTags];
    
    
}
//布局
- (void)setTableView
{
    self.title = @"推荐标签";
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TagsViewCell class]) bundle:nil] forCellReuseIdentifier:tagsID];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消分割线
    self.tableView.backgroundColor = GlobalBg;
}

//请求数据
- (void)loadTags
{
    //请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    //发送请求
    [[AFHTTPSessionManager manager]GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        self.tags = [TagModel mj_objectArrayWithKeyValuesArray:responseObject];
        //刷新表格
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tags.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TagsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tagsID];
    
    cell.tagModel = self.tags[indexPath.row];
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
