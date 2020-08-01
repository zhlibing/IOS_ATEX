//
//  SSKJ_Socket_Tool.h
//  SSKJ
//
//  Created by zpz on 2019/10/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, SSKJSocketModule) {
    SSKJSocketModuleBB,
    SSKJSocketModuleHeYue
};


typedef NS_OPTIONS(NSInteger, SSKJSocketType) {
    SSKJSocketTypeMarket = 1 << 0,
    SSKJSocketTypeDeep =  1 << 1,
    SSKJSocketTypePanKou = 1 << 2,
    SSKJSocketTypeTrade = 1 << 3,
    SSKJSocketTypeKLine = 1 << 4
};

@protocol SSKJSocketToolDelegate  <NSObject>

@optional

- (void)kLineNeedRequest;
- (void)marketSocketDidUpdate:(NSDictionary *)dic;
- (void)deepSocketDidUpdate:(NSDictionary *)dic;
- (void)pankouSocketDidUpdate:(NSDictionary *)dic;
- (void)tradeSocketDidUpdate:(NSDictionary *)dic;

@end

@interface SSKJ_Socket_Tool : NSObject


- (instancetype)initWithType:(SSKJSocketType)type module:(SSKJSocketModule)module delegate:(id)delegate;

- (void)openSocketWithCode:(id)sender;
- (void)openSocket;
- (void)closeSocket;

@end

NS_ASSUME_NONNULL_END
