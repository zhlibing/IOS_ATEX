//
//  HeYueTime_Root_HeaderView.h
//  SSKJ
//
//  Created by cy5566 on 2020/3/21.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Heyue_Leverage_Model.h"

#import "PanKou_Socket_Model.h"

#import "SSKJ_Market_Index_Model.h"

#import "SSKJ_UserInfo_Model.h"

#import "Heyue_TitlePrice_View.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeYueTime_Root_HeaderView : UIView
//表示是第几期
@property (nonatomic,strong) UILabel *timeTitleLabel;
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
 倒计时点击Block
 */
@property (nonatomic,copy) void (^HeyueCountDownBlock)(void);

@property (nonatomic, copy) NSString *timeLeverCycle;//倒计时
@property (nonatomic ,copy) NSString *cycleNum;//期数
@property (nonatomic, copy) NSString *CycleTimer;//持仓周期时间
@property (nonatomic,copy) NSString *cRange; //涨跌盈利

//@property (nonatomic, copy) NSArray *cycleTimerArray;//周期时间数组

/**
 深度数据
 */
@property (nonatomic,strong) NSDictionary *shenduDic;

- (void) startTimer;
- (void) endTimer;
@property (nonatomic ,copy) void(^timerEndCallback)(void);
@property (nonatomic, assign) BOOL isTimer;

@property (nonatomic ,strong) NSDictionary *ValueData;//合约页面信息


@property (nonatomic, copy) void(^selectBlock)(NSInteger selectCount);

@end

NS_ASSUME_NONNULL_END
