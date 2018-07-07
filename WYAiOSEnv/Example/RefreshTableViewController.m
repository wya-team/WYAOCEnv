//
//  RefreshTableViewController.m
//  WYAiOSEnv
//
//  Created by 李俊恒 on 2018/7/7.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "RefreshTableViewController.h"
// 自定义的header
static const CGFloat MJDuration = 2.0;
/**
 * 随机数据
 */
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

@interface RefreshTableViewController ()
/** 用来显示的假数据 */
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation RefreshTableViewController
#pragma mark - 示例代码
#pragma mark UITableView + 下拉刷新 默认
- (void)example01
{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark UITableView + 下拉刷新 隐藏时间
- (void)example02
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.tableView.mj_header = header;
}

#pragma mark UITableView + 下拉刷新 隐藏状态和时间
- (void)example03
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.tableView.mj_header = header;
}

#pragma mark UITableView + 下拉刷新 自定义文字
- (void)example04
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置文字
    [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置刷新控件
    self.tableView.mj_header = header;
}
#pragma mark UITableView + 上拉刷新 默认
- (void)example05
{
    [self example01];
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    //    ((MJRefreshAutoFooter *)self.tableView.mj_footer).onlyRefreshPerDrag = YES;
}

#pragma mark UITableView + 上拉刷新 隐藏刷新状态的文字
- (void)example06
{
    [self example01];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
    //    footer.triggerAutomaticallyRefreshPercent = 0.5;
    
    // 隐藏刷新状态的文字
    footer.refreshingTitleHidden = YES;
    
    // 设置footer
    self.tableView.mj_footer = footer;
}

#pragma mark UITableView + 上拉刷新 全部加载完毕
- (void)example07
{
    [self example01];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadLastData方法）
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
    
    // 其他
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"恢复数据加载" style:UIBarButtonItemStyleDone target:self action:@selector(reset)];
}

- (void)reset
{
    [self.tableView.mj_footer setRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.tableView.mj_footer resetNoMoreData];
}

#pragma mark UITableView + 上拉刷新 禁止自动加载
- (void)example08
{
    [self example01];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 禁止自动加载
    footer.automaticallyRefresh = NO;
    
    // 设置footer
    self.tableView.mj_footer = footer;
}

#pragma mark UITableView + 上拉刷新 自定义文字
- (void)example09
{
    [self example01];
    
    // 添加默认的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置文字
    [footer setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
    [footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor blueColor];
    
    // 设置footer
    self.tableView.mj_footer = footer;
}

#pragma mark UITableView + 上拉刷新 加载后隐藏
- (void)example10
{
    [self example01];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadOnceData方法）
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOnceData)];
}
#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data insertObject:MJRandomData atIndex:0];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
    });
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data addObject:MJRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [tableView.mj_footer endRefreshing];
    });
}

#pragma mark 加载最后一份数据
- (void)loadLastData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data addObject:MJRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态
        [tableView.mj_footer endRefreshingWithNoMoreData];
    });
}

#pragma mark 只加载一次数据
- (void)loadOnceData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data addObject:MJRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 隐藏当前的上拉刷新控件
        tableView.mj_footer.hidden = YES;
    });
}

- (NSMutableArray *)data
{
    if (!_data) {
        self.data = [NSMutableArray array];
        for (int i = 0; i<5; i++) {
            [self.data addObject:MJRandomData];
        }
    }
    return _data;
}

#pragma mark - 其他
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    if (self.section == 0) {
    switch (self.index) {
        case 0:
            [self example01];
            break;
        case 1:
            [self example02];
            break;
        case 2:
            [self example03];
            break;
        case 3:
            [self example04];
            break;
        default:
            break;
    }
    }else{
    switch (self.index) {
        case 0:
            [self example05];
            break;
        case 1:
            [self example06];
            break;
        case 2:
            [self example07];
            break;
        case 3:
            [self example08];
            break;
        case 4:
            [self example09];
            break;
        case 5:
            [self example10];
            break;
        default:
            break;
    }}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", indexPath.row % 2?@"push":@"modal", self.data[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

@end
