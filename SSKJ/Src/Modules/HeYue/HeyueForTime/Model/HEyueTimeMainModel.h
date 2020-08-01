//
//  HEyueTimeMainModel.h
//  SSKJ
//
//  Created by cy5566 on 2020/3/21.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HEyueTimeMainModel : NSObject

@property (nonatomic,copy) NSString *timeLeverCycle;
@property (nonatomic,copy) NSString *btcRange;
@property (nonatomic,copy) NSString *cycleNum;
@property (nonatomic,copy) NSString *eosRange;
@property (nonatomic,copy) NSString *ethRange;
@property (nonatomic,copy) NSString *eosPrice;
@property (nonatomic,copy) NSString *btcPrice;
@property (nonatomic,copy) NSString *ethPrice;
@property (nonatomic,copy) NSString *second;
@property (nonatomic,copy) NSString *codeAssemble;
//"timeLeverCycle": 5,//持仓周期时间
//   "btcRange": "2",//BTC涨跌盈利范围
//   "cycleNum": "166",//周期数
//   "eosRange": "2",//EOS涨跌盈利范围
//   "ethRange": "2"//ETH涨跌盈利范围
//   "eosPrice": "1",//保证金EOS每张价格
//   "btcPrice": "1",//保证金BTC每张价格
//   "ethPrice": "1"//保证金ETH每张价格
//   "second": "219"//倒计时秒数
//   "codeAssemble": "BTC,ETH,EOS"//币种集合
@end

NS_ASSUME_NONNULL_END
