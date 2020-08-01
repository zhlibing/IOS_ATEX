//
//  SSTool.m
//  SSKJ
//
//  Created by zpz on 2019/9/11.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSTool.h"

@implementation SSTool


+ (void)success:(NSString *)str
{
    [MBProgressHUD showSuccess:str];
}

+ (void)error:(NSString *)str
{
    [MBProgressHUD showError:str];
}

+ (void)show
{
    [self dismiss];
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
}

+ (void)dismiss
{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

+ (NSString *)accountSafe:(NSString *)sender{
    if (!sender.length) {
        return @"";
    }
    if ([sender containsString:@"@"]) {
        return sender;
    }
//    NSInteger mid = sender.length * 0.5;
//    NSInteger length = mid * 0.5;
//
//    NSString *temp = [@"****************************" substringToIndex:length * 2];
//
//    return [sender stringByReplacingCharactersInRange:NSMakeRange(mid - length, length * 2) withString:temp];
    
    if (sender.length < 5) {
        return sender;
    }
    
    NSInteger mid = sender.length * 0.5;
    return [sender stringByReplacingCharactersInRange:NSMakeRange(mid - 2, 4) withString:@"****"];
}

+ (NSURL*)imageURLWithURL:(NSString *)imageURL
{
    if (![imageURL containsString:@"http"]) {
        if ([imageURL hasPrefix:@"/"]) {
            imageURL = [NSString stringWithFormat:@"%@%@",ImageBaseServer,imageURL];
        }else{
            imageURL = [NSString stringWithFormat:@"%@/%@",ImageBaseServer,imageURL];
        }
    }
    return [NSURL URLWithString:imageURL];
}


+(BOOL)isInternationalization{
    return YES;
}


+ (BOOL)isRoot{
    
    BOOL result;
    [[self getStringByKey:@"isRoot"] isEqualToString:@"yes"] ? (result = YES) : (result = NO);
    return result;
}

+ (void)setAreaCode:(NSArray *)array{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:array forKey:@"areacode"];
    [def synchronize];
}

+ (NSArray *)getAreaCode{
    return [self getStringByKey:@"areacode"];
}

+ (void)setMyAreaCode:(NSString *)sender{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:sender forKey:@"myAreaCode"];
    [def synchronize];
}

+ (NSString *)myAreaCode{
    NSString *area = [self getStringByKey:@"myAreaCode"];
    return area.length ? area : @"86";
}


+ (void)setIsRoot:(BOOL)isRoot{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:isRoot?@"yes":@"no" forKey:@"isRoot"];
    [def synchronize];
}

+(id)getStringByKey:(NSString *)key
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    id result = [def valueForKey:key];
    return result;
}

#pragma mark - 小数位处理

+ (NSString *)disposePname:(id)pname price:(id)price{
    if (price == nil) {
        return @"";
    }
    return [self disposeDecimal:[self pointCount:pname] num:price];
}

+ (NSString *)disposeZeroPname:(id)pname price:(id)price{
    if (price == nil) {
        return @"";
    }
    NSInteger c = [self pointCount:pname];
    
    NSString *format = [NSString stringWithFormat:@"%%.%zdf",c];
    NSString *nozero = [NSString stringWithFormat:format,[[self disposeDecimal:c num:price] doubleValue]];
    return nozero;
}

+(NSString *)disposeMaxNum:(NSString *)num{
    if (!num.length) {
        return @"";
    }
    double value = [num doubleValue];
    
    if (value >= 10000000) {
        NSString *result = [NSString stringWithFormat:@"%@M", [self disposePname:@(1) price:@(value/1000000.f)]];
        return result;
    }
    
    if (value >= 10000) {
        NSString *result = [NSString stringWithFormat:@"%@K", [self disposePname:@(1) price:@(value/1000.f)]];
        return result;
    }
    
    return num;
}


