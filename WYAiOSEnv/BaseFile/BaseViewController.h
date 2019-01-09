//
//  BaseViewController.h
//  WYA_iOS_Scaffold
//
//  Created by 李俊恒 on 2018/7/3.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
/**
 设置导航栏标题字体颜色 默认黑色
 */
@property (nonatomic, strong) UIColor * navTitleColor;

/**
 标题字体大小
 */
@property (nonatomic, assign) CGFloat navTitleFont;

/**
 返回按钮标题字体大小
 */
@property (nonatomic, assign) CGFloat leftBarButtonItemTitleFont;

/**
 右侧标题字体大小

 */
@property (nonatomic, assign) CGFloat rightBarButtonItemTitleFont;

/**
 导航栏是否展示横线 默认显示YES

 */
@property (nonatomic, assign) BOOL isShowNavLine;

/**
 视图背景色 默认白色

 */
@property (nonatomic, strong) UIColor * viewBackGroundColor;

/**
 导航栏背景色 默认白色

 */
@property (nonatomic, strong) UIColor * navBackGroundColor;

/**
 导航栏标题

 */
@property (nonatomic, copy) NSString * navTitle;

/**
 导航栏背景图片名字

 */
@property (nonatomic, copy) NSString * navBackGroundImageNamed;
#pragma mark ======= 解决tableView被tabBar遮挡问题
- (void)solveableViewOverrides:(UITableView * _Nonnull)tableView;
/**
 用于创建多个右侧按钮时调整按钮之间的间距，在创建之前先赋值，然后再创建按钮顺序不要搞错了
 示例：
 self.itemsSpace = 10;
 [self createNavigationItemsRightBarButtonWithNormalImg:@[@"img1",@"img2"] highlightedImg:nil];
 */
@property (nonatomic, assign) CGFloat itemsSpace;

#pragma mark ======= 创建多个右侧按钮
/**
  创建多个右侧按钮，可定制按钮标题

 @param normalTitles 标题数组
 */
- (void)createNavigationItemsRightBarButtonWithNormalTitle:(NSArray<NSString *> * _Nonnull)normalTitles;

/**
 创建多个右侧按钮 按钮的标题和颜色可以自定意 字体大小默认

 @param normalTitles 不能为空的数组，数组中元素为字符串，创建几个按钮由数组元素个数决定
 @param normalColors 普通状态的颜色，元素要与按钮标题对应
 @param highlightedColors 高亮状态的颜色(可以为nil)，元素要与按钮标题对应
 */
- (void)createNavigationItemsRightBarButtonWithNormalTitles:(NSArray<NSString *> * _Nonnull)normalTitles
                                                normalColor:(NSArray<UIColor *> * _Nonnull)normalColors
                                           highlightedColor:(NSArray<UIColor *> * _Nonnull)highlightedColors;

/**
 创建多个右侧按钮 按钮的标题和颜色以及字体大小可以自定意

 @param normalTitles 不能为空的数组，数组中元素为字符串，创建几个按钮由数组元素个数决定
 @param normalColors 普通状态的颜色，元素要与按钮标题对应
 @param highlightedColors 高亮状态的颜色（可以传nil）元素要与按钮标题对应
 @param fontNumbers 字体大小，以number方式传递，元素要与按钮标题对应
 */
- (void)createNavigationItemsRightBarButtonWithNormalTitles:(NSArray<NSString *> * _Nonnull)normalTitles
                                                normalColor:(NSArray<UIColor *> * _Nonnull)normalColors
                                           highlightedColor:(NSArray<UIColor *> * _Nonnull)highlightedColors
                                                  titleFont:(NSArray<NSNumber *> * _Nonnull)fontNumbers;

/**
 使用图片创建多个导航栏右侧按钮

 @param normalImags 普通状态下的图片数组
 @param highlightedImgs 高亮状态下的图片（可以传nil）要与普通状态的图片一一对应
 */
- (void)createNavigationItemsRightBarButtonWithNormalImg:(NSArray<NSString *> * _Nonnull)normalImags
                                          highlightedImg:(NSArray<NSString *> *)highlightedImgs;

#pragma mark ======= 创建一个右侧按钮
/**
 创建一个右侧按钮 按钮标题和颜色全部自定义

 @param normalTitle normalTitle
 @param normalColor normalTitleColor
 @param highlightedColor highlightedTitleColor
 */
- (void)createNavigationItemRightBarButtonWithNormalTitle:(nonnull NSString *)normalTitle
                                              normalColor:(nonnull UIColor *)normalColor
                                         highlightedColor:(nonnull UIColor *)highlightedColor;

/**
 创建一个右侧按钮 按钮文字颜色默认黑色

 @param normalTitle normalTitle
 */
- (void)createNavigationItemRightBarButtonWithNormalTitle:(nonnull NSString *)normalTitle;

/**
 创建一个右侧按钮 用图片设置按钮

 @param normalImag normalImagNamed
 @param highlightedImg highlightedImgNamed
 */
- (void)createNavigationItemRightBarButtonWithNormalImg:(nonnull NSString *)normalImag
                                         highlightedImg:(NSString *)highlightedImg;

/**
 多个自定义右侧按钮的点击事件

 @param sender 被点击的按钮
 */
- (void)customRightButtonsClicked:(UIButton *)sender;

/**
 右侧按钮点击事件

 @param sedner 右按钮
 */
- (void)navRightButtonClicked:(UIButton *)sedner;

/**
 返回按钮的点击事件
 */
- (void)leftBarButtonClick;
//#pragma mark ======= 自定义左侧按钮
///**
// 创建一个左侧按钮 按钮标题和颜色全部自定义
//
// @param normalTitle normalTitle
// @param highlightedTitle highlightedTitle
// @param normalColor normalTitleColor
// @param highlightedColor highlightedTitleColor
// */
//- (void)createNavigationItemLeftBarButtonWithNormalTitle:(NSString *)normalTitle
//                                         highlightedTitle:(NSString *)highlightedTitle
//                                              normalColor:(UIColor *)normalColor
//                                         highlightedColor:(UIColor *)highlightedColor;
//
///**
// 创建一个左侧按钮 按钮文字颜色默认黑色
//
// @param normalTitle normalTitle
// @param highlightedTitle highlightedTitle
// */
//- (void)createNavigationItemLeftBarButtonWithNormalTitle:(NSString *)normalTitle
//                                         highlightedTitle:(NSString *)highlightedTitle;
//
///**
// 创建一个左侧按钮 用图片设置按钮
//
// @param normalImag normalImagNamed
// @param highlightedImg highlightedImgNamed
// */
//- (void)createNavigationItemLeftBarButtonWithNormalImg:(NSString *)normalImag
//                                         highlightedImg:(NSString *)highlightedImg;
//
//
///**
// 左侧按钮点击事件
//
// @param sedner 左侧按钮
// */
//- (void)navLeftButtonClicked:(UIButton *)sedner;
@end
