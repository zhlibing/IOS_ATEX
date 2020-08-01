//
//  Heyue_Leverage_Model.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/8/6.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Heyue_ProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Heyue_Leverage_Model : NSObject

@property (nonatomic,strong) Heyue_ProductModel *product;//杠杆

@property (nonatomic, copy) NSString *risk; //风险率
@property (nonatomic, copy) NSString *code; // 爆仓率
@property (nonatomic, copy) NSString *handling_fee; // 手续费
@property (nonatomic, copy) NSString *bc_rate; // 爆仓率
@property (nonatomic, copy) NSString *balance; // 可用金额





/////////////////

//@property (nonatomic,copy) NSString *trans_ware;//风险率百分比 爆仓率

@end

NS_ASSUME_NONNULL_END
