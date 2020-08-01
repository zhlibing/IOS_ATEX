//
//  HeyueTime_WeiTuo_Order_Cell.h
//  SSKJ
//
//  Created by cy5566 on 2020/3/21.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "HeyueTime_WeiTuo_Order_Cell.h"

#define LabelHeight ScreenWidth - ScaleW(65)

@interface HeyueTime_WeiTuo_Order_Cell()

@property (nonatomic ,strong) UILabel *typeTitleLb;
@property (nonatomic ,strong) UILabel *typeLb;
@property (nonatomic ,strong) UILabel *orderTitleLb;
@property (nonatomic ,strong) UILabel *orderLb;
@property (nonatomic ,strong) UILabel *bzMoneyTitleLb;
@property (nonatomic ,strong) UILabel *bzMoneyLb;
@property (nonatomic ,strong) UILabel *cycleTimeTitleLb;
@property (nonatomic ,strong) UILabel *cycleTimeLb;
@property (nonatomic ,strong) UILabel *currentTitlePriceLb;
@property (nonatomic ,strong) UILabel *currentPriceLb;
@property (nonatomic ,strong) UILabel *cycleLb;
@property (nonatomic ,strong) UILabel *yingkuiTitleLb;
@property (nonatomic ,strong) UILabel *yingkuiLb;
@property (nonatomic ,strong) UILabel *creatTitleLb;
@property (nonatomic ,strong) UILabel *creatLb;
@property (nonatomic ,strong) UILabel *endTimeTitleLb;
@property (nonatomic ,strong) UILabel *endTimeLb;




@end

@implementation HeyueTime_WeiTuo_Order_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addChilrenViews];
    }
    return self;
}


- (void)setType:(NSInteger)type{
    _type = type;
    if (type == 1) {
        self.endTimeTitleLb.hidden = self.endTimeLb.hidden = YES;
        self.currentTitlePriceLb.text = SSKJLocalized(@"当前价格", nil);
    }else{
        self.endTimeTitleLb.hidden = self.endTimeLb.hidden = NO;
        self.currentTitlePriceLb.text = SSKJLocalized(@"平仓价格", nil);
    }
}
- (void)setListModel:(TimeHyListModel *)listModel{
    
    if (listModel.billType.integerValue == 0) {
        self.typeTitleLb.text = SSKJLocalized(@"买涨", nil);
        self.typeTitleLb.textColor = KgreenColor;
    }else{
        self.typeTitleLb.text = SSKJLocalized(@"买跌", nil);
        self.typeTitleLb.textColor = KRedColor;
    }
    
    
    self.typeLb.text = [NSString stringWithFormat:@"%@/USDT", listModel.stockCode ? listModel.stockCode : @"--"];
    self.orderLb.text = [NSString stringWithFormat:@"%@ USDT", listModel.buyMoney ? listModel.buyMoney : @"--"];
    self.bzMoneyLb.text = [WLTools noroundingStringWith:listModel.bondMoney.floatValue afterPointNumber:4];
    self.cycleTimeLb.text = [NSString stringWithFormat:SSKJLanguage(@"%@分钟"),listModel.cycleTime ? listModel.cycleTime : @"--"];
    
    self.cycleLb.text = [NSString stringWithFormat:SSKJLanguage(@"第%@期"), listModel.cycleNum ? listModel.cycleNum : @""];
    self.creatLb.text = listModel.createTime ? listModel.createTime : @"--";
    if (self.type == 1) {
        self.currentPriceLb.text = [SSTool disposePname:@([SSTool HeyuePname:listModel.stockCode]) price:listModel.realMoney];//推送价格
        //计算价格
        if (listModel.socketPrice.floatValue != 0) {
            //有推送
            if (listModel.buyMoney.floatValue > 0) {
                            CGFloat price = listModel.socketPrice.floatValue - listModel.buyMoney.floatValue;
                //            self.yingkuiLb.text = [WLTools noroundingStringWith:price afterPointNumber:4];
                self.yingkuiLb.text =  [SSTool MarketPname:listModel.stockCode price:@(price)];
            } else {
                self.yingkuiLb.text = @"0";
            }
            
            
            
            self.currentPriceLb.text = [SSTool disposePname:@([SSTool HeyuePname:listModel.stockCode]) price:listModel.socketPrice];
//            self.currentPriceLb.text = [WLTools noroundingStringWith:listModel.socketPrice.floatValue afterPointNumber:4];
            
        }
        
        
        
        
    }else{
        //计算价格
//        if (listModel.socketPrice.floatValue != 0) {
            //有推送
           
            self.yingkuiLb.text = [SSTool disposePname:@([SSTool HeyuePname:listModel.stockCode]) price:listModel.profitMoney];
        
 
            self.currentPriceLb.text = [SSTool disposePname:@([SSTool HeyuePname:listModel.stockCode]) price:listModel.dealMoney];
//        }
        self.endTimeLb.text = listModel.updateTime ? listModel.updateTime : @"--";
    }
    
    
    if([self.yingkuiLb.text hasPrefix:@"-"]){
        self.yingkuiLb.textColor = KRedColor;
    }else{
        self.yingkuiLb.textColor = KgreenColor;
    }
}


