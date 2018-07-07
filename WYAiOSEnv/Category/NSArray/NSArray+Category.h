//
//  NSArray+Category.h
//  WYA_iOS_Scaffold
//
//  Created by 李俊恒 on 2018/7/4.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Category)

/**
 数组转成json 字符串

 @return json字符串
 */
- (NSString *)transToJSONString;
@end
