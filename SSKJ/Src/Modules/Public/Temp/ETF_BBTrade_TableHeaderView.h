//
//  ETF_BBTrade_TableHeaderView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/15.
//  Copyright © 2019年 James. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSKJ_Market_Index_Model.h"

#import "LXY_KLine_DataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ETF_BBTrade_TableHeaderView : UIView
@property (nonatomic, strong) SSKJ_Market_Index_Model *coinModel;

-(void)setViewWithSocketModel:(LXY_KLine_DataModel *)socketModel;
@end

NS_ASSUME_NONNULL_END
