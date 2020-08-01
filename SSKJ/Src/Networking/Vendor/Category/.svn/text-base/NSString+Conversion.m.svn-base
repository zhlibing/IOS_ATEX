//
//  NSString+Conversion.m
//  MIT-AffordSuperMarket
//
//  Created by apple on 15/11/28.
//  Copyright © 2015年 河南大实惠电子商务有限公司. All rights reserved.
//

#import "NSString+Conversion.h"
@implementation NSString (Conversion)
//把空字符串转换成 @“”
+ (NSString*)stringISNull:(NSString*)_str {
    if (_str.length == 0 || _str == nil || _str == NULL  )
    {
        return @"";
    }
    return _str;
}

//判断字符串是否可用(可能是整型)
+ (NSString*)stringTransformObject:(id)object {
    NSString *str = @"";
    if ([object isKindOfClass:[NSNumber class]]) {
        str = [object stringValue];
    } else if([object isKindOfClass:[NSNull class]]){
        str = @"";
    } else {
        str = (NSString*)object;
    }
    return [self stringISNull:str];
}

//判断小数点后数字是否以0结尾
+ (NSString*)marketLastTwoByteOfStringIsZero:(NSString*)_str
{
    if ([_str doubleValue] == 0|| [_str isEqualToString:@"0"] || [_str isEqualToString:@"0.0"] || [_str isEqualToString:@"0.00"])
    {
        return @"0";
    }
    
    NSRange range = [_str rangeOfString:@"."];
    
    if (range.length == 0 || range.location == 0)//没有小数点的str
    {
        return _str;
    }
    
    NSInteger lastOfStringLocation = range.location+1;//小数点后面第一位数下标
    NSInteger subLength = _str.length - lastOfStringLocation;//小数点后长度
    
    //小数点后字符串
    NSString * lastOfString = [_str substringWithRange:NSMakeRange(lastOfStringLocation, subLength)];
    
    NSInteger cubLength = 0;//计算小数点最后出现O的位置
    for (NSInteger i = subLength -1; i>=0; i--) {
        NSString *subStr = [lastOfString substringWithRange:NSMakeRange(i, 1)];
        if ([subStr isEqualToString:@"0"])
        {
            cubLength ++;
        }
        else
        {
            break;
        }
    }
    NSString *newString = nil;
    if (cubLength !=0)
    {
        if(subLength== cubLength){
            newString = [_str substringWithRange:NSMakeRange(0, _str.length-cubLength-1)];
        }else{
            newString = [_str substringWithRange:NSMakeRange(0, _str.length-cubLength)];
        }
        
        return newString;
    }
    
    return _str;
    
}

//转换图片路径
+ (NSString*)appendImageUrl:(NSString*)imageUrl {
    
    return [NSString stringWithFormat:@"%@%@",ImageBaseServer,imageUrl];
}

//把秒转换成时分秒
+(NSString*)getHHMMSSFromS:(NSString *)totalTime {
    NSInteger seconds = [totalTime integerValue];
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = @"";
    if ([str_hour isEqualToString:@"00"]) {
        format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    } else {
        format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    }
    return format_time;
}


+ (NSString*)numConversionWithStr:(NSString*)unitNum {
    
    NSString *nullStr = @"0";
    double   numDb = 0;
    double   nNumDouble = unitNum.doubleValue;
    
    if (nNumDouble == 0)
    {
        return nullStr;
    }
    
    if (nNumDouble >= 10000000000.0 || nNumDouble <= -10000000000.0) {
        numDb = nNumDouble/100000000.0;
        nullStr = [NSString stringWithFormat:@"%.0f亿",numDb];
    }else if (nNumDouble >= 1000000000.0 || nNumDouble <= -1000000000.0) {
        numDb = nNumDouble/100000000.0;
        nullStr = [NSString stringWithFormat:@"%.1f亿",numDb];
    }else if (nNumDouble >= 100000000 || nNumDouble <= -100000000) {
        numDb = nNumDouble/100000000;
        nullStr = [NSString stringWithFormat:@"%.2f亿",numDb];
    }else if(nNumDouble >= 1000000 || nNumDouble <= -1000000){
        numDb = nNumDouble/10000;
        nullStr = [NSString stringWithFormat:@"%.0f万",numDb];
    }else if(nNumDouble >= 100000 || nNumDouble <= -100000){
        numDb = nNumDouble/10000;
        nullStr = [NSString stringWithFormat:@"%.1f万",numDb];
    }
    //    else if(nNumDouble >= 10000){
    //        numDb = nNumDouble/10000;
    //        nullStr = [NSString stringWithFormat:@"%.2f万",numDb];
    //    }
    else {
        nullStr = unitNum;
    }
    
    return nullStr;
}
//转换地址格式
+(NSString*)convertAddress:(NSString*)address {
    NSArray *addressArr = [address componentsSeparatedByString:@","];
    return [addressArr componentsJoinedByString:@" "];

}

