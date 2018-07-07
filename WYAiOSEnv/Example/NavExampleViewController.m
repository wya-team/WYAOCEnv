//
//  NavExampleViewController.m
//  WYAiOSEnv
//
//  Created by 李俊恒 on 2018/7/7.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "NavExampleViewController.h"
#import "ChangeNavBarController.h"

#define NAV_CELLID @"navcellId"
@interface NavExampleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * dataSources;
@end

@implementation NavExampleViewController
#pragma mark ======= system interface
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ======= Lazy loading
- (NSArray *)dataSources{
    if (_dataSources == nil) {
        _dataSources = @[@"设置标题",@"设置标题字体颜色",@"设置标题字体大小",@"导航栏背景色",@"背景图片",@"添加单个右侧文字按钮",@"设置单个按钮字体大小",@"添加右侧多个文字按钮",@"单个图片右侧按钮",@"多个图片右侧按钮"];
    }
    return _dataSources;
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, ScreenHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self solveableViewOverrides:_tableView];// 解决tableView被遮挡的问题
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NAV_CELLID];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _tableView;
}

#pragma mark ======= UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSources.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NAV_CELLID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NAV_CELLID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataSources[indexPath.row];
    return cell;
}
#pragma mark ======= UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChangeNavBarController * vc = [[ChangeNavBarController alloc]init]; ;
    switch (indexPath.row) {
        case 0:
            self.navTitle = @"设置标题";
            break;
        case 1:
            self.navTitleColor = randomColor;
            break;
        case 2:
            self.navTitleFont = 20;
            break;
        case 3:
            self.navBackGroundColor = randomColor;
            break;
        case 4:
            self.navBackGroundImageNamed = @"navbgimg.jpg";
            break;
        case 5:
            [self createNavigationItemRightBarButtonWithNormalTitle:@"按钮1"];
            break;
        case 6:
            self.rightBarButtonItemTitleFont = 18;
            break;
        case 7:
            // 由于代码限制，其他样式将在push一个新的控制器展示效果
            vc.navStyle = @"创建多个文字按钮";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        case 8:
            // 由于代码限制，其他样式将在push一个新的控制器展示效果
            vc.navStyle = @"创建一个图片按钮";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        case 9:
            // 由于代码限制，其他样式将在push一个新的控制器展示效果
            vc.navStyle = @"创建多个图片按钮";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        default:
            break;
    }
}
@end