- (void) addChilrenViews{
    
    self.typeTitleLb = [UILabel new];
    self.typeLb = [UILabel new];
    self.orderTitleLb = [UILabel new];
    self.orderLb = [UILabel new];
    self.bzMoneyTitleLb = [UILabel new];
    self.bzMoneyLb = [UILabel new];
    self.cycleTimeTitleLb = [UILabel new];
    self.cycleTimeLb = [UILabel new];
    self.cycleLb = [UILabel new];
    self.currentTitlePriceLb = [UILabel new];
    self.currentPriceLb = [UILabel new];
    self.yingkuiTitleLb = [UILabel new];
    self.yingkuiLb = [UILabel new];
    self.creatTitleLb = [UILabel new];
    self.creatLb = [UILabel new];
    self.endTimeTitleLb = [UILabel new];
    self.endTimeLb  = [UILabel new];
    
    
    
    [self.contentView addSubview:self.typeTitleLb];
    [self.contentView addSubview:self.typeLb];
    [self.contentView addSubview:self.orderTitleLb];
    [self.contentView addSubview:self.orderLb];
    [self.contentView addSubview:self.bzMoneyTitleLb];
    [self.contentView addSubview:self.bzMoneyLb];
    [self.contentView addSubview:self.cycleTimeTitleLb];
    [self.contentView addSubview:self.cycleTimeLb];
    [self.contentView addSubview:self.cycleLb];
    [self.contentView addSubview:self.currentTitlePriceLb];
    [self.contentView addSubview:self.currentPriceLb];
    [self.contentView addSubview:self.yingkuiTitleLb];
    [self.contentView addSubview:self.yingkuiLb];
    
    [self.contentView addSubview:self.creatTitleLb];
    [self.contentView addSubview:self.creatLb];
    [self.contentView addSubview:self.endTimeTitleLb];
    [self.contentView addSubview:self.endTimeLb];
    
    
    
    
    
    self.typeTitleLb.font = systemBoldFont(15);
    self.typeLb.font = self.cycleLb.font = systemFont(15);
    for (UILabel *lb in self.contentView.subviews) {
        if (lb != self.typeLb || lb != self.typeTitleLb || lb != self.cycleLb) {
            lb.font = systemFont(13);
            lb.textColor = kSubTitleColor;
        }
    }
    
    self.orderLb.textColor = self.typeLb.textColor = self.cycleLb.textColor
    = self.bzMoneyLb.textColor = self.cycleTimeLb.textColor = self.creatLb.textColor = self.endTimeLb.textColor = kTitleColor;
    self.typeTitleLb.textColor = KgreenColor;
    self.typeTitleLb.text = SSKJLocalized(@"买涨", nil);
    self.orderTitleLb.text = SSKJLocalized(@"下单价格", nil);
    self.bzMoneyTitleLb.text = SSKJLocalized(@"保 证 金", nil);
    self.cycleTimeTitleLb.text = SSKJLocalized(@"持仓周期", nil);
    self.currentTitlePriceLb.text = SSKJLocalized(@"平仓价格", nil);
    self.yingkuiTitleLb.text = SSKJLocalized(@"盈       亏", nil);
    self.creatTitleLb.text = SSKJLocalized(@"创建时间", nil);
    self.endTimeTitleLb.text = SSKJLocalized(@"平仓时间", nil);
    self.currentPriceLb.textColor = self.yingkuiLb.textColor = kTitleColor;
    
    
    self.endTimeLb.adjustsFontSizeToFitWidth = YES;
    self.creatLb.adjustsFontSizeToFitWidth = YES;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.typeTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).offset(ScaleW(15));
    }];
    [self.typeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeTitleLb.mas_right).offset(ScaleW(15));
        make.centerY.mas_equalTo(self.typeTitleLb);
    }];
    [self.orderTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeTitleLb);
        make.top.mas_equalTo(self.typeTitleLb.mas_bottom).offset(ScaleW(10));
    }];
    [self.orderLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.orderTitleLb.mas_right).offset(ScaleW(10));
        make.centerY.mas_equalTo(self.orderTitleLb);
    }];
    [self.bzMoneyTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeTitleLb);
        make.top.mas_equalTo(self.orderTitleLb.mas_bottom).offset(ScaleW(10));
    }];
    [self.bzMoneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bzMoneyTitleLb);
        make.left.mas_equalTo(self.bzMoneyTitleLb.mas_right).offset(ScaleW(10));
    }];
    [self.cycleTimeTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeTitleLb);
        make.top.mas_equalTo(self.bzMoneyTitleLb.mas_bottom).offset(ScaleW(10));
        
    }];
    [self.cycleTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.cycleTimeTitleLb);
        make.left.mas_equalTo(self.cycleTimeTitleLb.mas_right).offset(ScaleW(10));
        
    }];
    [self.cycleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.typeTitleLb);
        make.right.mas_equalTo(self.contentView.mas_right).offset(ScaleW(-15));
    }];
    [self.currentTitlePriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(self.orderTitleLb);
    }];
    [self.currentPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.currentTitlePriceLb);
        make.left.mas_equalTo(self.currentTitlePriceLb.mas_right).offset(ScaleW(10));
    }];
    [self.yingkuiTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(self.bzMoneyTitleLb);
    }];
    [self.yingkuiLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.yingkuiTitleLb);
        make.left.mas_equalTo(self.yingkuiTitleLb.mas_right).offset(ScaleW(10));
    }];
    [self.creatTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(self.cycleTimeTitleLb);
    }];
    [self.creatLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.creatTitleLb);
        make.left.mas_equalTo(self.creatTitleLb.mas_right).offset(ScaleW(10));
        make.right.mas_equalTo(self.contentView.mas_right).offset(ScaleW(-10));
    }];
    [self.endTimeTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.creatTitleLb.mas_bottom).offset(ScaleW(10));
    }];
    [self.endTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.endTimeTitleLb);
        make.left.mas_equalTo(self.endTimeTitleLb.mas_right).offset(ScaleW(10));
        make.right.mas_equalTo(self.contentView.mas_right).offset(ScaleW(-10));
    }];
    
    
    //ContentCompressionResistancePriority ==> 表示当前的Label的内容不想被收缩 UILayoutPriorityDefaultLow表示优先级较低
    [self.endTimeTitleLb setContentCompressionResistancePriority:UILayoutPriorityRequired
                              forAxis:UILayoutConstraintAxisHorizontal];
    [self.endTimeLb setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                              forAxis:UILayoutConstraintAxisHorizontal];
    
    
    
    
    
}




@end
