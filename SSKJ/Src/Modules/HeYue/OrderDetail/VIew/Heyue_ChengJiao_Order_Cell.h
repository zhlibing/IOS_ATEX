//
//  Heyue_ChengJiao_Order_Cell.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/29.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Heyue_Order_ChengjiaoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Heyue_ChengJiao_Order_Cell : UITableViewCell

//底部分割线
@property(nonatomic,strong)UIView *bottomlineView;

@property (nonatomic, copy) void (^shareBlock)(Heyue_Order_ChengjiaoModel *chengJiaoModel);

@property (nonatomic,strong) Heyue_Order_ChengjiaoModel *chengJiaoModel;



@end

NS_ASSUME_NONNULL_END
