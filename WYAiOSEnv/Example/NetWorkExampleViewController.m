//
//  NetWorkExampleViewController.m
//  WYAiOSEnv
//
//  Created by 李世航 on 2018/7/11.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "NetWorkExampleViewController.h"
#import "NetWorkViewController.h"

#define NetWork @"NetWork"

@interface NetWorkExampleViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * dataSources;
@property (nonatomic, strong) NSArray * sectionTitleArray;

@end

@implementation NetWorkExampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sectionTitleArray = @[ @"上传", @"下载" ];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)dataSources
{
    if (_dataSources == nil) {
        _dataSources = @[ @[ @"上传图片", @"上传视频", @"上传文件" ], @[ @"下载单个文件", @"下载多个文件" ] ];
    }
    return _dataSources;
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView            = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        [self solveableViewOverrides:_tableView]; // 解决tableView被遮挡的问题
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NetWork];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}
#pragma mark ======= UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSources.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSources[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NetWork];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NetWork];
    }
    NSArray * array     = self.dataSources[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = array[indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * label       = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    label.text            = self.sectionTitleArray[section];
    label.textColor       = [UIColor blackColor];
    label.backgroundColor = randomColor;
    return label;
}
#pragma mark ======= UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NetWorkViewController * vc = [[NetWorkViewController alloc] init];
    vc.section                 = indexPath.section;
    if (indexPath.section == 0) {
        vc.row = indexPath.row;
    } else {
        vc.row = indexPath.row;
    }
    [self.navigationController pushViewController:vc animated:YES];
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
