//
//  Heyue_WeiTuo_Order_Cell.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Heyue_OrderDdetail_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface Heyue_WeiTuo_Order_Cell : UITableViewCell

@property (nonatomic,copy) void (^HeyueCheDanBlock)(void);

@property (nonatomic,strong) Heyue_OrderDdetail_Model *weituoModel;

@property(nonatomic,strong)UIView *bottomGrayView;

@end

NS_ASSUME_NONNULL_END
