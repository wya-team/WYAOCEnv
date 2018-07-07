//
//  NSString+Predicate.h
//  WYA_iOS_Scaffold
//
//  Created by 李俊恒 on 2018/7/6.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Predicate)

/**
 有效的电话号码

 @return YES or NO
 */
- (BOOL) isValidMobileNumber;


/**
 是否是由字母数字下划线中文组成2位到8位

 @return YES or NO
 */
- (BOOL) isValidRealName;


/**
 是否只有中文

 @return YES or NO
 */
- (BOOL) isOnlyChinese;


/**
 有效的验证码(根据需求进行位数修改)这里是4位

 */
- (BOOL) isValidVerifyCode;


/**
 有效的银行卡号

 */
- (BOOL) isValidBankCardNumber;


/**
 有效的邮箱

 */
- (BOOL) isValidEmail;


/**
 有效的字母数字密码
 */
- (BOOL) isValidAlphaNumberPassword;

/**
 检测有效身份证 15位
 */
- (BOOL) isValidIdentifyFifteen;


/**
 检测有效身份证 18位
 */
- (BOOL) isValidIdentifyEighteen;


/**
 限制只能输入数字
 */
- (BOOL) isOnlyNumber;
@end