+(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

+(NSString*)YAxisConversionWithStr:(NSString*)unitNum
{
    NSString *nullStr = @"";
    double   numDb = 0;
    double   nNumDouble = unitNum.doubleValue;
    
    if (nNumDouble == 0)
    {
        return unitNum;
    }
    
    if (nNumDouble >= 10000000000.0) {
        numDb = nNumDouble/100000000.0;
        nullStr = [NSString stringWithFormat:@"%.0f亿",numDb];
    }else if (nNumDouble >= 1000000000.0) {
        numDb = nNumDouble/100000000.0;
        nullStr = [NSString stringWithFormat:@"%.1f亿",numDb];
    }else if (nNumDouble >= 100000000) {
        numDb = nNumDouble/100000000;
        nullStr = [NSString stringWithFormat:@"%.2f亿",numDb];
    }else if(nNumDouble >= 1000000){
        numDb = nNumDouble/10000;
        nullStr = [NSString stringWithFormat:@"%.0f万",numDb];
    }else if(nNumDouble >= 100000){
        numDb = nNumDouble/10000;
        nullStr = [NSString stringWithFormat:@"%.1f万",numDb];
    }
    //    else if(nNumDouble >= 10000){
    //        numDb = nNumDouble/10000;
    //        nullStr = [NSString stringWithFormat:@"%.2f万",numDb];
    //    }
    else {
        nullStr = unitNum;
    }
    
    return nullStr;
}

//判断小数点后数字是否以0结尾
+ (NSString*)lastTwoByteOfStringIsZero:(NSString*)_str {
    
    if ([_str doubleValue] == 0|| [_str isEqualToString:@"0"] || [_str isEqualToString:@"0.0"] || [_str isEqualToString:@"0.00"]){
        
    }
    
    NSRange range = [_str rangeOfString:@"."];
    
    if (range.length == 0 || range.location == 0)//没有小数点的str
    {
        return _str;
    }
    
    NSInteger lastOfStringLocation = range.location+1;
    NSInteger subLength = _str.length - lastOfStringLocation;
    
    //小数点后字符串
    NSString * lastOfString = [_str substringWithRange:NSMakeRange(lastOfStringLocation, subLength)];
    
    int cubLength = 0;
    for (NSInteger i = subLength -1; i>=0; i--) {
        NSString *subStr = [lastOfString substringWithRange:NSMakeRange(i, 1)];
        if ([subStr isEqualToString:@"0"])
        {
            cubLength ++;
        }
        else
        {
            break;
        }
    }
    NSString *newString = nil;
    if (cubLength !=0)
    {
        if(subLength== cubLength){
            newString = [_str substringWithRange:NSMakeRange(0, _str.length-cubLength-1)];
        }else{
            newString = [_str substringWithRange:NSMakeRange(0, _str.length-cubLength)];
        }
        
        return newString;
    }
    
    return _str;
    
}
//计算小数点有几位
+ (NSString*)decimalPrecisionWithString:(NSString*)_str
{
    NSRange range = [_str rangeOfString:@"."];
    if (range.length == 0 || range.location == 0)
    {//没有小数点的str
        return @"0";
    }
    NSInteger lastOfStringLocation = range.location+1;
    NSInteger subLength = _str.length - lastOfStringLocation;
    return [NSString stringWithFormat:@"%ld",(long)subLength];
}
//获取当前日期
+ (NSString*)getCurrentDate {
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}
//格式化时间
+(NSString*)formateDate:(NSString*)datastring {
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"YYYY-MM-dd"];
    NSDate * formatDate = [dateFormatter1 dateFromString:datastring];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"YYYYMMdd"];
    return [dateFormatter2 stringFromDate:formatDate];
    
}

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYYMMdd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

