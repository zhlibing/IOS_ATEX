//
//  HeYue_Root_HeaderView.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//


/*
 保证金 = 下单张数 * 每张币数 * 市价 / 杠杆
 手续费 = 下单张数 * 每张币数 * 市价 * 手续费比例
 总额 = 保证金 + 手续费
 */

#import "HeYue_Root_HeaderView.h"

#import "Heyue_Choose_XianShiPrice_View.h"//选择市价 限价 试图

#import "Heyue_Root_Cangwei_View.h"//仓位 试图

#import "Heyue_root_leverage_View.h"//杠杆 试图

#import "LXY_DeepView.h"//深度图

#import "Heyue_Root_Decimal_View.h"//爆仓  选择小数位 试图

#import "Heyue_Pankou_View.h"//盘口试图

#import "Heyue_Confirm_View.h"//确认下单弹框

#import "HeYue_Leverage_View.h"

#import "LiuXSlider.h"

#define btnWidth (ScreenWidth / 2 - ScaleW(30) - ScaleW(7)) / 2

#define ViewWidth ScreenWidth / 2 - ScaleW(15)

@interface HeYue_Root_HeaderView()<UITextFieldDelegate>

@property (nonatomic,strong) UIButton *buyBtn;// 做多/买入

@property (nonatomic,strong) UIButton *sellBtn;// 做多/买入

@property (nonatomic,strong) UIButton *xianjiaBtn;// 限价 市价 按钮

@property (nonatomic,strong) UIButton *xianjiaImg;// 限价 市价 按钮

@property (nonatomic,strong) UILabel * shiJiaWarmLab;//以当前最优价格交易

@property (nonatomic,strong) UIView * priceBgView;//当前价格背景试图

@property (nonatomic,strong) UITextField * priceTextField;//当前价格输入框

@property (nonatomic,strong) UILabel * usdtUnit;//usdt 单位

@property (nonatomic,strong) UIButton * jiaBtn;//加按钮

@property (nonatomic,strong) UIButton * jianBtn;//减按钮


@property (nonatomic,strong) UILabel * keyongTitle;//可用title

@property (nonatomic,strong) UILabel * keyongLabel;//可用price

@property (nonatomic,strong) Heyue_Root_Cangwei_View *cangweiView;//输入数量  仓位 试图

//@property (nonatomic,strong) UILabel *leverageTitle;//杠杆 title

@property (nonatomic,strong) Heyue_root_leverage_View *leverageView;//杠杆 试图
@property (nonatomic,strong) LiuXSlider *leverageSlider;//杠杆 试图

@property(nonatomic, strong)Heyue_TitlePrice_View *zhiyingView;

@property(nonatomic, strong)Heyue_TitlePrice_View *zhisunView;


@property (nonatomic,strong) UILabel * totalMoneyTitle;//保证金

@property (nonatomic,strong) UILabel * totalMoney;//计算总额

@property (nonatomic,strong) UIButton * confrimBtn;//下单按钮

@property (nonatomic,strong) LXY_DeepView *deepView;//深度图

@property (nonatomic,strong) Heyue_Root_Decimal_View * decimalView;//爆仓 小数位 试图

@property (nonatomic,strong) Heyue_Pankou_View *pankouView;//盘口 试图

@property (nonatomic,strong) UIView *bottonLineView;//底部分割线

@property (nonatomic,strong) Heyue_Choose_XianShiPrice_View *shixianjiaAlertView;//  选择市/限价 试图

@property (nonatomic,strong) Heyue_Confirm_View *confirmCreateOrderView;//确定下单弹框

@property (nonatomic,assign) NSInteger isBuySell;//1 做多  2 做空

@property (nonatomic,assign) NSInteger isXianShiPrice;//1 市价  2 限价

@property (nonatomic,assign) NSInteger leverage;//记录杠杆倍数

@property (nonatomic,assign) double cangweiNum;//记录 选择仓位

@property (nonatomic,assign) double maxZhangNum;//可购买最大 张数
@property(nonatomic)NSInteger zhangshu;//张数小数位
@property(nonatomic)NSInteger shuliang;//币本合约数量小数位
@property(nonatomic, strong)NSArray *cangweiArray;//仓位选择
@property(nonatomic, copy)NSString *baozhengjinNum;
//@property (nonatomic,strong) SSKJ_UserInfo_Model *userInfoModel1;
@end

