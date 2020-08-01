//
//  LXY_KLine_DataModel.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/22.
//  Copyright © 2018年 James. All rights reserved.
//

#import "LXY_KLine_DataModel.h"

@implementation LXY_KLine_DataModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"open": @"openingPrice",
             @"close": @"closingPrice",
             @"high": @"highestPrice",
             @"low": @"lowestPrice",
             };
}

-(void)setData
{
    [self ma5];
    [self ma10];
    [self ma20];
    
    [self EMA7];
    [self EMA12];
    [self EMA26];
    [self EMA30];
    
    [self SumOfLastVolume];
    [self volume_MA5];
    [self volume_MA10];
    
    [self DIF];
    [self DEA];
    [self MACD];
    [self NineClocksMaxPrice];
    [self NineClocksMinPrice];
    [self RSV_9];
    [self KDJ_K];
    [self KDJ_D];
    [self KDJ_J];
    
    [self CHG];
    [self CHG_TOTAL_UP];
    [self CHG_TOTAL_DN];
    
    [self RSI6];
    [self RSI12];
    [self RSI24];
    
    [self WR14];
    
    [self BOLL_MD];
    [self BOLL_MB];
    [self BOLL_UP];
    [self BOLL_DN];
    [self BOLL_SUBMD];
    [self BOLL_SUBMD_SUM];
}


- (double)RSV_9
{
    if (!_RSV_9) {
        if(self.NineClocksMinPrice == self.NineClocksMaxPrice) {
            _RSV_9 = 100;
        } else {
            _RSV_9 = (self.close.doubleValue - self.NineClocksMinPrice) * 100 / (self.NineClocksMaxPrice - self.NineClocksMinPrice);
        }
    }
    return _RSV_9;
}
- (double)KDJ_K
{
    if (!_KDJ_K) {
        _KDJ_K = (self.RSV_9 + 2 * (self.previousKlineModel.KDJ_K ? self.previousKlineModel.KDJ_K : 50) )/3;
    }
    return _KDJ_K;
}

- (double)KDJ_D
{
    if(!_KDJ_D) {
        _KDJ_D = (self.KDJ_K + 2 * (self.previousKlineModel.KDJ_D ? self.previousKlineModel.KDJ_D : 50))/3;
    }
    return _KDJ_D;
}
- (double)KDJ_J
{
    if(!_KDJ_J) {
        _KDJ_J = 3*self.KDJ_K - 2*self.KDJ_D;
    }
    return _KDJ_J;
}



//// EMA（N）=2/（N+1）*（C-昨日EMA）+昨日EMA；
- (double)EMA7
{
    if(!_EMA7) {
        _EMA7 = (self.close.doubleValue + 3 * self.previousKlineModel.EMA7)/4;
    }
    return _EMA7;
}


- (double)EMA12
{
    if(!_EMA12) {
        if ([self.dataSource indexOfObject:self] == 0) {
            _EMA12 = self.close.doubleValue;
        }else{
            _EMA12 = (2 * self.close.doubleValue + 11 * self.previousKlineModel.EMA12)/13;
        }
    }
    return _EMA12;
}

- (double)EMA26
{
    if (!_EMA26) {
        if ([self.dataSource indexOfObject:self] == 0) {
            _EMA26 = self.close.doubleValue;
        }else{
            _EMA26 = (2 * self.close.doubleValue + 25 * self.previousKlineModel.EMA26)/27;
        }
    }
    return _EMA26;
}


//- (NSNumber *)SumOfLastClose
//{
//    if(!_SumOfLastClose) {
//        _SumOfLastClose = self.previousKlineModel.SumOfLastClose + self.close.doubleValue;
//    }
//    return _SumOfLastClose;
//}
//
- (double)SumOfLastVolume
{
    if(!_SumOfLastVolume) {
        _SumOfLastVolume = self.previousKlineModel.SumOfLastVolume + self.volume.doubleValue;
    }
    return _SumOfLastVolume;
}

- (double)volume_MA5
{

    if (_volume_MA5 == 0) {
        NSInteger index = [self.dataSource indexOfObject:self];
        if (index >= 4) {
            if (index > 4) {
                _volume_MA5 = (self.SumOfLastVolume - [self.dataSource[index - 5] SumOfLastVolume]) / 5;
            } else {
                _volume_MA5 = self.SumOfLastVolume / 5;
            }
        }
    }
    return _volume_MA5;

}

