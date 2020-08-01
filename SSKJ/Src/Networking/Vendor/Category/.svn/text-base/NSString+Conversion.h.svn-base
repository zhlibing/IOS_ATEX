//
//  NSString+Conversion.h
//  MIT-AffordSuperMarket
//
//  Created by apple on 15/11/28.
//  Copyright © 2015年 河南大实惠电子商务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Conversion)
//把空字符串转换成 @“”
+ (NSString*)stringISNull:(NSString*)_str;
//判断字符串是否可用(可能是整型)
+ (NSString*)stringTransformObject:(id)object;
+ (NSString*)numConversionWithStr:(NSString*)unitNum;
//判断字符串最后两位是否是0
+ (NSString*)marketLastTwoByteOfStringIsZero:(NSString*)_str;
//计算小数点有几位
+ (NSString*)decimalPrecisionWithString:(NSString*)_str;
//转换图片路径
+ (NSString*)appendImageUrl:(NSString*)imageUrl;
//获取当前日期
+ (NSString*)getCurrentDate;
//把秒转换成时分秒
+(NSString*)getHHMMSSFromS:(NSString *)totalTime;
//格式化时间
+(NSString*)formateDate:(NSString*)datastring;
//把时间戳转换成日期
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;
//获取n天前日期
+ (NSString*)getBeforeOfNDay:(NSDate *)date withDay:(int)day;
//获取日期时间通过时间戳
+ (NSString*)getDateWithTimestamp:(NSString*)timestamp;
//转换地址格式
+(NSString*)convertAddress:(NSString*)address;
//转码字符串
+(NSString *)URLDecodedString:(NSString *)str;
+ (NSString*)YAxisConversionWithStr:(NSString*)unitNum;
+ (NSString*)lastTwoByteOfStringIsZero:(NSString*)_str;
//交易类型转换
//+(NSString*)
//计算涨停价
//+(NSString *)limitUpPriceWithClosePrice:(NSString*)closePrice;
////计算跌停价
//+(NSString *)limitDownPriceWithClosePrice:(NSString*)closePrice;
//获取商品代码
+(NSString *)goodsNameWithGoodsCode:(NSString*)goodsCode;
//获取商品图片名字
+(NSString *)goodsImageNameWithGoodsCode:(NSString*)goodsCode;
//格式化数据根据小数个数
+(NSString*)formateString:(NSString*)string decimalCount:(NSInteger)decimalCOunt;

+(NSString *)hidePhoneMiddleNumberWithMobile:(NSString *)mobile;
@end
