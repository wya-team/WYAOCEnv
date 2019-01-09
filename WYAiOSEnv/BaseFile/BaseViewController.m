//
//  BaseViewController.m
//  WYA_iOS_Scaffold
//
//  Created by 李俊恒 on 2018/7/3.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
/**
 导航栏的底部横线
 */
@property (nonatomic, strong) UIView * navLineView;
/**
 导航栏右侧按钮
 */
@property (nonatomic, strong) UIButton * rightButton;

/**
 导航栏左侧按钮
 */
@property (nonatomic, strong) UIButton * leftButton;
/**
 导航栏标题
 */
@property (nonatomic, strong) UILabel * titleLabel;
@end

@implementation BaseViewController
- (instancetype)init
{
    if (self = [super init]) {
#pragma mark ======= setNav

        [self addtitleWithName:@"微一案"];

        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];

        [self.navigationController.navigationBar addSubview:self.navLineView];

        [self.navigationController.navigationBar setTranslucent:NO];

        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 判断是否需要加返回按钮
    if ([self.navigationController.viewControllers indexOfObject:self] > 0) {
        [self setupLeftBarButton];
    }
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)solveableViewOverrides:(UITableView * _Nonnull)tableView
{
    tableView.autoresizingMask  = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

#pragma mark ======= 初始化配置对象
- (UIView *)navLineView
{
    if (_navLineView == nil) {
        _navLineView                 = [[UIView alloc] initWithFrame:CGRectMake(0, WYANavBarHeight, ScreenWidth, 1)];
        _navLineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _navLineView;
}
- (UIButton *)rightButton
{
    if (_rightButton == nil) {
        _rightButton                          = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.titleLabel.font          = FONT(13);
        _rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateHighlighted];
        [_rightButton addTarget:self action:@selector(navRightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UIButton *)leftButton
{
    if (_leftButton == nil) {
        _leftButton                          = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.titleLabel.font          = FONT(13);
        _leftButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateHighlighted];
        [_leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(navLeftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}
- (void)addtitleWithName:(NSString *)name
{
    _titleLabel                   = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200 * SizeAdapter, 44)];
    _titleLabel.textColor         = [UIColor blackColor];
    _titleLabel.font              = FONT(18);
    _titleLabel.textAlignment     = NSTextAlignmentCenter;
    self.navigationItem.titleView = _titleLabel;
    _titleLabel.text              = name;
}
- (void)setNavTitle:(NSString *)navTitle
{
    _navTitle        = navTitle;
    _titleLabel.text = _navTitle;
}
#pragma mark ======= 自定义返回按钮
#pragma mark - 自定义返回按钮
- (void)setupLeftBarButton
{
    // 自定义 leftBarButtonItem ，UIImageRenderingModeAlwaysOriginal 防止图片被渲染
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                        initWithImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                style:UIBarButtonItemStylePlain
                               target:self
                               action:@selector(leftBarButtonClick)];
    // 防止返回手势失效
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}
#pragma mark - 返回按钮的点击事件
- (void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ======= 自定义添加右侧按钮

- (void)createNavigationItemLeftBarButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
}
/************************************多个右侧按钮自定义创建方法******************************************/
- (void)createNavigationItemsRightBarButtonWithNormalTitle:(NSArray<NSString *> *)normalTitles
{
    NSMutableArray * rightButtonArray = [NSMutableArray array];
    for (int i = 0; i < normalTitles.count; i++) {
        UIButton * customButton               = [UIButton buttonWithType:UIButtonTypeCustom];
        customButton.titleLabel.font          = FONT(13);
        customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [customButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [customButton setTitleColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateHighlighted];
        customButton.tag = i;
        [customButton addTarget:self action:@selector(customRightButtonsClicked:) forControlEvents:UIControlEventTouchUpInside];
        [customButton setTitle:normalTitles[i] forState:UIControlStateNormal];
        [customButton sizeToFit];
        UIBarButtonItem * customBtnItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];

        UIBarButtonItem * fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedSpaceBarButtonItem.width             = self.itemsSpace * SizeAdapter;

        [rightButtonArray addObject:customBtnItem];
        [rightButtonArray addObject:fixedSpaceBarButtonItem];
    }
    [rightButtonArray removeLastObject];
    self.navigationItem.rightBarButtonItems = [rightButtonArray copy];
}

- (void)createNavigationItemsRightBarButtonWithNormalTitles:(NSArray<NSString *> *)normalTitles normalColor:(NSArray<UIColor *> *)normalColors highlightedColor:(NSArray<UIColor *> *)highlightedColors
{
    NSMutableArray * rightButtonArray = [NSMutableArray array];
    for (int i = 0; i < normalTitles.count; i++) {
        UIButton * customButton               = [UIButton buttonWithType:UIButtonTypeCustom];
        customButton.titleLabel.font          = FONT(13);
        customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [customButton setTitleColor:normalColors[i] forState:UIControlStateNormal];
        [customButton setTitleColor:highlightedColors[i] forState:UIControlStateHighlighted];
        customButton.tag = i;
        [customButton addTarget:self action:@selector(customRightButtonsClicked:) forControlEvents:UIControlEventTouchUpInside];
        [customButton setTitle:normalTitles[i] forState:UIControlStateNormal];
        [customButton sizeToFit];
        UIBarButtonItem * customBtnItem           = [[UIBarButtonItem alloc] initWithCustomView:customButton];
        UIBarButtonItem * fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedSpaceBarButtonItem.width             = self.itemsSpace * SizeAdapter;

        [rightButtonArray addObject:customBtnItem];
        [rightButtonArray addObject:fixedSpaceBarButtonItem];
    }
    [rightButtonArray removeLastObject];

    self.navigationItem.rightBarButtonItems = [rightButtonArray copy];
}

- (void)createNavigationItemsRightBarButtonWithNormalTitles:(NSArray<NSString *> *)normalTitles normalColor:(NSArray<UIColor *> *)normalColors highlightedColor:(NSArray<UIColor *> *)highlightedColors titleFont:(NSArray<NSNumber *> *)fontNumbers
{
    NSMutableArray * rightButtonArray = [NSMutableArray array];
    for (int i = 0; i < normalTitles.count; i++) {
        UIButton * customButton               = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat font                          = [fontNumbers[i] floatValue];
        customButton.titleLabel.font          = FONT(font);
        customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [customButton setTitleColor:normalColors[i] forState:UIControlStateNormal];
        [customButton setTitleColor:highlightedColors[i] forState:UIControlStateHighlighted];
        customButton.tag = i;
        [customButton addTarget:self action:@selector(customRightButtonsClicked:) forControlEvents:UIControlEventTouchUpInside];
        [customButton setTitle:normalTitles[i] forState:UIControlStateNormal];
        [customButton sizeToFit];
        UIBarButtonItem * customBtnItem           = [[UIBarButtonItem alloc] initWithCustomView:customButton];
        UIBarButtonItem * fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedSpaceBarButtonItem.width             = self.itemsSpace * SizeAdapter;

        [rightButtonArray addObject:customBtnItem];
        [rightButtonArray addObject:fixedSpaceBarButtonItem];
    }
    [rightButtonArray removeLastObject];

    self.navigationItem.rightBarButtonItems = [rightButtonArray copy];
}
- (void)createNavigationItemsRightBarButtonWithNormalImg:(NSArray<NSString *> *)normalImags highlightedImg:(NSArray<NSString *> *)highlightedImgs
{
    NSMutableArray * rightButtonArray = [NSMutableArray array];
    for (int i = 0; i < normalImags.count; i++) {
        UIButton * customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [customButton setImage:[UIImage imageNamed:normalImags[i]] forState:UIControlStateNormal];
        if (highlightedImgs) {
            [customButton setImage:[UIImage imageNamed:highlightedImgs[i]] forState:UIControlStateHighlighted];
        }
        customButton.tag = i;
        [customButton addTarget:self action:@selector(customRightButtonsClicked:) forControlEvents:UIControlEventTouchUpInside];
        [customButton sizeToFit];
        UIBarButtonItem * customBtnItem           = [[UIBarButtonItem alloc] initWithCustomView:customButton];
        UIBarButtonItem * fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedSpaceBarButtonItem.width             = self.itemsSpace * SizeAdapter;

        [rightButtonArray addObject:customBtnItem];
        [rightButtonArray addObject:fixedSpaceBarButtonItem];
    }
    [rightButtonArray removeLastObject];

    self.navigationItem.rightBarButtonItems = [rightButtonArray copy];
}
/************************************一个右侧按钮自定义创建方法******************************************/
- (void)createNavigationItemRightBarButtonWithNormalTitle:(NSString *)normalTitle
{
    [self.rightButton setTitle:normalTitle forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
}
- (void)createNavigationItemRightBarButtonWithNormalTitle:(NSString *)normalTitle normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor
{
    [self.rightButton setTitle:normalTitle forState:UIControlStateNormal];

    [self.rightButton setTitleColor:normalColor forState:UIControlStateNormal];
    [self.rightButton setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
}
- (void)createNavigationItemRightBarButtonWithNormalImg:(NSString *)normalImag highlightedImg:(NSString *)highlightedImg
{
    UIButton * customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton addTarget:self action:@selector(navRightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [customButton sizeToFit];
    [customButton setImage:[UIImage imageNamed:normalImag] forState:UIControlStateNormal];
    if (highlightedImg) {
        [customButton setImage:[UIImage imageNamed:highlightedImg] forState:UIControlStateHighlighted];
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
}
/************************************左侧按钮自定义创建方法******************************************/
//- (void)createNavigationItemLeftBarButtonWithNormalTitle:(NSString *)normalTitle highlightedTitle:(NSString *)highlightedTitle{
//    self.navigationItem.leftBarButtonItem = nil;
//
//    [self.leftButton setTitle:normalTitle forState:UIControlStateNormal];
//    [self.leftButton setTitle:highlightedTitle forState:UIControlStateHighlighted];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftButton];
//
//}
//- (void)createNavigationItemLeftBarButtonWithNormalTitle:(NSString *)normalTitle highlightedTitle:(NSString *)highlightedTitle normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor
//{
//    [self.leftButton setTitle:normalTitle forState:UIControlStateNormal];
//    [self.leftButton setTitle:highlightedTitle forState:UIControlStateHighlighted];
//
//    [self.leftButton setTitleColor:normalColor forState:UIControlStateNormal];
//    [self.leftButton setTitleColor:highlightedColor forState:UIControlStateHighlighted];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftButton];
//
//}
//- (void)createNavigationItemLeftBarButtonWithNormalImg:(NSString *)normalImag highlightedImg:(NSString *)highlightedImg
//{
//    [self.leftButton setImage:[UIImage imageNamed:normalImag] forState:UIControlStateNormal];
//    [self.leftButton setImage:[UIImage imageNamed:highlightedImg] forState:UIControlStateHighlighted];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftButton];
//}
#pragma mark ======= 自定义导航栏的Action
- (void)customRightButtonsClicked:(UIButton *)sender
{
}
- (void)navRightButtonClicked:(UIButton *)sender
{
}
/**
 文字或者图片定制更强的返回按钮点击事件
 */
- (void)navLeftButtonClicked:(UIButton *)sedner
{
}
#pragma mark ======= config
- (void)setViewBackGroundColor:(UIColor *)viewBackGroundColor
{
    if (viewBackGroundColor) {
        _viewBackGroundColor      = viewBackGroundColor;
        self.view.backgroundColor = viewBackGroundColor;
    }
}
- (void)setNavTitleFont:(CGFloat)navTitleFont
{
    if (navTitleFont) {
        _navTitleFont        = navTitleFont;
        self.titleLabel.font = FONT(_navTitleFont);
    }
}
- (void)setNavTitleColor:(UIColor *)navTitleColor
{
    if (navTitleColor) {
        _navTitleColor            = navTitleColor;
        self.titleLabel.textColor = _navTitleColor;
    }
}
- (void)setNavBackGroundColor:(UIColor *)navBackGroundColor
{
    if (navBackGroundColor) {
        _navBackGroundColor                                  = navBackGroundColor;
        self.navigationController.navigationBar.barTintColor = _navBackGroundColor;
    }
}
- (void)setNavBackGroundImageNamed:(NSString *)navBackGroundImageNamed
{
    if (navBackGroundImageNamed) {
        _navBackGroundImageNamed = navBackGroundImageNamed;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:_navBackGroundImageNamed] forBarMetrics:UIBarMetricsDefault];
    }
}
- (void)setIsShowNavLine:(BOOL)isShowNavLine
{
    _isShowNavLine = isShowNavLine;
    if (!_isShowNavLine) {
        [self.navLineView removeFromSuperview];
    }
}
- (void)setLeftBarButtonItemTitleFont:(CGFloat)leftBarButtonItemTitleFont
{
    if (leftBarButtonItemTitleFont) {
        _leftBarButtonItemTitleFont     = leftBarButtonItemTitleFont;
        self.leftButton.titleLabel.font = FONT(_leftBarButtonItemTitleFont);
    }
}
- (void)setRightBarButtonItemTitleFont:(CGFloat)rightBarButtonItemTitleFont
{
    if (rightBarButtonItemTitleFont) {
        _rightBarButtonItemTitleFont     = rightBarButtonItemTitleFont;
        self.rightButton.titleLabel.font = FONT(_rightBarButtonItemTitleFont);
    }
}
//- (void)setItemsSpace:(CGFloat)itemsSpace
//{
//    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    fixedSpaceBarButtonItem.width = itemsSpace*SizeAdapter;
//    NSMutableArray * array = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
//    for (int i = 0 ; i < array.count; i++) {
//        [array insertObject:fixedSpaceBarButtonItem atIndex:i];
//    }
//}
@end
