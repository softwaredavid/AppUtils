//
//  AES.m
//  AppUtils
//
//  Created by shuaitong du on 2018/2/13.
//  Copyright © 2018年 田守彬. All rights reserved.
//

#import "AES.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>


#define AES_PASSWORD @"Kdu3KL921GcmKweSjvlfpksdnjfhzo423532"
static Byte saltBuff[] = {104,81,98,111,75,56,66,50,118,89,51,114,76,112,50,73};
static Byte  ivBuff[] =  {104,81,98,111,75,56,66,50,118,89,51,114,76,112,50,73};

/*//条形码和二维码
#define PASSWORD1 @"mKweSjdu3Kp678KLsdlfoPKiumjvghz98512"
static Byte saltBuff1[] = {104,49,50,51,52,118,56,114,98,73,76,111,66,89,112,81};
static Byte  ivBuff1[] =  {104,49,50,51,52,118,56,114,98,73,76,111,66,89,112,81};

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";*/

const NSUInteger kAlgorithmKeySize = kCCKeySizeAES256;
// ~80ms on an iPhone 4
const NSUInteger kPBKDFRounds = 10000;
const NSUInteger kPBKDFRounds1 = 10000;


@implementation AES

+ (NSData *)AESPass:(NSString *)password {
    NSMutableData *derivedKey = [NSMutableData
                                 dataWithLength:kCCKeySizeAES256];
    
    NSData *salt = [NSData dataWithBytes:saltBuff
                                  length:kCCKeySizeAES128];
    
    CCKeyDerivationPBKDF(kCCPBKDF2,        // algorithm算法
                         password.UTF8String,  // password密码
                         password.length,      // passwordLength密码的长度
                         salt.bytes,           // salt内容
                         salt.length,          // saltLen长度
                         kCCPRFHmacAlgSHA1,    // PRF
                         kPBKDFRounds,         // rounds循环次数
                         derivedKey.mutableBytes, // derivedKey
                         derivedKey.length);   // derivedKeyLen derive:出自
    return derivedKey;
}
/*
 * AES加密
 */
+ (NSString *)AESEncryptText:(NSString *)text {
    
    NSData *plainText = [text dataUsingEncoding:NSUTF8StringEncoding];
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    NSUInteger dataLength = [plainText length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    bzero(buffer, sizeof(buffer));
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          [[AES AESPass:AES_PASSWORD] bytes],
                                          kCCKeySizeAES256,
                                          ivBuff ,
                                          [plainText bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
        NSString *str = [NSString stringWithFormat:@"%@",encryptData.description];
        NSString *mstr = [str stringByReplacingOccurrencesOfString:@"<" withString:@""];
        NSString *mstr2 = [mstr stringByReplacingOccurrencesOfString:@">" withString:@""];
        NSString *mstr3 = [mstr2 stringByReplacingOccurrencesOfString:@" " withString:@""];
        return mstr3;
    }
    free(buffer);
    return nil;
}
//解密
+ (NSData *)AESDencryptText:(NSString *)text {
    
    NSData *cipherData = [AES stringToByte:text];
    
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    NSUInteger dataLength = [cipherData length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          [[AES AESPass:AES_PASSWORD] bytes],
                                          kCCKeySizeAES256,
                                          ivBuff,
                                          [cipherData bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        return encryptData;
    }
    
    free(buffer);
    return nil;
}
+ (NSData*)stringToByte:(NSString*)string {
    NSString *hexString=[[string uppercaseString]
                         stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([hexString length] %2 != 0) {
        return nil;
    }
    Byte tempbyt[1] = {0};
    NSMutableData* bytes=[NSMutableData data];
    
    for(int i=0; i<[hexString length]; i++) {
        // 两位16进制数中的第一位(高位*16)
        unichar hex_char1 = [hexString characterAtIndex:i];
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9') { // 0 的Ascll - 48
            int_ch1 = (hex_char1-48)*16;
        }
        else if(hex_char1 >= 'A' && hex_char1 <='F') { // A 的Ascll - 65
            int_ch1 = (hex_char1-55)*16;
        }
        else {
            return nil;
        }
        i++;
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if (hex_char2 >= '0' && hex_char2 <='9') {
            int_ch2 = (hex_char2-48); // 0 的Ascll - 48
        }
        else if (hex_char2 >= 'A' && hex_char2 <='F') {
            int_ch2 = hex_char2-55; // A 的Ascll - 65
        }
        else {
            return nil;
        }
        tempbyt[0] = int_ch1+int_ch2;  //将转化后的数放入Byte数组里
        [bytes appendBytes:tempbyt length:1];
    }
    return bytes;
}
@end
