//
//  HeYueTime_Root_HeaderView.h
//  SSKJ
//
//  Created by cy5566 on 2020/3/21.
//  Copyright © 2020 刘小雨. All rights reserved.
//


/*
 保证金 = 下单张数 * 每张币数 * 市价 / 杠杆
 手续费 = 下单张数 * 每张币数 * 市价 * 手续费比例
 总额 = 保证金 + 手续费
 */

#import "HeYueTime_Root_HeaderView.h"

#import "NSTimer+weakTimer.h"

#import "HeyueTime_Root_Cangwei_View.h"//仓位 试图


#import "LXY_DeepView.h"//深度图

#import "Heyue_Root_CountDown_View.h"
#import "Heyue_Pankou_View.h"//盘口试图

#import "HeyueTime_Confirm_View.h"//确认下单弹框

#import "HeYue_Leverage_View.h"
#import "Heyue_root_leverage_View.h"


#define btnWidth (ScreenWidth / 2 - ScaleW(30) - ScaleW(7)) / 2

#define ViewWidth ScreenWidth / 2 - ScaleW(15)

@interface HeYueTime_Root_HeaderView()<UITextFieldDelegate>




@property (nonatomic,strong) UIButton *buyBtn;// 做多/买入

@property (nonatomic,strong) UIButton *sellBtn;// 做多/买入

@property (nonatomic,strong) UIView *downEarningsValueView; //涨跌盈利值

@property (nonatomic,strong) UILabel *downEarningsTitleLabel; //涨跌盈利值标题

@property (nonatomic,strong) UILabel *downEarningsValueLabel; //涨跌盈利值

@property (nonatomic,strong) UILabel * currentPriceTitleLabel;//当前最优价格标题

@property (nonatomic,strong) UILabel * shiJiaWarmLab;//当前最优价格

@property (nonatomic,strong) UIView * priceBgView;//当前价格背景试图



@property (nonatomic,strong) UILabel * keyongTitle;//可用title

@property (nonatomic,strong) UILabel * keyongLabel;//可用price

@property (nonatomic,strong) HeyueTime_Root_Cangwei_View *cangweiView;//输入数量  仓位 试图

//@property (nonatomic,strong) UILabel *leverageTitle;//杠杆 title

@property (nonatomic,strong) Heyue_root_leverage_View *cycleTimeView;//周期时间 试图

@property(nonatomic, strong)Heyue_TitlePrice_View *zhiyingView;

@property(nonatomic, strong)Heyue_TitlePrice_View *zhisunView;


@property (nonatomic,strong) UILabel * totalMoneyTitle;//保证金

@property (nonatomic,strong) UILabel * totalMoney;//计算总额

@property (nonatomic,strong) UIButton * confrimBtn;//下单按钮

@property (nonatomic,strong) LXY_DeepView *deepView;//深度图

@property (nonatomic,strong) Heyue_Root_CountDown_View * countDownView;//倒计时View

@property (nonatomic,strong) Heyue_Pankou_View *pankouView;//盘口 试图

@property (nonatomic,strong) UIView *bottonLineView;//底部分割线


@property (nonatomic,strong) HeyueTime_Confirm_View *confirmCreateOrderView;//确定下单弹框

@property (nonatomic,assign) NSInteger isBuySell;//1 做多  2 做空

@property (nonatomic,assign) NSInteger cycleTime;//记录所选周期时间(分)

@property (nonatomic, assign) NSInteger leverage;

@property (nonatomic,assign) CGFloat cangweiNum;//记录 选择仓位

@property (nonatomic,assign) CGFloat maxZhangNum;//可购买最大 张数
@property(nonatomic)NSInteger zhangshu;//张数小数位
@property(nonatomic, copy)NSString *baozhengjinNum;
//@property (nonatomic,strong) SSKJ_UserInfo_Model *userInfoModel1;

@property (nonatomic,copy) NSString *currentPrice;


//存储f当前m秒数用于倒计时
@property (nonatomic , assign) NSInteger time;
@property (nonatomic ,assign) NSTimer *weakTimer;


@end

