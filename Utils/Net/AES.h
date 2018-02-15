//
//  AES.h
//  AppUtils
//
//  Created by shuaitong du on 2018/2/13.
//  Copyright © 2018年 田守彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AES : NSObject
// 解密
+ (NSData *)AESDencryptText:(NSString *)text;
// 加密
+ (NSString *)AESEncryptText:(NSString *)text;
@end
