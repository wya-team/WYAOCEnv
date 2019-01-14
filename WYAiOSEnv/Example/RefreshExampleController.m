//
//  RefreshExampleController.m
//  WYAiOSEnv
//
//  Created by 李俊恒 on 2018/7/7.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "RefreshExampleController.h"
#import "RefreshTableViewController.h"

#define REFRESH_CELLID @"REFRESH_CELLID"

@interface RefreshExampleController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * dataSources;
@property (nonatomic, strong) NSArray * sectionTitleArray;
@end

@implementation RefreshExampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sectionTitleArray = @[ @"下拉刷新", @"上拉加载" ];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSArray *)dataSources {
    if (_dataSources == nil) {
        _dataSources = @[ @[ @"默认", @"隐藏时间的", @"隐藏状态和时间", @"自定义文字" ], @[ @"默认", @"隐藏刷新状态的文字", @"全部加载完毕", @"禁止自动加载", @"自定义文字", @"加载后隐藏" ] ];
    }
    return _dataSources;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView            = [[UITableView alloc] initWithFrame:CGRectMake(0, WYATopHeight, ScreenWidth, ScreenHeight)];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:REFRESH_CELLID];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}
#pragma mark ======= UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSources[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:REFRESH_CELLID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REFRESH_CELLID];
    }
    NSArray * array     = self.dataSources[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = array[indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel * label       = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    label.text            = self.sectionTitleArray[section];
    label.textColor       = [UIColor blackColor];
    label.backgroundColor = randomColor;
    return label;
}
#pragma mark ======= UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RefreshTableViewController * vc = [[RefreshTableViewController alloc] init];
    vc.section                      = indexPath.section;
    if (indexPath.section == 0) {
        vc.index = indexPath.row;
    } else {
        vc.index = indexPath.row;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
@end