- (double)volume_MA10
{
    
    if (_volume_MA10 == 0) {
        NSInteger index = [self.dataSource indexOfObject:self];
        if (index >= 9) {
            if (index > 9) {
                _volume_MA10 = (self.SumOfLastVolume - [self.dataSource[index - 10] SumOfLastVolume]) / 10;
            } else {
                _volume_MA10 = self.SumOfLastVolume / 10;
            }
        }
    }
    return _volume_MA10;
    
}


- (double)NineClocksMinPrice
{
    if (!_NineClocksMinPrice) {
        //        if([self.ParentGroupModel.models indexOfObject:self] >= 8)
        //        {
        [self rangeLastNinePriceByArray:self.dataSource condition:NSOrderedDescending];
        //        } else {
        //            _NineClocksMinPrice = @0;
        //        }
    }
    return _NineClocksMinPrice;
}

- (double)NineClocksMaxPrice {
    if (!_NineClocksMaxPrice) {
        if([self.dataSource indexOfObject:self] >= 8)
        {
            [self rangeLastNinePriceByArray:self.dataSource condition:NSOrderedAscending];
        } else {
            _NineClocksMaxPrice = 0;
        }
    }
    return _NineClocksMaxPrice;
}


////DIF=EMA（12）-EMA（26）         DIF的值即为红绿柱；
//
////今日的DEA值=前一日DEA*8/10+今日DIF*2/10.

- (double)DIF
{
    if(!_DIF) {
        _DIF = self.EMA12 - self.EMA26;
    }
    return _DIF;
}

//已验证
-(double)DEA
{
    if(!_DEA) {
        _DEA = self.previousKlineModel.DEA * 0.8 + 0.2*self.DIF;
    }
    return _DEA;
}

//已验证
- (double)MACD
{
    if(!_MACD) {
        _MACD = 2*(self.DIF - self.DEA);
    }
    return _MACD;
}

#pragma mark BOLL线

- (double)ma5
{

    if (!_ma5) {
        NSInteger index = [self.dataSource indexOfObject:self];
        if (index >= 4) {
            if (index > 4) {
                _ma5 = (self.SumOfLastClose - [self.dataSource[index - 5] SumOfLastClose]) / 5;
            } else {
                _ma5 = self.SumOfLastClose / 5;
            }
        }
    }
    return _ma5;
}

- (double)ma10
{
    if (!_ma10) {
        NSInteger index = [self.dataSource indexOfObject:self];
        if (index >= 9) {
            if (index > 9) {
                _ma10 = (self.SumOfLastClose - [self.dataSource[index - 10] SumOfLastClose]) / 10;
            } else {
                _ma10 = self.SumOfLastClose / 10;
            }
        }
    }
    return _ma10;
}
- (double)ma20
{
    if (!_ma20) {
        NSInteger index = [self.dataSource indexOfObject:self];
        if (index >= 19) {
            if (index > 19) {
                _ma20 = (self.SumOfLastClose - [self.dataSource[index - 20] SumOfLastClose]) / 20;
            } else {
                _ma20 = self.SumOfLastClose / 20;
            }
        }
    }
    return _ma20;
}

-(double)CHG
{
    if (!_CHG) {
        return self.close.doubleValue - self.previousKlineModel.close.doubleValue;
    }
    return _CHG;
}

-(double)CHG_TOTAL_UP
{
    if (self.CHG > 0) {
        return self.previousKlineModel.CHG_TOTAL_UP + self.CHG;
    }else{
        return self.previousKlineModel.CHG_TOTAL_UP;
    }
}

-(double)CHG_TOTAL_DN
{
    if (self.CHG > 0) {
        return self.previousKlineModel.CHG_TOTAL_DN;
    }else{
        return self.previousKlineModel.CHG_TOTAL_DN + self.CHG;
    }
}


