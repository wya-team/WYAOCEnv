//
//  UIButton+Category.h
//  WYA_iOS_Scaffold
//
//  Created by 李俊恒 on 2018/7/6.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonActionCallBack)(UIButton * button);

@interface UIButton (Category)

- (void)addCallBackAction:(ButtonActionCallBack)action
         forControlEvents:(UIControlEvents)controlEvents;

- (void)addCallBackAction:(ButtonActionCallBack)action;

@end

@interface UIButton (EnlargeTouchArea)

/**
 *  扩大 UIButton 的點擊範圍
 *  控制上下左右的延長範圍
 *
 *  @param top    <#top description#>
 *  @param right  <#right description#>
 *  @param bottom <#bottom description#>
 *  @param left   <#left description#>
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

/**
 设置图片在右，需先指定button.frame
 
 @param space 间距
 */
- (void)setImageLoctionRightWithSpace:(CGFloat)space;

/**
 设置图片在上，需先指定button.frame
 
 @param space 间距
 */
- (void)setImageLocationTopWithSpace:(CGFloat)space;

/**
 设置图片在下，需先指定button.frame
 
 @param space 间距
 */
- (void)setImageLocationBottomWithSpace:(CGFloat)space;

@end