//处理小数
+(NSString *)disposeDecimal:(NSInteger)c num:(id)num{
    
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:c raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    
    NSDecimalNumber *priceNum;
    if ([num isKindOfClass:[NSString class]]) {
        priceNum = [NSDecimalNumber decimalNumberWithString:[self disposeDouble:num]];
    }else if([num isKindOfClass:[NSNumber class]]) {
        priceNum = [NSDecimalNumber decimalNumberWithString:[self disposeDouble:((NSNumber *)num).stringValue]];
    }else{
        
        @try {
            priceNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", num]];
        } @catch (NSException *exception) {
            SSLog(@"-----入参price数据异常-----");
        } @finally {
            if ([[NSDecimalNumber notANumber] isEqual:priceNum]) {
                return @"0";
            }
        }
    }
    NSDecimalNumber *result = [priceNum decimalNumberByRoundingAccordingToBehavior:roundUp];
    
    return result.stringValue;
}

//处理异常数据(默认认为小数位超过十位为异常小数)
+ (NSString *)disposeDouble:(NSString *)sender{
    
    NSArray *arr = [sender componentsSeparatedByString:@"."];
    if (arr.count != 2) {
        return sender;
    }
    NSString *decimals = arr.lastObject;
    if (decimals.length >= 10) {
        NSString *result = [NSString stringWithFormat:@"%.8f", [sender doubleValue]];
        return result;
    }
    return sender;
}


+ (NSInteger)pointCount:(id)pname
{
    
    if ([pname isKindOfClass:[NSNumber class]]) {
        return [pname integerValue];
    }
    
    NSString *code = @"8";
    if ([pname isKindOfClass:[NSString class]]) {
        code = [NSString stringWithString:pname];
    }
    
    /*
     币种
     */
    if ([code isEqualToString:@"2"]) {
        return 2;
    }
    if ([code isEqualToString:@"4"]) {
        return 4;
    }
    if ([code isEqualToString:@"6"]) {
        return 6;
    }
    if ([code isEqualToString:@"8"]) {
        return 8;
    }
    
    if ([code.lowercaseString isEqualToString:@"cny"]) {
        return 2;
    }

    if ([code.lowercaseString isEqualToString:@"usdt"]) {
        return 4;
    }
    if ([code.lowercaseString isEqualToString:@"btc"]) {
        return 8;
    }
    if ([code.lowercaseString isEqualToString:@"eth"]) {
        return 8;
    }
    
    return [self MarketPrice:code];
    
}


+(NSString *)add:(NSString *)str1 with:(NSString *)str2{
    if (!str1.length) {
        str1 = @"0";
    }
    
    if (!str2.length) {
        str2 = @"0";
    }
    
    NSDecimalNumber *decimal1 = [NSDecimalNumber decimalNumberWithString:str1];
    NSDecimalNumber *decimal2 = [NSDecimalNumber decimalNumberWithString:str2];
    NSDecimalNumber *result = [decimal1 decimalNumberByAdding:decimal2];
    return result.stringValue;
}
+(NSString *)subtract:(NSString *)str1 with:(NSString *)str2{
    if (!str1.length) {
        str1 = @"0";
    }
    
    if (!str2.length) {
        str2 = @"0";
    }
    NSDecimalNumber *decimal1 = [NSDecimalNumber decimalNumberWithString:str1];
    NSDecimalNumber *decimal2 = [NSDecimalNumber decimalNumberWithString:str2];
    NSDecimalNumber *result = [decimal1 decimalNumberBySubtracting:decimal2];
    return result.stringValue;
}
+(NSString *)multiply:(NSString *)str1 with:(NSString *)str2{
    if (!str1.length) {
        return @"0";
    }
    
    if (!str2.length) {
        return @"0";
    }
    NSDecimalNumber *decimal1 = [NSDecimalNumber decimalNumberWithString:str1];
    NSDecimalNumber *decimal2 = [NSDecimalNumber decimalNumberWithString:str2];
    NSDecimalNumber *result = [decimal1 decimalNumberByMultiplyingBy:decimal2];
    return result.stringValue;
}
+(NSString *)divide:(NSString *)str1 with:(NSString *)str2{
    if (!str1.length) {
        return @"0";
    }
    
    if (!str2.length) {
        return @"0";
    }
    NSDecimalNumber *decimal1 = [NSDecimalNumber decimalNumberWithString:str1];
    NSDecimalNumber *decimal2 = [NSDecimalNumber decimalNumberWithString:str2];
    NSDecimalNumber *result = [decimal1 decimalNumberByDividingBy:decimal2];
    return result.stringValue;
}




