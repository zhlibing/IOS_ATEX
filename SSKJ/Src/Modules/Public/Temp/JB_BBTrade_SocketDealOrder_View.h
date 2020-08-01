//
//  JB_BBTrade_SocketDealOrder_View.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JB_BBTrade_SocketDealOrder_Model.h"
#import "SSKJ_Market_Index_Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface JB_BBTrade_SocketDealOrder_View : UIView
@property (nonatomic, strong) SSKJ_Market_Index_Model *coinModel;

@property (nonatomic, strong) NSArray<JB_BBTrade_SocketDealOrder_Model *> *dataSource;

@property (nonatomic, assign) BOOL isFromGangGan;// YES代表是y杠杆页面

@end

NS_ASSUME_NONNULL_END