@implementation HeYue_Root_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBgColor;
        _zhangshu = kHeYue_ZhangShu;
        _shuliang = kHeYue_Biben_Num;
        self.cangweiArray = @[@"25%",@"50%",@"75%",@"100%"];
        [self setUI];
    }
    return self;
}
#pragma mark -- 设置UI --
- (void)setUI{
    
    UIView *splitLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, ScaleW(10))];
    splitLine.backgroundColor = kSubBgColor;
    [self addSubview:splitLine];
    
    [self addSubview:self.buyBtn];
    [self addSubview:self.sellBtn];
    [self addSubview:self.xianjiaBtn];
    [self addSubview:self.xianjiaImg];
    [self addSubview:self.priceBgView];
    [self.priceBgView addSubview:self.priceTextField];
    [self.priceBgView addSubview:self.jianBtn];
    [self.priceBgView addSubview:self.jiaBtn];
    
    [self.priceBgView addSubview:self.shiJiaWarmLab];
    
    [self addSubview:self.keyongTitle];
    [self addSubview:self.keyongLabel];
    [self addSubview:self.cangweiView];
    [self addSubview:self.leverageView];
    
//    [self addSubview:self.zhiyingView];
//    [self addSubview:self.zhisunView];
    
    [self addSubview:self.totalMoneyTitle];
    [self addSubview:self.totalMoney];
    [self addSubview:self.confrimBtn];
    [self addSubview:self.deepView];
    self.height = self.deepView.bottom + ScaleW(15);
    
    
    [self addSubview:self.decimalView];
    [self addSubview:self.pankouView];
    [self addSubview:self.bottonLineView];
    
    self.isXianShiPrice = 1;//默认市价交易
    self.isBuySell = 1;//默认做多
    self.cangweiNum = 0;//仓位默认未选中（0）
//    self.leverage = 100;//杠杆默认100
    
}