#pragma mark - 法币小数位
+(NSString *)FBPrice:(id)price{
    if (price == nil) {
        return @"";
    }
    return [self disposeDecimal:4 num:price];
}

#pragma mark - 币币小数位
+(NSString *)BBPname:(NSString *)pname price:(id)price{
    if (price == nil) {
        return @"";
    }
    return [self disposeDecimal:[self BBPrice:pname] num:price];
}

+(NSString *)BBPname:(NSString *)pname num:(id)num{
    if (num == nil) {
        return @"";
    }
    return [self disposeDecimal:[self BBNum:pname] num:num];
}


+(NSInteger)BBNum:(NSString *)pname{
//    NSArray *array = [pname componentsSeparatedByString:@"/"];

    return [self MarketNum:pname];
}
+(NSInteger)BBPrice:(NSString *)pname{
    return [self MarketPrice:pname];
}

//+(NSString *)BBPname:(NSString *)pname total:(id)totalMoney{
//
//}


#pragma mark - 行情小数位

+ (NSString *)MarketPname:(NSString *)pname price:(id)price{
    if (price == nil) {
        return @"";
    }
    NSInteger c = [self MarketPrice:pname];
    NSString *format = [NSString stringWithFormat:@"%%.%zdf",c];
    NSString *nozero = [NSString stringWithFormat:format,[[self disposeDecimal:c num:price] doubleValue]];
    
    return [WLTools noroundingStringWith:nozero.doubleValue afterPointNumber:c];
//    return nozero;
}

+ (NSString *)MarketPname:(NSString *)pname num:(id)num{
    if (num == nil) {
        return @"";
    }
    NSInteger c = [self MarketNum:pname];
    NSString *format = [NSString stringWithFormat:@"%%.%zdf",c];
    NSString *nozero = [NSString stringWithFormat:format,[[self disposeDecimal:c num:num] doubleValue]];
    return [WLTools noroundingStringWith:nozero.doubleValue afterPointNumber:c];

//    return nozero;
}

+(NSInteger)MarketNum:(NSString *)pname{
    return 2;
}

+(NSInteger)MarketPrice:(NSString *)pname{
   NSArray *num0 = @[
        @"XRP/BTC",
    ];
    if ([num0 containsObject:pname]) {
        return 0;
    }
    
    NSArray *num2 = @[
        @"btc_usdt",
        @"eth_usdt",
        @"bch_usdt",
        @"ltc_usdt",
    ];
    if ([num2 containsObject:pname]) {
        return 2;
    }
    
    NSArray *num4 = @[
        @"bsv_usdt",
        @"eos_usdt",
        @"etc_usdt",
        @"ht_usdt",
    ];
    if ([num4 containsObject:pname]) {
        return 4;
    }
    
    NSArray *num5 = @[
        @"xrp_usdt",
    ];
    if ([num5 containsObject:pname]) {
        return 5;
    }
    
    NSArray *num6 = @[
        @"trx_usdt",
    ];
    if ([num6 containsObject:pname]) {
        return 6;
    }
    
    return 4;
}

#pragma mark - 合约小数位
+(NSString *)HeyuePname:(NSString *)pname price:(id)price{
    if (price == nil) {
        return @"";
    }
    return [self disposeDecimal:2 num:price];
}

+(NSString *)HeyueCoin:(NSString *)pname price:(id)price{
    if (price == nil) {
        return @"";
    }
    return [self disposeDecimal:[self HeyuePname:pname] num:price];
}

+ (NSInteger)HeyuePname:(NSString *)pname{
    return [self MarketPrice:pname];
}

#pragma mark - 资产/个人中心小数位

+(NSString *)MinePname:(NSString *)pname price:(id)price{
    if (price == nil) {
        return @"";
    }
    return [self disposeDecimal:4 num:price];
}

@end
