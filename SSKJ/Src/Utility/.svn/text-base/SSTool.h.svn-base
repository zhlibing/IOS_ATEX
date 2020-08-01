//
//  SSTool.h
//  SSKJ
//
//  Created by zpz on 2019/9/11.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSTool : NSObject

#pragma mark - 图片URL处理
+ (NSURL*)imageURLWithURL:(NSString *)imageURL;

#pragma mark - 账号安全显示处理
+ (NSString *)accountSafe:(NSString *)sender;

#pragma mark - MB提示
+ (void)success:(NSString *)str;
+ (void)error:(NSString *)str;
+ (void)show;
+ (void)dismiss;

#pragma mark - 页面效果
+(BOOL)isRoot;
+(void)setIsRoot:(BOOL)isRoot;

#pragma mark - 是否有区号
/**
 是否有区号
 */
+(BOOL)isInternationalization;
+(void)setAreaCode:(NSArray *)array;
+(NSArray *)getAreaCode;
+(void)setMyAreaCode:(NSString *)sender;
+(NSString *)myAreaCode;



#pragma mark - 合约小数位处理

+(NSString *)HeyuePname:(NSString *)pname price:(id)price;//保证金 手续费等
+(NSString *)HeyueCoin:(NSString *)pname price:(id)price;//交易对
+(NSInteger)HeyuePname:(NSString *)pname;


#pragma mark - 法币小数位处理
/**
 处理小数位
 
 @param price 需要转换的价格
 @return 转换后的价格
 */
+(NSString *)FBPrice:(id)price;


#pragma mark - 行情小数位处理

+(NSString *)MarketPname:(NSString *)pname price:(id)price;
+(NSString *)MarketPname:(NSString *)pname num:(id)num;
+(NSInteger)MarketNum:(NSString *)pname;
+(NSInteger)MarketPrice:(NSString *)pname;

#pragma mark - 资产小数位处理
+(NSString *)MinePname:(NSString *)pname price:(id)price;


#pragma mark - 币币小数位处理
+(NSString *)BBPname:(NSString *)pname price:(id)price;
+(NSString *)BBPname:(NSString *)pname num:(id)num;
+(NSInteger)BBNum:(NSString *)pname;
+(NSInteger)BBPrice:(NSString *)pname;
//+(NSString *)BBPname:(NSString *)pname total:(id)totalMoney;
#pragma mark - 小数位处理
/**
 处理小数位.去零
 */
+(NSString *)disposePname:(id)pname price:(id)price;

/**
 处理小数位.补零
 */
+(NSString *)disposeZeroPname:(id)pname price:(id)price;

+(NSString *)disposeMaxNum:(NSString *)num;


+(NSString *)add:(NSString *)str1 with:(NSString *)str2;
+(NSString *)subtract:(NSString *)str1 with:(NSString *)str2;
+(NSString *)multiply:(NSString *)str1 with:(NSString *)str2;
+(NSString *)divide:(NSString *)str1 with:(NSString *)str2;

@end

NS_ASSUME_NONNULL_END
