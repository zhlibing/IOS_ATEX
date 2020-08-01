//
//  ETF_BBTrade_Introduce_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/10.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETF_BBTrade_Introduce_Model : NSObject
@property(nonatomic,copy)NSString *pname;   // 币种名称

@property(nonatomic,copy)NSString *code;   // 币种名称

@property(nonatomic,copy)NSString *fxtime;  // 发行时间

@property(nonatomic,copy)NSString *fxnum;

@property(nonatomic,copy)NSString *fxprice; // 发行价格

@property(nonatomic,copy)NSString *fxbook;

@property(nonatomic,copy)NSString *fxweb;

@property(nonatomic,copy)NSString *qukuai;

@property(nonatomic,copy)NSString *memo;    // 简介



@property(nonatomic,copy)NSString *currencyNum;   // 流通数量


@end

NS_ASSUME_NONNULL_END