- (UIButton *)buyBtn{
    if (_buyBtn == nil) {
        _buyBtn = [WLTools allocButton:SSKJLocalized(@"做多", nil) textColor:kWhiteColor nom_bg:nil hei_bg:nil frame:CGRectMake(ScaleW(15), ScaleW(43), btnWidth, ScaleW(35))];
//        _buyBtn.backgroundColor = kMarketUp;
        [_buyBtn setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        [_buyBtn setTitleColor:kTitleColor forState:UIControlStateSelected];
        [_buyBtn setBackgroundImage:[UIImage imageNamed:@"dolong_normal"] forState:UIControlStateNormal];
        [_buyBtn setBackgroundImage:[UIImage imageNamed:@"dolong_select"] forState:UIControlStateSelected];
        _buyBtn.selected = YES;
        _buyBtn.cornerRadius = ScaleW(5);
        _buyBtn.titleLabel.font = systemFont(ScaleW(15));
        [_buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
}

- (UIButton *)sellBtn{
    if (_sellBtn == nil) {
        _sellBtn = [WLTools allocButton:SSKJLocalized(@"做空", nil) textColor:kTitleColor nom_bg:nil hei_bg:nil frame:CGRectMake(self.buyBtn.right + ScaleW(7), self.buyBtn.y, btnWidth, ScaleW(35))];
//        _sellBtn.backgroundColor = kGrayColor ;
        [_sellBtn setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        [_sellBtn setTitleColor:kTitleColor forState:UIControlStateSelected];
        [_sellBtn setBackgroundImage:[UIImage imageNamed:@"doshort_normal"] forState:UIControlStateNormal];
        [_sellBtn setBackgroundImage:[UIImage imageNamed:@"doshort_select"] forState:UIControlStateSelected];
        _sellBtn.cornerRadius = ScaleW(5);
        _sellBtn.titleLabel.font = systemFont(ScaleW(15));
        [_sellBtn addTarget:self action:@selector(sellBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sellBtn;
}

- (UIButton *)xianjiaBtn{
    if (_xianjiaBtn == nil) {
        _xianjiaBtn = [WLTools allocButton:SSKJLocalized(@"市价交易", nil) textColor:kTitleColor nom_bg:nil hei_bg:nil frame:CGRectMake(ScaleW(15), self.buyBtn.bottom + ScaleW(7), ScaleW(60), ScaleW(43))];
        _xianjiaBtn.titleLabel.font = systemFont(ScaleW(13));
        [_xianjiaBtn addTarget:self action:@selector(xianjiaBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _xianjiaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
    }
    return _xianjiaBtn;
}

- (UIButton *)xianjiaImg{
    if (_xianjiaImg == nil) {
        UIImage *image = [UIImage imageNamed:@"hy_down"];
        _xianjiaImg = [WLTools allocButton:SSKJLocalized(@"", nil) textColor:kWhiteColor nom_bg:nil hei_bg:nil frame:CGRectMake(self.xianjiaBtn.right + ScaleW(5), self.buyBtn.bottom + ScaleW(5), image.size.width, image.size.height)];
        _xianjiaImg.centerY = self.xianjiaBtn.centerY;
        [_xianjiaImg setImage:image forState:UIControlStateNormal];
        [_xianjiaImg addTarget:self action:@selector(xianjiaBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _xianjiaImg;
}

#pragma mark -- 当前价格输入框 --
- (UIView *)priceBgView{
    if (_priceBgView == nil) {
        _priceBgView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), self.xianjiaBtn.bottom, ViewWidth, ScaleW(45))];
        _priceBgView.backgroundColor = kBgColor;
        _priceBgView.layer.borderColor = kLineColor.CGColor;
        _priceBgView.layer.borderWidth = ScaleW(1);
        _priceBgView.cornerRadius = ScaleW(3);
    }
    return _priceBgView;
}



- (UILabel *)usdtUnit{
    if (_usdtUnit == nil) {
        _usdtUnit = [WLTools allocLabel:SSKJLocalized(@"USDT", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.priceTextField.right, 0, ScaleW(60), ScaleW(40)) textAlignment:NSTextAlignmentCenter];
        _usdtUnit.hidden = YES;
    }
    return _usdtUnit;
}


- (UIButton *)jianBtn{
    if (_jianBtn == nil) {
        _jianBtn = [WLTools allocButton:SSKJLocalized(@"", nil) textColor:nil nom_bg:nil hei_bg:nil frame:CGRectMake(_priceTextField.right, 0, (_priceBgView.width - _priceTextField.width) * 0.5, _priceBgView.height)];
        _jianBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _jianBtn.hidden = YES;
        [_jianBtn setImage:UIImageNamed(@"hy_minus") forState:UIControlStateNormal];
//        [_jianBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
//        _jianBtn.backgroundColor = kGrayColor;
        [_jianBtn addTarget:self action:@selector(jianPrice) forControlEvents:UIControlEventTouchUpInside];

    }
    return _jianBtn;
}

- (UIButton *)jiaBtn{
    if (_jiaBtn == nil) {
        _jiaBtn = [WLTools allocButton:SSKJLocalized(@"", nil) textColor:nil nom_bg:nil hei_bg:nil frame:CGRectMake(_jianBtn.right, 0, _jianBtn.width, _jianBtn.height)];
        _jiaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_jiaBtn setImage:UIImageNamed(@"hy_add") forState:UIControlStateNormal];
//        [_jiaBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
//        _jiaBtn.backgroundColor = kGrayColor;
        _jiaBtn.hidden = YES;
        [_jiaBtn addTarget:self action:@selector(addPrice) forControlEvents:UIControlEventTouchUpInside];

        
    }
    return _jiaBtn;
}


- (UILabel *)shiJiaWarmLab{
    if (_shiJiaWarmLab == nil) {
        _shiJiaWarmLab = [WLTools allocLabel:SSKJLocalized(@"以当前最优价格交易", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:self.priceBgView.bounds textAlignment:NSTextAlignmentCenter];
        _shiJiaWarmLab.adjustsFontSizeToFitWidth = YES;
        _shiJiaWarmLab.backgroundColor = kSubBgColor;
        _shiJiaWarmLab.numberOfLines = 1;
    }
    return _shiJiaWarmLab;
}
#pragma mark --- 减点击事件 ---
- (void)jianPrice{
    
    
    NSString *str = [NSString stringWithFormat:@"%.9f", [self.priceTextField.text doubleValue] - self.leverageModel.product.var_price.doubleValue];
    
    if ([str doubleValue] < 0) {
        self.priceTextField.text = @"0";
    }else{
        self.priceTextField.text = [SSTool disposePname:@([SSTool HeyuePname:self.leverageModel.code]) price:str];
        
    }
    
    [self calculateMaxZhangNum];
}



#pragma mark --- 加点击事件 ---

- (void)addPrice{
    
    NSString *str = [NSString stringWithFormat:@"%.9f", [self.priceTextField.text doubleValue] + self.leverageModel.product.var_price.doubleValue];
    
    if ([str doubleValue] < 0) {
        self.priceTextField.text = @"0";
    }else{
        self.priceTextField.text = [SSTool disposePname:@([SSTool HeyuePname:self.leverageModel.code]) price:str];
    }
    [self calculateMaxZhangNum];
}

- (UITextField *)priceTextField{
    if (_priceTextField == nil) {
        _priceTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, ScaleW(95), ScaleW(45))];
        _priceTextField.enabled = NO;
        
        _priceTextField.userInteractionEnabled = YES;
        _priceTextField.delegate = self;
//        [_priceTextField addTarget:self action:@selector(textFiedValueChanged:) forControlEvents:(UIControlEventEditingChanged)];
        [WLTools textField:_priceTextField setPlaceHolder:SSKJLocalized(@"0", nil) color:kSubTitleColor];
        _priceTextField.textColor = kTitleColor;
        _priceTextField.textAlignment = NSTextAlignmentCenter;
        _priceTextField.font = systemFont(ScaleW(13));
        //模拟数据
        _priceTextField.text = SSKJLocalized(@"以当前最优价格交易", nil);
        _priceTextField.keyboardType = UIKeyboardTypeDecimalPad;
    }
    return _priceTextField;
}

- (UILabel *)keyongTitle{
    if (_keyongTitle == nil) {
        _keyongTitle = [WLTools allocLabel:SSKJLocalized(@"可用", nil) font:systemFont(ScaleW(10)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.priceBgView.bottom, ScaleW(35), ScaleW(30)) textAlignment:NSTextAlignmentLeft];
        _keyongTitle.adjustsFontSizeToFitWidth = YES;
        _keyongTitle.numberOfLines = 1;
    }
    return _keyongTitle;
}

- (UILabel *)keyongLabel{
    if (_keyongLabel == nil) {
        _keyongLabel = [WLTools allocLabel:SSKJLocalized(@"0 USDT", nil) font:systemFont(ScaleW(12)) textColor:kTitleColor frame:CGRectMake(self.keyongTitle.right + ScaleW(5), self.priceBgView.bottom, self.priceBgView.width - ScaleW(40), ScaleW(30)) textAlignment:NSTextAlignmentRight];
        _keyongLabel.adjustsFontSizeToFitWidth = YES;
        _keyongLabel.numberOfLines = 1;
    }
    return _keyongLabel;
}

- (Heyue_Root_Cangwei_View *)cangweiView{
    if (_cangweiView == nil) {
        _cangweiView = [[Heyue_Root_Cangwei_View alloc]initWithFrame:CGRectMake(ScaleW(15), self.keyongTitle.bottom, self.priceBgView.width, ScaleW(65))];
        _cangweiView.numberTextField.userInteractionEnabled = YES;
        _cangweiView.numberTextField.delegate = self;
        _cangweiView.array = self.cangweiArray;
        [_cangweiView.numberTextField addTarget:self action:@selector(textFiedValueChanged:) forControlEvents:(UIControlEventEditingChanged)];
        WS(weakSelf);
        _cangweiView.CangweiBlock = ^(CGFloat cangwei) {
            [weakSelf endEditing:YES];

            weakSelf.cangweiNum = cangwei / 100.0;
            [weakSelf calculateMaxZhangNum];
        };
        
    }
    return _cangweiView;
}

//- (UILabel *)leverageTitle{
//    if (_leverageTitle == nil) {
//        _leverageTitle = [WLTools allocLabel:SSKJLocalized(@"杠杆倍数", nil) font:systemFont(ScaleW(12)) textColor:kTextColor8e94a3 frame:CGRectMake(ScaleW(10), self.cangweiView.bottom, ViewWidth, ScaleW(30)) textAlignment:NSTextAlignmentLeft];
//        _leverageTitle.adjustsFontSizeToFitWidth = YES;
//    }
//    return _leverageTitle;
//}

- (Heyue_root_leverage_View *)leverageView{
    if (_leverageView == nil) {
        _leverageView = [[Heyue_root_leverage_View alloc]initWithFrame:CGRectMake(ScaleW(15), self.cangweiView.bottom + ScaleW(10), self.priceBgView.width, ScaleW(45))];
        _leverageView.desTitle = @"杠杆倍数";
        _leverageView.isTime = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent:)];
        [_leverageView addGestureRecognizer:tap];
    }
    return _leverageView;
}


#pragma mark - 杠杆倍数
-(void)tapEvent:(UITapGestureRecognizer *)gesture
{
    [self endEditing:YES];
    
    NSMutableArray *mArray = [NSMutableArray array];
    NSArray *array = _leverageModel.product.leverage;
    if (!array.count) {
        return;
    }
    //获取杠杆倍数数据
    if (array.count > 0) {
        for (NSString *object in array) {
            //多加一层判断，当字符串为0，剔除出数组，防止后台杠杆倍数设置为0的情况
            if (![object isEqualToString:@"0"]) {
                [mArray addObject:object];
            }
        };
    }
    WS(weakSelf);
    [SSKJ_Default_ActionsheetView showWithItems:mArray title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
        NSString *data = mArray[selectIndex];
        weakSelf.leverageView.showTitle.text = data;
         weakSelf.leverage = [data integerValue];
         [weakSelf calculateMaxZhangNum];
    } cancleBlock:^{
        
    }];
        
}



- (Heyue_TitlePrice_View *)zhiyingView{
    if (!_zhiyingView) {
        _zhiyingView = [[Heyue_TitlePrice_View alloc] initWithFrame:CGRectMake(ScaleW(15), self.leverageView.bottom + ScaleW(10), self.priceBgView.width, ScaleW(45)) Title:SSKJLanguage(@"止盈价格")];
    }
    return _zhiyingView;
}

- (Heyue_TitlePrice_View *)zhisunView{
    if (!_zhisunView) {
        _zhisunView = [[Heyue_TitlePrice_View alloc] initWithFrame:CGRectMake(ScaleW(15), self.zhiyingView.bottom + ScaleW(10), self.priceBgView.width, ScaleW(45)) Title:SSKJLanguage(@"止损价格")];
    }
    return _zhisunView;
}

- (UILabel *)totalMoneyTitle{
    if (_totalMoneyTitle == nil) {
        _totalMoneyTitle = [WLTools allocLabel:[NSString stringWithFormat:@"%@:",SSKJLanguage(@"占用保证金")] font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.leverageView.bottom + ScaleW(10), ScaleW(79), ScaleW(40)) textAlignment:NSTextAlignmentLeft];
        _totalMoneyTitle.adjustsFontSizeToFitWidth = YES;
        _totalMoneyTitle.numberOfLines = 1;
    }
    return _totalMoneyTitle;
}

- (UILabel *)totalMoney{
    if (_totalMoney == nil) {
//        _totalMoney = [WLTools allocLabel:SSKJLocalized(@"0 USDT", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(self.totalMoneyTitle.x, self.totalMoneyTitle.bottom + ScaleW(5), self.priceBgView.width, ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        _totalMoney = [WLTools allocLabel:SSKJLocalized(@"0    ", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(self.totalMoneyTitle.right , self.totalMoneyTitle.y, self.priceBgView.width - ScaleW(79), ScaleW(40)) textAlignment:NSTextAlignmentLeft];
        _totalMoney.adjustsFontSizeToFitWidth = YES;
        _totalMoney.numberOfLines = 1;
        _totalMoney.numberOfLines = 0;
    }
    return _totalMoney;
}

- (UIButton *)confrimBtn{
    if (_confrimBtn == nil) {
        _confrimBtn = [WLTools allocButton:SSKJLocalized(@"请登录", nil) textColor:kWhiteColor nom_bg:nil hei_bg:nil frame:CGRectMake(ScaleW(15), self.totalMoney.bottom + ScaleW(15), self.priceBgView.width, ScaleW(44))];
        if (kLogin == 1) {
            [_confrimBtn setTitle:SSKJLocalized(@"做多", nil) forState:UIControlStateNormal];
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
        _deepView = [[LXY_DeepView alloc]initWithFrame:CGRectMake(ScaleW(15), self.confrimBtn.bottom, self.priceBgView.width, ScaleW(140))];
        [_deepView changeTitleForHeyue];
    }
    return _deepView;
}

#pragma mark -- 爆仓  盘口 UI --
- (Heyue_Root_Decimal_View *)decimalView{
    if (_decimalView == nil) {
        _decimalView = [[Heyue_Root_Decimal_View alloc]initWithFrame:CGRectMake(ScreenWidth / 2, ScaleW(20), ScreenWidth / 2, ScaleW(23))];
        WS(weakSelf);
        
        _decimalView.HeyueBaoCangBlock = ^{
            if (weakSelf.HeyueBaoCangBlock) {
                weakSelf.HeyueBaoCangBlock();
            }
        };
        
    }
    return _decimalView;
}

- (Heyue_Pankou_View *)pankouView{
    if (_pankouView == nil) {
        _pankouView = [[Heyue_Pankou_View alloc]initWithFrame:CGRectMake(ScreenWidth / 2, self.buyBtn.y, ViewWidth, self.height - ScaleW(49))];
        WS(weakSelf);
        
        _pankouView.CurrentPriceBlock = ^(NSString * _Nonnull price) {
            if (self.isXianShiPrice == 2) {
                weakSelf.priceTextField.text = price;
                [weakSelf calculateMaxZhangNum];
            }
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


#pragma mark -- 用户操作 --
#pragma mark -- 点击做多 --
- (void)buyBtnAction{
    
    if (kLogin == 1) {
        [self.confrimBtn setTitle:SSKJLocalized(@"做多", nil) forState:UIControlStateNormal];
    }
    
    self.sellBtn.selected = NO;
    self.buyBtn.selected = YES;
    
    self.confrimBtn.backgroundColor = kMarketUp;
    self.isBuySell = 1;
    self.cangweiView.isBuySell = 1;
    [self cleanData];
}




- (void)changeUI{
    if (kLogin == 1) {
        if (self.isBuySell == 1) {
           [self.confrimBtn setTitle:SSKJLocalized(@"做多", nil) forState:UIControlStateNormal];
        }else{
            [self.confrimBtn setTitle:SSKJLocalized(@"做空", nil) forState:UIControlStateNormal];
        }
    }else{
        [self.confrimBtn setTitle:SSKJLocalized(@"请登录", nil) forState:UIControlStateNormal];
    }
}
#pragma mark -- 点击做空 --
- (void)sellBtnAction{
     [self endEditing:YES];
    if (kLogin == 1) {
        [self.confrimBtn setTitle:SSKJLocalized(@"做空", nil) forState:UIControlStateNormal];
    }
    self.sellBtn.selected = YES;
    self.buyBtn.selected = NO;
        
    self.confrimBtn.backgroundColor = kMarketDown;
    self.isBuySell = 2;
    self.cangweiView.isBuySell = 2;
    [self cleanData];
}
#pragma mark -- 选择市价交易  或者  限价交易 --
- (void)xianjiaBtnAction{
     [self endEditing:YES];
    
    WS(weakSelf);
    NSArray *array = @[SSKJLanguage(@"市价交易"), SSKJLanguage(@"限价交易")];
    [SSKJ_Default_ActionsheetView showWithItems:array title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
        NSString *str = array[selectIndex];
        NSInteger index = selectIndex + 1;
        if (weakSelf.isXianShiPrice == index) {
            return ;
        }
        [weakSelf.xianjiaBtn setTitle:str forState:UIControlStateNormal];
        weakSelf.isXianShiPrice = index;
        
        if (index == 1) {
            weakSelf.priceBgView.backgroundColor = kGrayColor;
            weakSelf.jiaBtn.hidden = YES;
            weakSelf.jianBtn.hidden = YES;
            weakSelf.priceTextField.enabled = NO;
            weakSelf.shiJiaWarmLab.hidden = NO;
        }else{
            weakSelf.priceBgView.backgroundColor = kBgColor;
            weakSelf.jiaBtn.hidden = NO;
            weakSelf.jianBtn.hidden = NO;
            weakSelf.priceTextField.enabled = YES;
            weakSelf.shiJiaWarmLab.hidden = YES;
        }
        [weakSelf cleanData];

    } cancleBlock:^{
        
    }];
    
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
    if (self.cangweiView.numberTextField.text.integerValue < self.leverageModel.product.min_order.doubleValue) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@%ld",SSKJLocalized(@"最少购买", nil),(long)self.leverageModel.product.min_order.doubleValue]];
        return;
    }
    
//    if (!self.zhiyingView.value.length) {
//        [SSTool error:SSKJLanguage(@"请输入止盈价格")];
//        return;
//    }
//
//    if (!self.zhisunView.value.length) {
//        [SSTool error:SSKJLanguage(@"请输入止损价格")];
//        return;
//    }
    
    //现价交易  点击时获取最新的保证金
    if (self.isXianShiPrice == 1) {
        [self calculateMaxZhangNum];
    }
    
    
    //下单的接口金本位buyPrice价格字段传1，entrustLot字段传填写的BTC数量
    NSString *buyPriceStr = self.priceTextField.text;
    //拆分code
    NSString *stockCodeStr = self.leverageModel.code;;

    NSDictionary *params = @{
                             @"newprice":buyPriceStr,
                             @"otype":self.isBuySell==1?@"1":@"2",
                             @"type":@(self.isXianShiPrice),
                             @"code":stockCodeStr,
                             @"sheets":self.cangweiView.numberTextField.text,
                             @"leverage":@(self.leverage),
                             @"totalPrice":self.baozhengjinNum
                             };
//    @"baozhengjin":[self.totalMoney.text substringWithRange:NSMakeRange(0, self.totalMoney.text.length - 4)]
    
    [self.confirmCreateOrderView showWithData:params];
}


#pragma mark -- 数据获取 --  可用价格
- (void)setWallone_usdt:(NSString *)wallone_usdt{
    _wallone_usdt = wallone_usdt;
    
    
    self.keyongLabel.text = [NSString stringWithFormat:@"%@ USDT",[SSTool HeyuePname:self.leverageModel.code price:wallone_usdt]];
    
    
    
    [self calculateMaxZhangNum];
}


- (void)setBaoCang:(NSString *)baoCang{
 
    _baoCang = baoCang;
//    [_decimalView.baocangBtn setTitle:[NSString stringWithFormat:@"%@：%@%@",SSKJLocalized(@"风险率", nil),[SSTool disposePname:@"2" price:baoCang],@"%"] forState:UIControlStateNormal];

}

#pragma mark - 实时价格
- (void)setModel:(SSKJ_Market_Index_Model *)model{
    _model = model;
    
    
    NSString *price = [SSTool disposePname:@([SSTool HeyuePname:model.code]) price:model.price];
    if (self.isXianShiPrice == 1) {
        self.priceTextField.text = price;
    }
//    self.shiJiaWarmLab.text = price;
    self.pankouView.model = model;
    [self calculateMaxZhangNum];
}
#pragma mark - 基本信息数据
- (void)setLeverageModel:(Heyue_Leverage_Model *)leverageModel{
    _leverageModel = leverageModel;
    NSArray *array1 = leverageModel.product.leverage;

    //获取杠杆倍数数据
    if (array1.count > 0) {
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSString *object in array1) {
            //多加一层判断，当字符串为0，剔除出数组，防止后台杠杆倍数设置为0的情况
            if (![object isEqualToString:@"0"]) {
                [mArray addObject:object];
            }
            
            if (object.integerValue == 100) {
                self.leverage = 100;
            }
        };
        
        if (self.leverage == 0) {
            self.leverage = [mArray[0] integerValue];
        }
        self.leverageView.showTitle.text = [NSString stringWithFormat:@"%ld",self.leverage];
        
    }
        NSString *coinName = [[self.leverageModel.code uppercaseString] componentsSeparatedByString:@"_"].firstObject;
        [WLTools textField:self.cangweiView.numberTextField setPlaceHolder:[NSString stringWithFormat:@"%@ %@%@",SSKJLanguage(@"1张="),[SSTool HeyuePname:self.leverageModel.code ? self.leverageModel.code :@"--" price:self.leverageModel.product.sheets_rate],coinName] color:kSubTitleColor];
        
    
    [self calculateMaxZhangNum];
    //数据还原
    [self reductionData];
}

- (void)setShenduDic:(NSDictionary *)shenduDic{
//    [self.deepView setData:shenduDic];
    [self.deepView setData:shenduDic isLarge:YES];
}

- (void)setPankouModel:(PanKou_Socket_Model *)pankouModel{
    self.pankouView.pankouModel = pankouModel;
}

#pragma mark -- 计算最大张数 --
- (void)calculateMaxZhangNum{
    //实时价
    CGFloat currentPrice = self.priceTextField.text.doubleValue;
    //手续费费率
    CGFloat trans_fee = self.leverageModel.handling_fee.doubleValue / 100.0;
    //如果是 做多需要加上最小变动价  做空需要减去最小变动价
    if (self.isXianShiPrice == 1) {
        if (self.isBuySell == 1) {
            currentPrice = currentPrice + self.leverageModel.product.spread.doubleValue * self.leverageModel.handling_fee.doubleValue;
        }else{
            currentPrice = currentPrice - self.leverageModel.product.spread.doubleValue * self.leverageModel.handling_fee.doubleValue;
        }
    }
    
//    NSLog(@"currentPrice ---- %lf", currentPrice);
//    //可购买最大USDT数量
//    NSInteger maxNum = self.wallone_usdt.doubleValue / (currentPrice / self.leverage + currentPrice * trans_fee);
//
//    self.maxZhangNum = maxNum / self.leverageModel.lotSize.doubleValue;
    
    
        CGFloat total = self.wallone_usdt.doubleValue;
        if (self.cangweiNum > 0) {
            total = total * self.cangweiNum;
        }
        self.maxZhangNum = total / (self.leverageModel.product.sheets_rate.doubleValue * currentPrice * trans_fee + self.leverageModel.product.sheets_rate.doubleValue * currentPrice / self.leverage);
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
    CGFloat currentPrice = self.priceTextField.text.doubleValue;
    
    if (self.isXianShiPrice == 1) {
        currentPrice = self.model.price.doubleValue;
    }
    //购买张数
    CGFloat buyNum = self.cangweiView.numberTextField.text.doubleValue;
    
    //手续费费率
//    CGFloat trans_fee = self.leverageModel.leverDealFee.doubleValue / 100;
    
    //如果是 做多需要加上最小变动价  做空需要减去最小变动价
    if (self.isXianShiPrice == 1) {
        if (self.isBuySell == 1) {
            currentPrice = currentPrice + self.leverageModel.product.spread.doubleValue * self.leverageModel.product.var_price.doubleValue;
        }else{
            
            currentPrice = currentPrice - self.leverageModel.product.spread.doubleValue * self.leverageModel.product.var_price.doubleValue;
        }
    }
    
    //保证金
    CGFloat amount = 0;
    
    amount = buyNum * self.leverageModel.product.sheets_rate.doubleValue * currentPrice / self.leverage;

    
//    self.totalMoney.text = [NSString stringWithFormat:@"%@ USDT", [SSTool HeyuePname:self.leverageModel.code price:[NSString stringWithFormat:@"%.9f", amount + [self calculateshouxufei].doubleValue]]];
    
    // 不加手续费
    self.totalMoney.text = [NSString stringWithFormat:@"%@ USDT", [SSTool HeyuePname:self.leverageModel.code price:[NSString stringWithFormat:@"%.9f", amount]]];

    
//    NSLog(@"amount***%f",amount);
    
    //防止保证金 > 可用
    if (amount > self.wallone_usdt.doubleValue) {
        self.baozhengjinNum = [SSTool HeyuePname:self.leverageModel.code price:[NSString stringWithFormat:@"%.9f", self.wallone_usdt.doubleValue]];

    }else{
        self.baozhengjinNum = [SSTool HeyuePname:self.leverageModel.code price:[NSString stringWithFormat:@"%.9f", amount]];
    }
    

    
    

}

#pragma mark - 计算手续费
- (NSString *)calculateshouxufei{
    
    CGFloat currentPrice = self.priceTextField.text.doubleValue;
    CGFloat trans_fee = self.leverageModel.handling_fee.doubleValue / 100;
    CGFloat buyNum = self.cangweiView.numberTextField.text.doubleValue;
    
    CGFloat shouxufei = buyNum * self.leverageModel.product.sheets_rate.doubleValue * currentPrice * trans_fee;
    return [SSTool HeyuePname:self.leverageModel.code price:[NSString stringWithFormat:@"%.9f", shouxufei]];
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
    if ([textField isEqual:self.priceTextField]) {
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
    if ([self.priceTextField isFirstResponder]) {
        
        
    }else{
        if (self.cangweiView.numberTextField.text.doubleValue > self.maxZhangNum) {
            self.cangweiView.numberTextField.text = [SSTool disposePname:@(_zhangshu) price:[NSString stringWithFormat:@"%.9f", self.maxZhangNum]];
        }

    }
    //计算保证金
    [self calculateBaoZhengJin];
    
}


#pragma mark  -- 清空数据 选择的数据--
- (void)cleanData{
    //百分比
    self.cangweiNum = 0;
    self.cangweiView.array = self.cangweiArray;
    self.totalMoney.text = @"0 USDT";
    self.cangweiView.numberTextField.text = @"";
//    self.shiJiaWarmLab.text = [SSTool disposePname:@([SSTool HeyuePname:self.model.code]) price:self.model.price];
    
    
    
    
}

#pragma mark  -- 清空数据 (数据还原) --
- (void)reductionData{//还原原始数据
    self.isBuySell = 1;
    self.isXianShiPrice = 1;
//    self.cangweiNum = 0;
//    self.cangweiView.array = self.cangweiArray;
//    self.cangweiView.numberTextField.text = @"";
//    self.totalMoney.text = @"0USDT";

    self.priceBgView.backgroundColor = kGrayColor;
    
    self.shiJiaWarmLab.hidden = NO;
    
    self.usdtUnit.hidden = NO;
    self.jiaBtn.hidden = YES;
    self.jianBtn.hidden = YES;
    self.priceTextField.enabled = NO;
    [self.xianjiaBtn setTitle:SSKJLocalized(@"市价交易", nil) forState:UIControlStateNormal];
    self.confrimBtn.backgroundColor = kMarketUp;
    
    [self buyBtnAction];
}

- (void)clearCangWei{
    self.cangweiView.array = self.cangweiArray;
    self.cangweiNum = 0;
}


#pragma mark -- 确认下单弹框 --
- (Heyue_Confirm_View *)confirmCreateOrderView{
    if (_confirmCreateOrderView == nil) {
        _confirmCreateOrderView = [[Heyue_Confirm_View alloc]initWithFrame:[UIScreen mainScreen].bounds];
        WS(weakSelf);
        _confirmCreateOrderView.confirmBlock = ^(NSDictionary * _Nonnull dic) {
            if (weakSelf.HeyueCreateOrderBlock) {
                weakSelf.HeyueCreateOrderBlock(dic);
            }
        };
    }
    return _confirmCreateOrderView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