//获取n天前的日期
+ (NSString*)getBeforeOfNDay:(NSDate *)date withDay:(int)day{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:-day];
    NSDate *dateAfterday = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    NSString *strDate = [formatter stringFromDate:dateAfterday];
    return strDate;
    
}
//获取日期时间通过时间戳
+ (NSString*)getDateWithTimestamp:(NSString*)timestamp {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
//计算涨停价
//+(NSString *)limitUpPriceWithClosePrice:(NSString*)closePrice {
//    SystemBaseInfoModel *systemBaseInfoModel = [[ManagerGlobeUntil sharedManager] getSystemBaseInfo];
//    double maxPriceFloatRate = 1 + [systemBaseInfoModel.maxPriceFloatRate doubleValue]/100;
//    NSString *decimaNumber = [self decimalPrecisionWithString:closePrice];
//    double limitUpPrice = closePrice.doubleValue * maxPriceFloatRate;
//    NSString* format = [NSString stringWithFormat:@"%%.%ldf",(long)decimaNumber.integerValue];
//    return  [NSString stringWithFormat:format,limitUpPrice];
//}
//计算跌停价
//+(NSString *)limitDownPriceWithClosePrice:(NSString*)closePrice {
//    SystemBaseInfoModel *systemBaseInfoModel = [[ManagerGlobeUntil sharedManager] getSystemBaseInfo];
//    double maxPriceFloatRate = 1- [systemBaseInfoModel.maxPriceFloatRate doubleValue]/100;
//    NSString *decimaNumber = [self decimalPrecisionWithString:closePrice];
//    double limitDownPrice = closePrice.doubleValue * maxPriceFloatRate;
//    NSString* format = [NSString stringWithFormat:@"%%.%ldf",(long)decimaNumber.integerValue];
//    return  [NSString stringWithFormat:format,limitDownPrice];
//}
//获取商品代码
+(NSString *)goodsNameWithGoodsCode:(NSString*)goodsCode {
    if ([goodsCode isEqualToString:@"GC1802"]) {
        return @"黄金02(主力)";
    } else if ([goodsCode isEqualToString:@"GC1712"]) {
        return @"黄金12";
    } else if ([goodsCode isEqualToString:@"CL1801"]) {
        return @"原油01(主力)";
    } else if ([goodsCode isEqualToString:@"CL1802"]) {
        return @"原油02";
    } else if ([goodsCode isEqualToString:@"SI1803"]) {
        return @"白银03(主力)";
    } else if ([goodsCode isEqualToString:@"SI1712"]) {
        return @"白银12";
    }
    return @"";
}
//获取商品图片名字
+(NSString *)goodsImageNameWithGoodsCode:(NSString*)goodsCode {
    if ([goodsCode isEqualToString:@"GC1802"] || [goodsCode isEqualToString:@"GC1712"]) {
        return @"market_gc";
    } else if ([goodsCode isEqualToString:@"CL1801"] || [goodsCode isEqualToString:@"CL1802"]) {
        return @"market_cl";
    } else if ([goodsCode isEqualToString:@"SI1803"] || [goodsCode isEqualToString:@"SI1712"]) {
        return @"market_si";
    } 
    return @"";
}
//格式化数据根据小数个数
+(NSString*)formateString:(NSString*)string decimalCount:(NSInteger)decimalCOunt {
    NSString* format = [NSString stringWithFormat:@"%%.%ldf",(long)decimalCOunt];
    return  [NSString stringWithFormat:format,string];
}


+(NSString *)hidePhoneMiddleNumberWithMobile:(NSString *)mobile
{
    if (mobile.length == 0)
    {
        return @"";
    }
    else if (mobile.length != 11)
    {
        return mobile;
    }
    else
    {
        return [mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
}



@end
