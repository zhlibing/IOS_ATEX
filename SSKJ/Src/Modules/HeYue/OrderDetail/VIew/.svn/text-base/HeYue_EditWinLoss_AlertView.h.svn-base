//
//  HeYue_EditWinLoss_AlertView.h
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/3/29.
//  Copyright © 2019 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Heyue_OrderWinLoss_Model.h"

#import "Heyue_OrderDdetail_Model.h"
#import "SSKJ_Market_Index_Model.h"
#import "Heyue_Leverage_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeYue_EditWinLoss_AlertView : UIView

@property (nonatomic, copy) void (^EditWinLossBlock)(NSString * winstr,NSString * lossStr);

-(void)setViewWithOrderDic:(Heyue_OrderDdetail_Model *)orderModel;
-(void)updateNowPriceUI:(Heyue_OrderWinLoss_Model *)model nowPrice:(NSString *)nowPrice;
- (void)showAlertView;

@property(nonatomic, strong)Heyue_Leverage_Model *setModel;


@end

NS_ASSUME_NONNULL_END
