//
//  HeYue_Root_HeaderView.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Heyue_Leverage_Model.h"

#import "PanKou_Socket_Model.h"

#import "SSKJ_Market_Index_Model.h"

#import "SSKJ_UserInfo_Model.h"

#import "Heyue_TitlePrice_View.h"

NS_ASSUME_NONNULL_BEGIN


@interface HeYue_Root_HeaderView : UIView

/**
 下单
 */
@property (nonatomic,copy) void (^HeyueCreateOrderBlock)(NSDictionary *params);
/**
 杠杆倍数等数据
 */
@property (nonatomic,strong) Heyue_Leverage_Model *leverageModel;


/*  合约   可用资金 */
@property (nonatomic, copy) NSString *wallone_usdt;//合约可用余额

/**
 币种
 */
@property (nonatomic, strong) SSKJ_Market_Index_Model *model;

/**
 盘口数据
 */
@property (nonatomic,strong) PanKou_Socket_Model *pankouModel;





-(void)changeUI;


/**
 拉起登录Block
 */
@property (nonatomic,copy) void (^HeyuegLoginBlock)(void);

/**
 爆仓点击Block
 */
@property (nonatomic,copy) void (^HeyueBaoCangBlock)(void);

@property (nonatomic, copy) NSString *baoCang;//爆仓率

/**
 深度数据
 */
@property (nonatomic,strong) NSDictionary *shenduDic;
@end

NS_ASSUME_NONNULL_END
