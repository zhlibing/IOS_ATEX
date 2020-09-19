//
//  ProfitWeiTuoChiCangHelper.h
//  SSKJ
//
//  Created by 姚立志 on 2020/9/10.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Heyue_OrderInfo_Model.h"  //!< 盈亏

NS_ASSUME_NONNULL_BEGIN

@interface ProfitWeiTuoChiCangHelper : NSObject


+(ProfitWeiTuoChiCangHelper *)shareHelper;

@property (nonatomic, copy) void (^getProfitWeiTuoChiCangBlock)(Heyue_OrderInfo_Model *profitModel,NSArray *weituoArray,NSArray *chicangArray);


#pragma mark 开启定时器
-(void)startRuntimer;
#pragma mark 关闭定时器
-(void)stopRuntimer;








@end

NS_ASSUME_NONNULL_END