-(double)RSI6
{
    NSInteger index = [self.dataSource indexOfObject:self];

    if (index < 6) {
        return 0;
    }else{
        if (!_RSI6) {
            double rsi_total_up = self.CHG_TOTAL_UP - [self.dataSource[index - 6] CHG_TOTAL_UP];
            double rsi_total_dn = self.CHG_TOTAL_DN - [self.dataSource[index - 6] CHG_TOTAL_DN];
            _RSI6 = rsi_total_up / (rsi_total_up - rsi_total_dn) * 100;
        }
        return _RSI6;
    }
}

-(double)RSI12
{
    NSInteger index = [self.dataSource indexOfObject:self];
    
    if (index < 12) {
        return 0;
    }else{
        if (!_RSI12) {
            double rsi_total_up = self.CHG_TOTAL_UP - [self.dataSource[index - 12] CHG_TOTAL_UP];
            double rsi_total_dn = self.CHG_TOTAL_DN - [self.dataSource[index - 12] CHG_TOTAL_DN];
            _RSI12 = rsi_total_up / (rsi_total_up - rsi_total_dn) * 100;
        }
        return _RSI12;
    }
}

-(double)RSI24
{
    NSInteger index = [self.dataSource indexOfObject:self];
    
    if (index < 24) {
        return 0;
    }else{
        if (!_RSI24) {
            double rsi_total_up = self.CHG_TOTAL_UP - [self.dataSource[index - 24] CHG_TOTAL_UP];
            double rsi_total_dn = self.CHG_TOTAL_DN - [self.dataSource[index - 24] CHG_TOTAL_DN];
            _RSI24 = rsi_total_up / (rsi_total_up - rsi_total_dn) * 100;
        }
        return _RSI24;
    }
}

-(double)WR14
{
    NSInteger index = [self.dataSource indexOfObject:self];

    if (index < 13) {
        return 0;
    }else{
        if (!_WR14) {
            double H14 = 0;
            double L14 = 1000000;
            for (NSInteger i = index; i >= index - 13; i--) {
                LXY_KLine_DataModel *model = self.dataSource[i];
                if (H14 < model.high.doubleValue) {
                    H14 = model.high.doubleValue;
                }
                if (L14 > model.low.doubleValue) {
                    L14 = model.low.doubleValue;
                }
            }
            
            _WR14 = (H14 - self.close.doubleValue) / (H14 - L14) * 100;
        }
        return _WR14;
    }
}

- (double)SumOfLastClose
{
    if(!_SumOfLastClose) {
        _SumOfLastClose = self.previousKlineModel.SumOfLastClose + self.close.doubleValue;
    }
    return _SumOfLastClose;
}


- (double)BOLL_MB {
    
    if(!_BOLL_MB) {
        
        NSInteger index = [self.dataSource indexOfObject:self];
        if (index >= 19) {
            
            if (index > 19) {
                _BOLL_MB = (self.SumOfLastClose - [self.dataSource[index - 19] SumOfLastClose]) / 19;
                
            } else {
                
                _BOLL_MB = self.SumOfLastClose / index;
                
            }
        }
        
        // SSLog(@"lazyMB:\n _BOLL_MB: %@", _BOLL_MB);
        
    }
    
    return _BOLL_MB;
}

- (double)BOLL_MD {
    
    if (!_BOLL_MD) {
        
        NSInteger index = [self.dataSource indexOfObject:self];
        
        if (index >= 20) {
            
            _BOLL_MD = sqrt((self.previousKlineModel.BOLL_SUBMD_SUM - [self.dataSource[index - 20] BOLL_SUBMD_SUM])/ 20);
            
        }
        
    }
    
    // SSLog(@"lazy:\n_BOLL_MD:%@ -- BOLL_SUBMD:%@",_BOLL_MD,_BOLL_SUBMD);
    
    return _BOLL_MD;
}

- (double)BOLL_UP {
    if (!_BOLL_UP) {
        NSInteger index = [self.dataSource indexOfObject:self];
        if (index >= 20) {
            _BOLL_UP = self.BOLL_MB + 2 * self.BOLL_MD;
        }
    }
    
    // SSLog(@"lazy:\n_BOLL_UP:%@ -- BOLL_MD:%@",_BOLL_UP,_BOLL_MD);
    
    return _BOLL_UP;
}

