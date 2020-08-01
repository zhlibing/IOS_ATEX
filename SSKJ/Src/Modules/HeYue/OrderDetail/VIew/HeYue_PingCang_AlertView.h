//
//  HeYue_PingCang_AlertView.h
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/3/28.
//  Copyright © 2019 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Heyue_OrderDdetail_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeYue_PingCang_AlertView : UIView


@property (nonatomic, copy) void (^PingCangBlock)(NSString *sheets);


- (void)showAlertView;

- (void)initDataWithDic:(Heyue_OrderDdetail_Model *)model;

-(void)setMarketPriceView:(NSString *)price;

@end

NS_ASSUME_NONNULL_END
