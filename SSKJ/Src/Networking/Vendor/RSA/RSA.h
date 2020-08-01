/*
 @author: ideawu
 @link: https://github.com/ideawu/Objective-C-RSA
*/

#import <Foundation/Foundation.h>

#define PrivateKeyPassword @"123456Aa"

@interface RSA : NSObject

// 返回base64编码的字符串  公钥加密
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;

// 公钥加密（文件）
+ (NSString *)encryptString:(NSString *)str publicKeyPath:(NSString *)pubKeyPath;

+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;

// 返回原始数据
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;
// 返回base64编码的字符串 私钥加密
+ (NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSString *)encryptString:(NSString *)str privateKeyPath:(NSString *)privKeyPath;
// 返回原始数据
+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey;

// 解密base64编码的字符串，将结果转换为字符串(非base64编码)
// 公钥解密
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;
// 公钥解密(文件)
+ (NSString *)decryptString:(NSString *)str publicKeyPath:(NSString *)pubKeyPath;

+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;
// 私钥解密
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
// 私钥解密(文件)
+ (NSString *)decryptString:(NSString *)str privateKeyPath:(NSString *)privKeyPath;

+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;








@end
