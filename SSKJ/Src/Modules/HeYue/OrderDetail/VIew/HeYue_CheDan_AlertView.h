//
//  HeYue_CheDan_AlertView.h
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/3/29.
//  Copyright © 2019 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Heyue_OrderDdetail_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeYue_CheDan_AlertView : UIView

@property (nonatomic, copy) void (^CheDanBlock)(Heyue_OrderDdetail_Model *weituoModel);

- (void)initDataWithWeituoModel:(Heyue_OrderDdetail_Model *)weituoModel;

- (void)showAlertView;

@end

NS_ASSUME_NONNULL_END
