//
//  CommonDefine.h
//  SSKJ
//
//  Created by James on 2018/6/13.
//  Copyright © 2018年 James. All rights reserved.
//
#import "AES_SecurityUtil.h"


//weakSelf
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define UIImageNamed(name) [UIImage imageNamed:(name)]


//写
#define SSKJUserDefaultsSET(object,key) [[NSUserDefaults standardUserDefaults] setObject:object forKey:key]

// 取
#define SSKJUserDefaultsGET(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

// 删
#define SSKJUserDefaultsRemove(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]

// 存
#define SSKJUserDefaultsSynchronize [[NSUserDefaults standardUserDefaults] synchronize]



//获取当前iOS系统版本号
#define kSystemVersion   [[[UIDevice currentDevice] systemVersion] floatValue]

//获取当前APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// 加密
#define Encrypt(string) [AES_SecurityUtil aes128EncryptWithContent:string]

// 解密
#define Dencrypt(string) [AES_SecurityUtil aes128DencryptWithContent:string]


//默认请求数量
#define kPage_size 15

#define kHeYue_ZhangShu 0

//币本合约输入数量小数位
#define kHeYue_Biben_Num 2
//币本合约保证金小数位
#define kHeYue_Biben_deposit 6

static NSString * const AppLanguage = @"appLanguage";

// 语言国际化
#define SSKJLocalized(key, comment) [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:AppLanguage]] ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:nil]

// 语言国际化
#define SSKJLanguage(key) SSKJLocalized(key, nil)

// 语言中文
#define kIsCN [[[SSKJLocalized sharedInstance] currentLanguage] isEqualToString:@"zh-Hans"]
// 语言韩文
#define kIsKO [[[SSKJLocalized sharedInstance] currentLanguage] isEqualToString:@"ko"]
//系统字体对应字号
#define systemFont(x) [UIFont systemFontOfSize:x]

// 粗体
#define systemBoldFont(s) [UIFont fontWithName:@"Helvetica-Bold" size:s]

// 细体
#define systemThinFont(s) [UIFont systemFontOfSize:s weight:UIFontWeightThin]

//对应调整大小后普通字号
#define kFont(x) [UIFont systemFontOfSize:ScaleW(x)]

//对应调整大小后粗体字号
#define kBoldFont(x) [UIFont fontWithName:@"Helvetica-Bold" size:ScaleW(x)]

//对应调整大小后细体字号
#define kThinFont(x) [UIFont systemFontOfSize:ScaleW(x) weight:UIFontWeightThin]


#define MyImage(s) [UIImage imageNamed:s]


#define coinNumber      4

#ifdef DEBUG
//#define SSLog(format, ...) printf("\n%s [第%d行] %s\n", __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

#define SSLog(format, ...) NSLog((@"\n%s [第%d行]\n" format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#else
#define SSLog(format, ...)
#endif


#define kFUNCTION SSLog(@"--------");