@implementation HeYueTime_Root_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBgColor;
        _zhangshu = kHeYue_ZhangShu;
        [self setUI];
    }
    return self;
}
#pragma mark -- 设置UI --
- (void)setUI{
    
    UIView *splitLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, ScaleW(10))];
    splitLine.backgroundColor = kSubBgColor;
    [self addSubview:splitLine];
    [self addSubview:self.timeTitleLabel];
    [self addSubview:self.buyBtn];
    [self addSubview:self.sellBtn];
    [self addSubview:self.downEarningsValueView];
    [self.downEarningsValueView addSubview:self.downEarningsTitleLabel];
    [self.downEarningsValueView addSubview:self.downEarningsValueLabel];
    [self addSubview:self.priceBgView];
    [self.priceBgView addSubview:self.currentPriceTitleLabel];
    [self.priceBgView addSubview:self.shiJiaWarmLab];
    
    
    [self addSubview:self.keyongTitle];
    [self addSubview:self.keyongLabel];
    [self addSubview:self.cycleTimeView];
    [self addSubview:self.cangweiView];
    
    [self addSubview:self.totalMoneyTitle];
    [self addSubview:self.totalMoney];
    [self addSubview:self.confrimBtn];
    [self addSubview:self.deepView];
    self.height = self.deepView.bottom + ScaleW(35);
    
    
    [self addSubview:self.countDownView];
    [self addSubview:self.pankouView];
    [self addSubview:self.bottonLineView];
    
    self.isBuySell = 1;//默认做多
    self.cangweiNum = 0;//仓位默认未选中（0）
//    self.leverage = 100;//杠杆默认100
    
}

- (UIButton *)buyBtn{
    if (_buyBtn == nil) {
        _buyBtn = [WLTools allocButton:SSKJLocalized(@"买涨", nil) textColor:kWhiteColor nom_bg:nil hei_bg:nil frame:CGRectMake(ScaleW(15), ScaleW(57), btnWidth, ScaleW(35))];
        _buyBtn.backgroundColor = kMarketUp;
        _buyBtn.cornerRadius = ScaleW(5);
        _buyBtn.titleLabel.font = systemFont(ScaleW(15));
        [_buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
}

- (UIButton *)sellBtn{
    if (_sellBtn == nil) {
        _sellBtn = [WLTools allocButton:SSKJLocalized(@"买跌", nil) textColor:kTitleColor nom_bg:nil hei_bg:nil frame:CGRectMake(self.buyBtn.right + ScaleW(7), self.buyBtn.y, btnWidth, ScaleW(35))];
        _sellBtn.backgroundColor = kGrayColor ;
        _sellBtn.cornerRadius = ScaleW(5);
        _sellBtn.titleLabel.font = systemFont(ScaleW(15));
        [_sellBtn addTarget:self action:@selector(sellBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sellBtn;
}


#pragma mark -- 当前价格输入框 --
- (UIView *)priceBgView{
    if (_priceBgView == nil) {
        _priceBgView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), self.downEarningsValueView.bottom + ScaleW(15), ViewWidth, ScaleW(45))];
//        _priceBgView.backgroundColor = kBgColor;
        _priceBgView.layer.borderColor = kLineColor.CGColor;
        _priceBgView.layer.borderWidth = ScaleW(1);
        _priceBgView.cornerRadius = ScaleW(3);
    }
    return _priceBgView;
}

//涨跌盈利值
- (UIView *)downEarningsValueView{
    if (_downEarningsValueView == nil) {
        _downEarningsValueView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), self.buyBtn.bottom + ScaleW(15), ViewWidth, ScaleW(45))];
        _downEarningsValueView.backgroundColor = kBgColor;
        _downEarningsValueView.layer.borderColor = kLineColor.CGColor;
        _downEarningsValueView.layer.borderWidth = ScaleW(1);
        _downEarningsValueView.cornerRadius = ScaleW(3);
    }
    return _downEarningsValueView;
}




