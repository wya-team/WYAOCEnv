//
//  ChangeNavBarController.m
//  WYAiOSEnv
//
//  Created by 李俊恒 on 2018/7/7.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "ChangeNavBarController.h"

@interface ChangeNavBarController ()

@end

@implementation ChangeNavBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navStyle isEqualToString:@"创建多个文字按钮"]) {
        [self createNavigationItemsRightBarButtonWithNormalTitle:@[ @"按钮1", @"按钮2" ]];
    }
    if ([self.navStyle isEqualToString:@"创建一个图片按钮"]) {
        [self createNavigationItemRightBarButtonWithNormalImg:@"搜索" highlightedImg:nil];
    }
    if ([self.navStyle isEqualToString:@"创建多个图片按钮"]) {
        self.itemsSpace = 15; //设置两个按钮间距
        [self createNavigationItemsRightBarButtonWithNormalImg:@[ @"更多", @"搜索" ] highlightedImg:nil];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ======= action

/**
 右侧按钮的点击事件

 @param sedner sender
 */
- (void)navRightButtonClicked:(UIButton *)sedner {
    NSLog(@"搜索");
}
/**
 多个按钮的点击事件

 @param sender sender
 */
- (void)customRightButtonsClicked:(UIButton *)sender {
    if (sender.titleLabel.text) {
        NSLog(@"%@", sender.titleLabel.text);
    } else {
        switch (sender.tag) {
            case 0:
                NSLog(@"更多");
                break;
            case 1:
                NSLog(@"搜索");
                break;
            default:
                break;
        }
    }
}
@end
