//
//  Heyue_ProductModel.h
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/16.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Heyue_ProductModel : NSObject

@property (nonatomic, strong) NSArray *leverage;
@property (nonatomic, strong) NSArray *position_select;

@property (nonatomic,copy) NSString *min_order;//最小购买量

@property (nonatomic,copy) NSString *max_order;//最大购买量

@property (nonatomic,copy) NSString *sheets_rate;// 面值
@property (nonatomic, copy) NSString *hands; //一手面值

@property (nonatomic,copy) NSString *spread;//点差

@property (nonatomic,copy) NSString *var_price;//最小变动价

@property (nonatomic,copy) NSString *leverDealFee;//手续费百分比

@end

NS_ASSUME_NONNULL_END