- (UILabel *)currentPriceTitleLabel {
    if (!_currentPriceTitleLabel) {
        _currentPriceTitleLabel = [WLTools allocLabel:SSKJLanguage(@"当前价格") font:kFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(10), ScaleW(16), ScaleW(60), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
            _currentPriceTitleLabel.adjustsFontSizeToFitWidth = YES;
//                _currentPriceTitleLabel.backgroundColor = KRedColor;
        _currentPriceTitleLabel.numberOfLines = 1;
    }
    return _currentPriceTitleLabel;
}

- (UILabel *)shiJiaWarmLab{
    if (_shiJiaWarmLab == nil) {
        _shiJiaWarmLab = [WLTools allocLabel:SSKJLocalized(@"0.00", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        
        _shiJiaWarmLab.frame = CGRectMake(self.currentPriceTitleLabel.right, self.currentPriceTitleLabel.y, self.priceBgView.width - self.currentPriceTitleLabel.right, ScaleW(13));
        
        
//        [_shiJiaWarmLab sizeToFit];
        _shiJiaWarmLab.adjustsFontSizeToFitWidth = YES;
//        _shiJiaWarmLab.backgroundColor = kGrayColor;
        _shiJiaWarmLab.numberOfLines = 1;
    }
    return _shiJiaWarmLab;
}

- (UILabel *)downEarningsTitleLabel {
    if (!_downEarningsTitleLabel) {
        _downEarningsTitleLabel = [WLTools allocLabel:SSKJLanguage(@"涨跌盈利值") font:kFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(10), ScaleW(16), ScaleW(60), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
            _downEarningsTitleLabel.adjustsFontSizeToFitWidth = YES;
//                _currentPriceTitleLabel.backgroundColor = KRedColor;
        _downEarningsTitleLabel.numberOfLines = 1;
    }
    return _downEarningsTitleLabel;
}

- (UILabel *)downEarningsValueLabel{
    if (_downEarningsValueLabel == nil) {
        _downEarningsValueLabel = [WLTools allocLabel:SSKJLocalized(@"0.00", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        
        _downEarningsValueLabel.frame = CGRectMake(self.currentPriceTitleLabel.right, self.currentPriceTitleLabel.y, self.priceBgView.width - self.currentPriceTitleLabel.right, ScaleW(13));
        
        
//        [_shiJiaWarmLab sizeToFit];
        _downEarningsValueLabel.adjustsFontSizeToFitWidth = YES;
//        _shiJiaWarmLab.backgroundColor = kGrayColor;
        _downEarningsValueLabel.numberOfLines = 1;
    }
    return _downEarningsValueLabel;
}


- (UILabel *)keyongTitle{
    if (_keyongTitle == nil) {
        _keyongTitle = [WLTools allocLabel:SSKJLocalized(@"可用", nil) font:systemFont(ScaleW(10)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.cangweiView.bottom, ScaleW(35), ScaleW(30)) textAlignment:NSTextAlignmentLeft];
        _keyongTitle.adjustsFontSizeToFitWidth = YES;
        _keyongTitle.numberOfLines = 1;
    }
    return _keyongTitle;
}

- (UILabel *)keyongLabel{
    if (_keyongLabel == nil) {
        _keyongLabel = [WLTools allocLabel:SSKJLocalized(@"0 USDT", nil) font:systemFont(ScaleW(12)) textColor:kTitleColor frame:CGRectMake(self.keyongTitle.right + ScaleW(5), 0, self.priceBgView.width - ScaleW(40), ScaleW(30)) textAlignment:NSTextAlignmentRight];
        _keyongLabel.centerY = self.keyongTitle.centerY;
        _keyongLabel.adjustsFontSizeToFitWidth = YES;
        _keyongLabel.numberOfLines = 1;
    }
    return _keyongLabel;
}

- (Heyue_root_leverage_View *)cycleTimeView{
    if (_cycleTimeView == nil) {
        _cycleTimeView = [[Heyue_root_leverage_View alloc]initWithFrame:CGRectMake(ScaleW(15), self.keyongTitle.bottom + ScaleW(10), self.priceBgView.width, ScaleW(45))];
        _cycleTimeView.desTitle = @"时间选择";
        _cycleTimeView.isTime = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent:)];
        [_cycleTimeView addGestureRecognizer:tap];
    }
    return _cycleTimeView;
}

- (HeyueTime_Root_Cangwei_View *)cangweiView{
    if (_cangweiView == nil) {
        _cangweiView = [[HeyueTime_Root_Cangwei_View alloc]initWithFrame:CGRectMake(ScaleW(15), self.priceBgView.bottom + ScaleW(15), self.priceBgView.width, ScaleW(40))];
        _cangweiView.numberTextField.userInteractionEnabled = YES;
        _cangweiView.numberTextField.delegate = self;
        [_cangweiView.numberTextField addTarget:self action:@selector(textFiedValueChanged:) forControlEvents:(UIControlEventEditingChanged)];

        
    }
    return _cangweiView;
}




#pragma mark - 周期时间选择
-(void)tapEvent:(UITapGestureRecognizer *)gesture
{
    [self endEditing:YES];
    
    NSArray *array = [self.CycleTimer componentsSeparatedByString:@","];
    if (!array.count) {
        return;
    }
    WS(weakSelf);
    [SSKJ_Default_ActionsheetView showWithItems:array title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
        NSString *data = array[selectIndex];
        weakSelf.cycleTimeView.showTitle.text = data;
         weakSelf.cycleTime = [data integerValue];
        if (weakSelf.selectBlock) {
            weakSelf.selectBlock(weakSelf.cycleTime);
        }
        weakSelf.confirmCreateOrderView.selectCycleTime = data;
         [weakSelf calculateMaxZhangNum];
    } cancleBlock:^{
        
    }];
        
}




- (UILabel *)totalMoneyTitle{
    if (_totalMoneyTitle == nil) {
        _totalMoneyTitle = [WLTools allocLabel:SSKJLanguage(@"交易总额:") font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.cycleTimeView.bottom + ScaleW(10), ScaleW(79), ScaleW(40)) textAlignment:NSTextAlignmentLeft];
        _totalMoneyTitle.adjustsFontSizeToFitWidth = YES;
        _totalMoneyTitle.numberOfLines = 1;
    }
    return _totalMoneyTitle;
}

- (UILabel *)totalMoney{
    if (_totalMoney == nil) {
//        _totalMoney = [WLTools allocLabel:SSKJLocalized(@"0 USDT", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(self.totalMoneyTitle.x, self.totalMoneyTitle.bottom + ScaleW(5), self.priceBgView.width, ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        _totalMoney = [WLTools allocLabel:SSKJLocalized(@"0 USDT", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(self.totalMoneyTitle.right , self.totalMoneyTitle.y, self.priceBgView.width - ScaleW(79), ScaleW(40)) textAlignment:NSTextAlignmentLeft];
//        _totalMoney.adjustsFontSizeToFitWidth = YES;
//        _totalMoney.numberOfLines = 1;
        _totalMoney.numberOfLines = 0;
    }
    return _totalMoney;
}

- (UIButton *)confrimBtn{
    if (_confrimBtn == nil) {
        _confrimBtn = [WLTools allocButton:SSKJLocalized(@"请登录", nil) textColor:kWhiteColor nom_bg:nil hei_bg:nil frame:CGRectMake(ScaleW(15), self.totalMoney.bottom + ScaleW(15), self.priceBgView.width, ScaleW(44))];
        if (kLogin == 1) {
            [_confrimBtn setTitle:SSKJLocalized(@"买涨", nil) forState:UIControlStateNormal];
        }
        _confrimBtn.backgroundColor = kMarketUp;
        _confrimBtn.cornerRadius = ScaleW(5);
        _confrimBtn.titleLabel.font = systemFont(ScaleW(16));
        [_confrimBtn addTarget:self action:@selector(confrimBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confrimBtn;
}

- (LXY_DeepView *)deepView{
    if (_deepView == nil) {
        _deepView = [[LXY_DeepView alloc]initWithFrame:CGRectMake(ScaleW(15), self.confrimBtn.bottom, self.priceBgView.width, ScaleW(130))];
        [_deepView changeTitleForTimeHeyue];
    }
    return _deepView;
}

#pragma mark -- 爆仓  盘口 UI --
- (Heyue_Root_CountDown_View *)countDownView{
    if (_countDownView == nil) {
        _countDownView = [[Heyue_Root_CountDown_View alloc]initWithFrame:CGRectMake(ScreenWidth / 2, ScaleW(20), ScreenWidth / 2, ScaleW(23))];
        WS(weakSelf);
        
        _countDownView.HeyueCountDownBlock = ^{
            if (weakSelf.HeyueCountDownBlock) {
                weakSelf.HeyueCountDownBlock();
            }
        };
        
    }
    return _countDownView;
}

- (Heyue_Pankou_View *)pankouView{
    if (_pankouView == nil) {
        _pankouView = [[Heyue_Pankou_View alloc]initWithFrame:CGRectMake(ScreenWidth / 2, self.buyBtn.y, ViewWidth, self.height - ScaleW(69))];
        WS(weakSelf);
        
        _pankouView.CurrentPriceBlock = ^(NSString * _Nonnull price) {
            weakSelf.currentPrice = price;
//            if (self.isXianShiPrice == 2) {
//                weakSelf.priceTextField.text = price;
//                [weakSelf calculateMaxZhangNum];
//            }
        };
    }
    return _pankouView;
}

- (UIView *)bottonLineView{
    if (_bottonLineView == nil) {
        _bottonLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - ScaleW(10), ScreenWidth, ScaleW(10))];
        _bottonLineView.backgroundColor = kSubBgColor;
    }
    return _bottonLineView;
}


- (UILabel *)timeTitleLabel {
    if (!_timeTitleLabel) {
        _timeTitleLabel = [WLTools allocLabel:@"第--期" font:kFont(16) textColor:kTitleColor frame:CGRectMake(ScaleW(15), ScaleW(22), ViewWidth - ScaleW(15), ScaleW(16)) textAlignment:NSTextAlignmentLeft];
    }
    return _timeTitleLabel;
}
#pragma mark -- 用户操作 --
#pragma mark -- 点击做多 --
- (void)buyBtnAction{
    
    if (kLogin == 1) {
        [self.confrimBtn setTitle:SSKJLocalized(@"买涨", nil) forState:UIControlStateNormal];
    }
    
    _buyBtn.backgroundColor = kMarketUp;
    [_buyBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];

    [_sellBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
    _sellBtn.backgroundColor = kGrayColor;
    
    self.confrimBtn.backgroundColor = kMarketUp;
    self.isBuySell = 1;
    [self cleanData];
}
- (void)changeUI{
    if (kLogin == 1) {
        if (self.isBuySell == 1) {
           [self.confrimBtn setTitle:SSKJLocalized(@"买涨", nil) forState:UIControlStateNormal];
        }else{
            [self.confrimBtn setTitle:SSKJLocalized(@"买跌", nil) forState:UIControlStateNormal];
        }
    }else{
        [self.confrimBtn setTitle:SSKJLocalized(@"请登录", nil) forState:UIControlStateNormal];
    }
}
#pragma mark -- 点击做空 --
- (void)sellBtnAction{
     [self endEditing:YES];
    if (kLogin == 1) {
        [self.confrimBtn setTitle:SSKJLocalized(@"买跌", nil) forState:UIControlStateNormal];
    }
    _sellBtn.backgroundColor = kMarketDown;
    [_sellBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    
    [_buyBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
    _buyBtn.backgroundColor = kGrayColor;
    
    
    self.confrimBtn.backgroundColor = kMarketDown;
    self.isBuySell = 2;
    [self cleanData];
}
#pragma mark -- 下单 --
- (void)confrimBtnAction{
     [self endEditing:YES];
     [self endEditing:YES];
    if (kLogin != 1) {
        if (self.HeyuegLoginBlock) {
            self.HeyuegLoginBlock();
        }
        return;
    }
    //判断用户是否实名认证
//    if ([SSKJ_User_Tool sharedUserTool].userInfoModel.authentication) {
//        [MBProgressHUD showError:@"实名认证"];
//        return;
//    }
    
    
    //判断资金不足
    
    if ([self.cangweiView.numberTextField.text doubleValue] <= 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入数量", nil)];
        return;
    }
    
    //判断是否达到最小购买数量
//    if (self.cangweiView.numberTextField.text.integerValue < self.leverageModel.contractMin.integerValue) {
//        [MBProgressHUD showError:[NSString stringWithFormat:@"%@%ld",SSKJLocalized(@"最少购买", nil),(long)self.leverageModel.contractMin.integerValue]];
//        return;
//    }
    
    
//    if (!self.zhiyingView.value.length) {
//        [SSTool error:SSKJLanguage(@"请输入止盈价格")];
//        return;
//    }
//
//    if (!self.zhisunView.value.length) {
//        [SSTool error:SSKJLanguage(@"请输入止损价格")];
//        return;
//    }
    
//    CGFloat money = [data[@"bondMoney"] doubleValue] * [data[@"buyMoney"] doubleValue];
    NSDictionary *params;
    
    //保证金
    CGFloat baozhengjin = self.cangweiView.numberTextField.text.floatValue * [self.ValueData[@"price"] floatValue];
    NSArray *arr = [self.leverageModel.stockCode componentsSeparatedByString:@"/"];
    if (arr.count <= 0) {
        arr = @[@"BTC"];
    }
        params = @{
        @"billType":self.isBuySell==1?@"0":@"1",
        @"stockCode":arr.firstObject,
        @"bondMoney":[SSTool disposePname:@([SSTool HeyuePname:self.model.code]) price:@(baozhengjin)],//保证金
        @"buyMoney":[NSString stringWithFormat:@"%@", self.currentPrice],
        @"cycleNum" : self.ValueData[@"cycleNum"] ? self.ValueData[@"cycleNum"] : @"-",//周期数
        @"cycleTime" : self.ValueData[@"timeLeverCycle"] ? self.ValueData[@"timeLeverCycle"] : @"-",//持仓周期时间,
        };
    [self.confirmCreateOrderView showWithData:params];
}


#pragma mark -- 数据获取 --  可用价格
- (void)setWallone_usdt:(NSString *)wallone_usdt{
    _wallone_usdt = wallone_usdt;
    self.keyongLabel.text = [NSString stringWithFormat:@"%@USDT",[SSTool HeyuePname:self.leverageModel.stockCode price:wallone_usdt]];
    
    [self calculateMaxZhangNum];
}

- (void)setTimeLeverCycle:(NSString *)timeLeverCycle {
    _timeLeverCycle = timeLeverCycle;
//    [_countDownView.countDownBtn setTitle:[NSString stringWithFormat:@"%@：%@%@",SSKJLocalized(@"风险率", nil),[SSTool disposePname:@"2" price:timeLeverCycle],@"%"] forState:UIControlStateNormal];
    self.time = _timeLeverCycle.integerValue;
    //秒转分时
    NSString *timeStr = [WLTools getHHMMSSFromSS:timeLeverCycle];
    [_countDownView.countDownBtn setTitle:[NSString stringWithFormat:@"%@%@",SSKJLanguage(@"距本期结束:"),timeStr] forState:UIControlStateNormal];
    
    [self startTimer];

}

- (void)setCycleTimer:(NSString *)CycleTimer {
    _CycleTimer = CycleTimer;
    NSArray *array = [CycleTimer componentsSeparatedByString:@","];
    
    if (array.count > 0) {
        self.cycleTime = [array[0] integerValue];
        self.confirmCreateOrderView.selectCycleTime = [NSString stringWithFormat:@"%ld",(long)self.cycleTime];
        self.cycleTimeView.showTitle.text = array[0];
    }
}


- (void)setCRange:(NSString *)cRange {
    _cRange = cRange;
    self.downEarningsValueLabel.text = [NSString stringWithFormat:@"%@ USDT",cRange];
}

- (void)startTimer{
    if (self.weakTimer) {
        [self endTimer];
    }
    
    __weak typeof(self) weakself = self;
    self.weakTimer = [NSTimer sxf_weakTimerSchedulTimerWithTimerinter:1 block:^{
        __strong typeof(weakself) strongSelf = weakself;
        [strongSelf countDown];
    } repeats:YES];
    
    
}
- (void)endTimer{
    [self.weakTimer invalidate];
    self.weakTimer = nil;
}
//倒计时数据
- (void) countDown{
    if (self.time <= 0) {
        //回调结束
        [self endTimer];
        !self.timerEndCallback ? : self.timerEndCallback();
        [_countDownView.countDownBtn setTitle:SSKJLanguage(@"本期结束") forState:UIControlStateNormal];
    }else{
        NSString *timeStr = [WLTools getHHMMSSFromSS:[NSString stringWithFormat:@"%ld", self.time]];
        [_countDownView.countDownBtn setTitle:[NSString stringWithFormat:@"%@%@",SSKJLanguage(@"距本期结束:"),timeStr] forState:UIControlStateNormal];
    }
    
    self.time --;
}
#pragma mark - 实时价格
- (void)setModel:(SSKJ_Market_Index_Model *)model{
    _model = model;

    NSString *price = [SSTool disposePname:@([SSTool HeyuePname:model.code]) price:model.price];
//    if (self.isXianShiPrice == 1) {
//        self.priceTextField.text = price;
//    }
    self.shiJiaWarmLab.text = price;
//    [self.shiJiaWarmLab sizeToFit];
    self.currentPrice = self.shiJiaWarmLab.text;
    self.pankouView.model = model;
    [self calculateMaxZhangNum];
    
    
     [self calculateBaoZhengJin];

}
#pragma mark - 基本信息数据
- (void)setLeverageModel:(Heyue_Leverage_Model *)leverageModel{
    
    
    _leverageModel = leverageModel;
    NSArray *array = [leverageModel.stockLever componentsSeparatedByString:@","];
    //获取杠杆倍数数据
    if (array.count > 0) {
        self.leverage = [array[0] integerValue];
//        self.leverageView.showTitle.text = array[0];
    }
//    NSString *coinName = [leverageModel.stockCode componentsSeparatedByString:@"/"].firstObject;
//    [WLTools textField:self.cangweiView.numberTextField setPlaceHolder:[NSString stringWithFormat:SSKJLocalized(@"1张=%@%@", nil),[SSTool HeyuePname:leverageModel.stockCode price:leverageModel.lotSize], coinName] color:kSubTitleColor];
    
    [self calculateMaxZhangNum];
    //数据还原
    [self reductionData];
     
     
}


- (void)setShenduDic:(NSDictionary *)shenduDic{
//    [self.deepView setData:shenduDic];
    [self.deepView setData:shenduDic isLarge:YES];
    
    
    
}
- (void)setValueData:(NSDictionary *)ValueData{
    _ValueData = ValueData;
    
//    NSString *coinName = [ValueData[@"price"] componentsSeparatedByString:@"/"].firstObject;
//    [WLTools textField:self.cangweiView.numberTextField setPlaceHolder:[NSString stringWithFormat:SSKJLocalized(@"1张=%@%@", nil),[SSTool HeyuePname:ValueData[@"price"] price:SSKJLocalized(@"USDT", nil)], coinName] color:kSubTitleColor];
    
    [WLTools textField:self.cangweiView.numberTextField setPlaceHolder:[NSString stringWithFormat:SSKJLocalized(@"1张=%@%@", nil), ValueData[@"price"], @"USDT"] color:kSubTitleColor];
    
    //数据还原
    [self reductionData];
}
- (void)setPankouModel:(PanKou_Socket_Model *)pankouModel{
    self.pankouView.pankouModel = pankouModel;
}

#pragma mark -- 计算最大张数 --
- (void)calculateMaxZhangNum{
    //实时价
    CGFloat currentPrice = self.currentPrice.doubleValue;
    //手续费费率
    CGFloat trans_fee = self.leverageModel.leverDealFee.doubleValue / 100;
    //如果是 做多需要加上最小变动价  做空需要减去最小变动价
    if (self.isBuySell == 1) {
        currentPrice = currentPrice + self.leverageModel.spread.doubleValue * self.leverageModel.slidingScalePrice.doubleValue;
    }else{
        currentPrice = currentPrice - self.leverageModel.spread.doubleValue * self.leverageModel.slidingScalePrice.doubleValue;
    }
    
    
    
    
    CGFloat total = self.wallone_usdt.doubleValue;
    if (self.cangweiNum > 0) {
//        total = total * self.cangweiNum;
    }
    self.maxZhangNum = total / ([self.ValueData[@"price"] floatValue] == 0 ? 1 : [self.ValueData[@"price"] floatValue]);
    
    if (self.cangweiNum > 0) {
        self.cangweiView.numberTextField.text = [SSTool disposePname:@(_zhangshu) price:[NSString stringWithFormat:@"%.9f", self.maxZhangNum]];
    }else{
        
        if (self.cangweiView.numberTextField.text.doubleValue > self.maxZhangNum) {
            self.cangweiView.numberTextField.text = [SSTool disposePname:@(_zhangshu) price:[NSString stringWithFormat:@"%.9f", self.maxZhangNum]];
        }
        
    }
    
    [self calculateBaoZhengJin];
    
}


#pragma mark -- 计算保证金 --
- (void)calculateBaoZhengJin{
    
    /*
     保证金 = 下单张数 * 每张币数 * 市价 / 杠杆
     手续费 = 下单张数 * 每张币数 * 市价 * 手续费比例
     总额 = 保证金 + 手续费
     */
    
    if (!self.leverage) {
        return;
    }
    
    //实时价
    CGFloat currentPrice = self.currentPrice.doubleValue;
    //购买张数
    CGFloat buyNum = self.cangweiView.numberTextField.text.doubleValue;
    
    //手续费费率
//    CGFloat trans_fee = self.leverageModel.leverDealFee.doubleValue / 100;
    
    //如果是 做多需要加上最小变动价  做空需要减去最小变动价
//    if (self.isXianShiPrice == 1) {
        if (self.isBuySell == 1) {
            currentPrice = currentPrice + self.leverageModel.spread.doubleValue * self.leverageModel.slidingScalePrice.doubleValue;
        }else{
            currentPrice = currentPrice - self.leverageModel.spread.doubleValue * self.leverageModel.slidingScalePrice.doubleValue;
        }
//    }
    
    //保证金
    CGFloat amount = 0;
    
    amount = buyNum * self.leverageModel.lotSize.doubleValue * currentPrice / self.leverage;
    self.baozhengjinNum = [SSTool HeyuePname:self.leverageModel.stockCode price:[NSString stringWithFormat:@"%.9f", amount]];
//    self.totalMoney.text = [NSString stringWithFormat:@"%@USDT", [SSTool HeyuePname:self.leverageModel.stockCode price:[NSString stringWithFormat:@"%.9f", amount + [self calculateshouxufei].doubleValue]]];
    
    
    
    
    
    CGFloat totalMoney = [self.ValueData[@"price"] floatValue] * self.cangweiView.numberTextField.text.doubleValue;
    self.totalMoney.text = [NSString stringWithFormat:@"%@ USDT", [SSTool MarketPname:self.model.code price:@(totalMoney)]];
    

}

#pragma mark - 计算手续费
- (NSString *)calculateshouxufei{
    
    CGFloat currentPrice = self.currentPrice.doubleValue;
    CGFloat trans_fee = self.leverageModel.leverDealFee.doubleValue / 100;
    CGFloat buyNum = self.cangweiView.numberTextField.text.doubleValue;
    
    CGFloat shouxufei = buyNum * self.leverageModel.lotSize.doubleValue * currentPrice * trans_fee;
    return [SSTool HeyuePname:self.leverageModel.stockCode price:[NSString stringWithFormat:@"%.9f", shouxufei]];
}


#pragma mark -- 价格监听事件 --UITextFieldDelegate
//参数一：range，要被替换的字符串的range，如果是新输入的，就没有字符串被替换，range.length = 0
//参数二：替换的字符串，即键盘即将输入或者即将粘贴到textField的string
//返回值为BOOL类型，YES表示允许替换，NO表示不允许
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{

    if (string.length == 0) {
        return YES;
    }

    NSString *checkStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSString *regex;
    if ([textField isEqual:self.currentPrice]) {
        regex = [NSString stringWithFormat:@"^\\-?([1-9]\\d*|0)(\\.\\d{0,%zd})?$",[SSTool HeyuePname:self.model.code]];
    }else if ([textField isEqual:self.cangweiView.numberTextField]) {
        regex = [NSString stringWithFormat:@"^\\-?([1-9]\\d*|0)(\\.\\d{0,%zd})?$",self.zhangshu];
    }
    
    
    return [self isValid:checkStr withRegex:regex];
    
}

//检测改变过的文本是否匹配正则表达式，如果匹配表示可以键入，否则不能键入
- (BOOL) isValid:(NSString*)checkStr withRegex:(NSString*)regex
{
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:checkStr];
}


#pragma mark -- 价格或数量发生变化时的监听事件 --
-(void)textFiedValueChanged:(UITextField *)textFlied{
    [self clearCangWei];


        if (self.cangweiView.numberTextField.text.doubleValue > self.maxZhangNum) {
            self.cangweiView.numberTextField.text = [SSTool disposePname:@(_zhangshu) price:[NSString stringWithFormat:@"%.9f", self.maxZhangNum]];
        }

    //计算保证金
    [self calculateBaoZhengJin];
    
}


#pragma mark  -- 清空数据 选择的数据--
- (void)cleanData{
    //百分比
    self.cangweiNum = 0;
    self.totalMoney.text = @"0USDT";
    self.cangweiView.numberTextField.text = @"";
    self.shiJiaWarmLab.text = [SSTool disposePname:@([SSTool HeyuePname:self.model.code]) price:self.model.price];
}

#pragma mark  -- 清空数据 (数据还原) --
- (void)reductionData{//还原原始数据
    self.isBuySell = 1;
//    self.isXianShiPrice = 1;
//    self.cangweiNum = 0;
//    self.cangweiView.numberTextField.text = @"";
//    self.totalMoney.text = @"0USDT";

//    self.priceBgView.backgroundColor = kGrayColor;
    
    self.shiJiaWarmLab.hidden = NO;
    

    self.confrimBtn.backgroundColor = kMarketUp;
    
    [self buyBtnAction];
}

- (void)clearCangWei{
    self.cangweiNum = 0;
}


#pragma mark -- 确认下单弹框 --
- (HeyueTime_Confirm_View *)confirmCreateOrderView{
    if (_confirmCreateOrderView == nil) {
        _confirmCreateOrderView = [[HeyueTime_Confirm_View alloc]initWithFrame:[UIScreen mainScreen].bounds];
        WS(weakSelf);
        _confirmCreateOrderView.isTimer = self.isTimer;
        _confirmCreateOrderView.confirmBlock = ^(NSDictionary * _Nonnull dic) {
            if (weakSelf.HeyueCreateOrderBlock) {
                weakSelf.HeyueCreateOrderBlock(dic);
            }
        };
    }
    return _confirmCreateOrderView;
}




@end
