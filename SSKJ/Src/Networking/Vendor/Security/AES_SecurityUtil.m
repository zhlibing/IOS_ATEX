//
//  AES_SecurityUtil.m
//  AES加解密(后台使用AES+CBC+NoPadding模式)
//
//  Created by 一介布衣 on 2017/5/5.
//  Copyright © 2017年 HUAMANLOU. All rights reserved.
//

#import "AES_SecurityUtil.h"
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"
#import "BinHexOctUtil.h"



/**
 说明
 * SecretKey：@"16位长度的字符串"   //自行修改
 * gIv： @"16位长度的字符串"        //自行修改
 */
#define SecretKey @"bi_ecology_qwert" //! 加解密的密钥
#define gIv @""       //! 初始向量的值


@implementation AES_SecurityUtil


//!MARK:- 加密
+ (NSString *)aes128EncryptWithContent:(NSString *)plaintext {
    
//    if (plaintext.length < 16) {
//        while (plaintext.length != 16) {
//            plaintext = [plaintext stringByAppendingString:@"\0"];
//        }
//    }else if (plaintext.length > 16 && plaintext.length < 32){
//        while (plaintext.length != 32) {
//            plaintext = [plaintext stringByAppendingString:@"\0"];
//        }
//    }
    
    
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [SecretKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [plaintext dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    int newSize = 0;
    
    if(diff > 0)
    {
        newSize = (int)dataLength + diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x00;
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionECBMode,               //No padding
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    
    
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return  [GTMBase64 stringByEncodingData:resultData]; // 加密为base64
        
//        return [BinHexOctUtil convertDataToHexStr:resultData];    // 加密为16进制
    }
    free(buffer);
    return nil;
}


//!MARK:- 解密
+ (NSString *)aes128DencryptWithContent:(NSString *)ciphertext {
    
//    NSData *data1 = [BinHexOctUtil convertHexStrToData:ciphertext]; // 解密为16进制
    NSData * data1 = [GTMBase64 decodeString:ciphertext];      // 解密为base64
    ciphertext = [GTMBase64 stringByEncodingData:data1];
    
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [SecretKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData *data = [GTMBase64 decodeData:[ciphertext dataUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionECBMode,   //No padding
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        NSString *string = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        NSString *trimmedString = [string stringByReplacingOccurrencesOfString:@"\0" withString:@""];
        return trimmedString;
    }
    free(buffer);
    return nil;
}






@end
