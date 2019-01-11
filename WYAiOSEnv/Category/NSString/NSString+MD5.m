//
//  NSString+MD5.m
//  WYA_iOS_Scaffold
//
//  Created by 李俊恒 on 2018/7/6.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)
- (NSString *)md5WithString {
    if (self == nil || [self length] == 0) {
        return nil;
    }

    const char * value = [self UTF8String];

    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);

    NSMutableString * outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++) {
        [outputString appendFormat:@"%02x", outputBuffer[count]];
    }

    return outputString;
}

- (NSString *)to16MD5 {
    if (self == nil || [self length] == 0) {
        return nil;
    }

    return [[self md5WithString] substringWithRange:NSMakeRange(8, 16)];
}

- (NSString *)sha1 {
    if (self == nil || [self length] == 0) {
        return nil;
    }

    unsigned char digest[CC_SHA1_DIGEST_LENGTH], i;
    CC_SHA1([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString * ms = [NSMutableString string];

    for (i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }

    return [ms copy];
}

- (NSString *)sha256 {
    if (self == nil || [self length] == 0) {
        return nil;
    }

    unsigned char digest[CC_SHA256_DIGEST_LENGTH], i;
    CC_SHA256([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString * ms = [NSMutableString string];

    for (i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }

    return [ms copy];
}

- (NSString *)sha512 {
    if (self == nil || [self length] == 0) {
        return nil;
    }

    unsigned char digest[CC_SHA512_DIGEST_LENGTH], i;
    CC_SHA512([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString * ms = [NSMutableString string];

    for (i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }

    return [ms copy];
}

@end
