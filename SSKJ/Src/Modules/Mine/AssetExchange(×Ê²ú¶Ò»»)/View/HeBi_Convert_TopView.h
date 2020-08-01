//
//  HeBi_Convert_TopView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HeBi_ConvertCoin_Model.h"
#import "HeBi_ConvertToCoin_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_Convert_TopView : UIView

@property (nonatomic, copy) void (^selectCoinBlock)(void);
@property (nonatomic, copy) void (^selectConvertBlock)(void);


// 持有资产model
@property (nonatomic, strong) HeBi_ConvertCoin_Model *coinModel;

// 要兑换的币种model
@property (nonatomic, strong) HeBi_ConvertToCoin_Model *convertModel;
@end

NS_ASSUME_NONNULL_END
