//
//  RootViewController.m
//  WYA_iOS_Scaffold
//
//  Created by 李俊恒 on 2018/7/3.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "RootViewController.h"
#import "WYAHomeController.h"
#import "WYAMineController.h"

@interface RootViewController ()
/**
 存放初始化tabBar的数据模型
 */

@property (nonnull, nonatomic, strong) NSArray<RootControllerModel *> * tabBarModelArray;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    self.tabBar.translucent = NO;
    [self creatViewControllers];
    self.selectedIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark =========== createModel
- (NSArray *)tabBarModelArray {
    if (!_tabBarModelArray) {
        NSMutableArray * array           = [NSMutableArray array];
        RootControllerModel * item1Model = [RootControllerModel modelWithTitle:@"首页"
                                                                     className:@"WYAHomeController"
                                                               normalImageName:@"home_normal"
                                                             selectedImageName:@"home_selected"];

        RootControllerModel * item2Model = [RootControllerModel modelWithTitle:@"我的"
                                                                     className:@"WYAMineController"
                                                               normalImageName:@"More_normal"
                                                             selectedImageName:@"More_selected"];
        [array addObject:item1Model];
        [array addObject:item2Model];
        _tabBarModelArray = [array copy];
    }
    return _tabBarModelArray;
}

#pragma mark - UI -
- (void)creatViewControllers {
    NSMutableArray * viewControllers = [NSMutableArray array];
    for (RootControllerModel * model in self.tabBarModelArray) {
        NSString * className              = model.className;
        UIViewController * viewController = [[NSClassFromString(className) alloc] init];
        UINavigationController * nav      = [[UINavigationController alloc] initWithRootViewController:viewController];
        nav.tabBarItem.title              = model.tabBarTitle;
        nav.tabBarItem.image              = [model normalImage];
        nav.tabBarItem.selectedImage      = [model selectedImage];
        CGFloat fontSize                  = 14;
        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : WYA_RGB_COLOR(102, 102, 102),
                                                             NSFontAttributeName : FONT(fontSize) }
                                                 forState:UIControlStateNormal];

        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:WYA_RGB_COLOR(77, 154, 247), NSForegroundColorAttributeName, nil] forState:(UIControlStateSelected)];
        [viewControllers addObject:nav];
    }
    self.viewControllers = viewControllers;
#pragma mark ======= 调整文字和图片的间距
    for (UITabBarItem * i in self.tabBar.items) {
        i.titlePositionAdjustment = UIOffsetMake(0, 2);
        i.imageInsets             = UIEdgeInsetsMake(-1, 0, 1, 0);
    }
}

@end
