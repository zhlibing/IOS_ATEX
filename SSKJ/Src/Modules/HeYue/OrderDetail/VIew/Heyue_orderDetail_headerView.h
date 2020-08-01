//
//  Heyue_orderDetail_headerView.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/30.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Heyue_OrderInfo_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface Heyue_orderDetail_headerView : UIView

- (void)initDataWithOrderInfoModel:(Heyue_OrderInfo_Model *)model;

- (void)updateWith:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