- (double)BOLL_DN {
    if (!_BOLL_DN) {
        NSInteger index = [self.dataSource indexOfObject:self];
        if (index >= 20) {
            _BOLL_DN = self.BOLL_MB - 2 * self.BOLL_MD;
        }
    }
    
    // SSLog(@"lazy:\n_BOLL_DN:%@ -- BOLL_MD:%@",_BOLL_DN,_BOLL_MD);
    
    return _BOLL_DN;
}

- (double)BOLL_SUBMD_SUM {
    
    if (!_BOLL_SUBMD_SUM) {
        
        NSInteger index = [self.dataSource indexOfObject:self];
        if (index >= 20) {
            
            _BOLL_SUBMD_SUM = self.previousKlineModel.BOLL_SUBMD_SUM + self.BOLL_SUBMD;
            
        }
    }
    
    // SSLog(@"lazy:\n_BOLL_SUBMD_SUM:%@ -- BOLL_SUBMD:%@",_BOLL_SUBMD_SUM,_BOLL_SUBMD);
    
    return _BOLL_SUBMD_SUM;
}

- (double)BOLL_SUBMD{
    
    if (!_BOLL_SUBMD) {
        
        NSInteger index = [self.dataSource indexOfObject:self];
        
        if (index >= 20) {
            
            _BOLL_SUBMD = (self.close.doubleValue - self.ma20) * ( self.close.doubleValue - self.ma20);
            
        }
    }
    
    // SSLog(@"lazy_BOLL_SUBMD: \n MA20: %@ \n Close: %@ \n subNum: %f", _MA20, _Close, self.Close.floatValue - self.MA20.floatValue);
    
    return _BOLL_SUBMD;
}

//对Model数组进行排序，初始化每个Model的最新9Clock的最低价和最高价
- (void)rangeLastNinePriceByArray:(NSArray<LXY_KLine_DataModel *> *)models condition:(NSComparisonResult)cond
{
    NSInteger modelCount = models.count;
    NSInteger count = 7;
    if (modelCount < 8) {
        count = modelCount - 1;
    }
    
    switch (cond) {
            //最高价
        case NSOrderedAscending:
        {
            //            第一个循环结束后，ClockFirstValue为最小值
            for (NSInteger j = count; j >= 1; j--)
            {
                double emMaxValue = 0;
                
                NSInteger em = j;
                
                LXY_KLine_DataModel *model = models[em];
                
                while ( em >= 0 )
                {
                    if(emMaxValue < model.high.doubleValue)
                    {
                        emMaxValue = model.high.doubleValue;
                    }
                    em--;
                }
//                SSLog(@"%f",emMaxValue);
                models[j].NineClocksMaxPrice = emMaxValue;
            }
            //第一个循环结束后，ClockFirstValue为最小值
            for (NSInteger i = 0, j = count + 1; j < models.count; i++,j++)
            {
                double emMaxValue = 0;
                
                NSInteger em = j;
                LXY_KLine_DataModel *model = models[em];

                
                while ( em >= i )
                {
                    if(emMaxValue < model.high.doubleValue)
                    {
                        emMaxValue =  model.high.doubleValue;
                    }
                    em--;
                }
//                SSLog(@"%f",emMaxValue);
                
                models[j].NineClocksMaxPrice = emMaxValue;
            }
        }
            break;
        case NSOrderedDescending:
        {
            //第一个循环结束后，ClockFirstValue为最小值
            
            for (NSInteger j = count; j >= 1; j--)
            {
                double emMinValue = 10000000000;
                
                NSInteger em = j;
                LXY_KLine_DataModel *model = models[em];

                while ( em >= 0 )
                {
                    if(emMinValue > model.low.doubleValue)
                    {
                        emMinValue = model.high.doubleValue;
                    }
                    em--;
                }
                models[j].NineClocksMinPrice = emMinValue;
            }
            
            for (NSInteger i = 0, j = count + 1; j < models.count; i++,j++)
            {
                double emMinValue = 10000000000;
                
                NSInteger em = j;
                
                LXY_KLine_DataModel *model = models[em];

                while ( em >= i )
                {
                   if(emMinValue > model.low.doubleValue)
                    {
                        emMinValue = model.low.doubleValue;
                    }
                    em--;
                }
                models[j].NineClocksMinPrice = emMinValue;
            }
        }
            break;
        default:
            break;
    }
}
@end
