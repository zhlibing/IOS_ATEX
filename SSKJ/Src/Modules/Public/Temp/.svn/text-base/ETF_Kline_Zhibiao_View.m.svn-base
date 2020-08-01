//
//  ETF_Kline_Zhibiao_View.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/8.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "ETF_Kline_Zhibiao_View.h"

@interface ETF_Kline_Zhibiao_View ()

@property (nonatomic, strong) NSArray *mainAccessoryArray;
@property (nonatomic, strong) NSArray *subAccessoryArray;

@property (nonatomic, strong) NSMutableArray *mainBtnArray;
@property (nonatomic, strong) NSMutableArray *subBtnArray;

@property (nonatomic, strong) UILabel *mainLabel;

@property (nonatomic, strong) UIView *mainLineView;

@property (nonatomic, strong) UIButton *mainHiddenButton;

@property (nonatomic, strong) UILabel *subLabel;

@property (nonatomic, strong) UIView *subLineView;

@property (nonatomic, strong) UIButton *subHiddenButton;


@property (nonatomic, assign) LXY_KMAINACCESSORYTYPE mainType;

@property (nonatomic, assign) LXY_ACCESSORYTYPE subType;


@end

@implementation ETF_Kline_Zhibiao_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kSubBgColor;
        self.mainAccessoryArray = @[@"MA",@"BOLL"];
        self.subAccessoryArray = @[@"MACD",@"KDJ",@"RSI",@"WR"];
        
        [self setUI];
        
//        self.layer.borderColor = kBlueColor.CGColor;
//        self.layer.borderWidth = 0.5;
        
        self.mainType = LXY_KMAINACCESSORYTYPEMA;
        self.subType = LXY_ACCESSORYTYPENONE;
    }
    return self;
}

-(NSMutableArray *)mainBtnArray
{
    if (nil == _mainBtnArray) {
        _mainBtnArray = [NSMutableArray array];
    }
    return _mainBtnArray;
}


-(NSMutableArray *)subBtnArray
{
    if (nil == _subBtnArray) {
        _subBtnArray = [NSMutableArray array];
    }
    return _subBtnArray;
}

-(void)setUI
{
    [self addSubview:self.mainLabel];
    [self addSubview:self.mainLineView];
    [self addSubview:self.mainHiddenButton];
    
    [self addMainAccessory];
    
    [self addSubview:self.subLabel];
    [self addSubview:self.subLineView];
    [self addSubview:self.subHiddenButton];
    
    [self addSubAccessory];
}

-(UILabel *)mainLabel
{
    if (nil == _mainLabel) {
        _mainLabel = [WLTools allocLabel:SSKJLocalized(@"主图", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(0), ScaleW(18), ScaleW(53), ScaleW(13)) textAlignment:NSTextAlignmentCenter];
        _mainLabel.centerY = self.height / 4;
    }
    return _mainLabel;
}

-(UIView *)mainLineView
{
    if (nil == _mainLineView) {
        _mainLineView = [[UIView alloc]initWithFrame:CGRectMake(self.mainLabel.right, 0, 0.5, ScaleW(16))];
        _mainLineView.centerY = self.mainLabel.centerY;
        _mainLineView.backgroundColor = kSubTitleColor;
    }
    return _mainLineView;
}

-(UIButton *)mainHiddenButton
{
    if (nil == _mainHiddenButton) {
        _mainHiddenButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - ScaleW(15) - ScaleW(50), 0, ScaleW(ScaleW(50)), ScaleW(40))];
        _mainHiddenButton.centerY = self.mainLineView.centerY;
        [_mainHiddenButton setImage:[UIImage imageNamed:@"psd_show"] forState:UIControlStateNormal];
        [_mainHiddenButton setImage:[UIImage imageNamed:@"psd_hidden"] forState:UIControlStateSelected];

        [_mainHiddenButton addTarget:self action:@selector(mainHidden) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mainHiddenButton;
}

-(void)addMainAccessory
{
    CGFloat startX = self.mainLineView.right + ScaleW(15);
    CGFloat gap = ScaleW(70);
    for (int i = 0; i < self.mainAccessoryArray.count; i++) {
        
        NSString *title = self.mainAccessoryArray[i];
        
        CGFloat width = [WLTools getWidthWithText:title font:systemFont(ScaleW(14))];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(startX + i * gap, 0, width, ScaleW(40))];
        btn.centerY = self.mainLineView.centerY;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        [btn setTitleColor:kBlueColor forState:UIControlStateSelected];
        btn.titleLabel.font = systemFont(ScaleW(13));
        [self addSubview:btn];
        
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(selectMainAccessory:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainBtnArray addObject:btn];
        
        if ([title isEqualToString:@"MA"]) {
            btn.selected = YES;
        }
        
    }
    
}


-(UILabel *)subLabel
{
    if (nil == _subLabel) {
        _subLabel = [WLTools allocLabel:SSKJLocalized(@"副图", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(0), ScaleW(18), ScaleW(53), ScaleW(13)) textAlignment:NSTextAlignmentCenter];
        _subLabel.centerY = self.height / 4 * 3;
    }
    return _subLabel;
}

-(UIView *)subLineView
{
    if (nil == _subLineView) {
        _subLineView = [[UIView alloc]initWithFrame:CGRectMake(self.mainLabel.right, 0, 0.5, ScaleW(16))];
        _subLineView.centerY = self.subLabel.centerY;
        _subLineView.backgroundColor = kSubTitleColor;
    }
    return _subLineView;
}

-(UIButton *)subHiddenButton
{
    if (nil == _subHiddenButton) {
        _subHiddenButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - ScaleW(15) - ScaleW(50), 0, ScaleW(ScaleW(50)), ScaleW(40))];
        _subHiddenButton.centerY = self.subLabel.centerY;
        [_subHiddenButton setImage:[UIImage imageNamed:@"psd_show"] forState:UIControlStateNormal];
        [_subHiddenButton setImage:[UIImage imageNamed:@"psd_hidden"] forState:UIControlStateSelected];
        _subHiddenButton.selected = YES;
        [_subHiddenButton addTarget:self action:@selector(subHidden) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subHiddenButton;
}

-(void)addSubAccessory
{
    CGFloat startX = self.mainLineView.right + ScaleW(15);
    CGFloat gap = ScaleW(70);
    for (int i = 0; i < self.subAccessoryArray.count; i++) {
        
        NSString *title = self.subAccessoryArray[i];
        
        CGFloat width = [WLTools getWidthWithText:title font:systemFont(ScaleW(14))];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(startX + i * gap, 0, width, ScaleW(40))];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        [btn setTitleColor:kBlueColor forState:UIControlStateSelected];
        btn.titleLabel.font = systemFont(ScaleW(13));
        btn.centerY = self.subLabel.centerY;
        [self addSubview:btn];
        
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(selectSubAccessory:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.subBtnArray addObject:btn];
    }
    
}

-(void)selectMainAccessory:(UIButton *)sender
{
    NSString *title = [sender titleForState:UIControlStateSelected];
    
    LXY_KMAINACCESSORYTYPE type = self.mainType;
    
    if ([title isEqualToString:@"MA"]) {
        type = LXY_KMAINACCESSORYTYPEMA;
    }else if ([title isEqualToString:@"BOLL"]) {
        type = LXY_KMAINACCESSORYTYPEBOLL;
    }
    
    self.mainType = type;
    
    if (self.selectMainAccessoryBlock) {
        self.selectMainAccessoryBlock(self.mainType);
    }
    
    for (UIButton *btn in self.mainBtnArray) {
        if (btn == sender) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    self.mainHiddenButton.selected = NO;

    
    [self removeFromSuperview];
    
}

-(void)mainHidden
{
    self.mainHiddenButton.selected = YES;
    
    for (UIButton *btn in self.mainBtnArray) {
        btn.selected = NO;
    }
    self.mainType = LXY_KMAINACCESSORYTYPENONE;
    if (self.selectMainAccessoryBlock) {
        self.selectMainAccessoryBlock(self.mainType);
    }
    [self removeFromSuperview];

}

-(void)selectSubAccessory:(UIButton *)sender
{
    NSString *title = [sender titleForState:UIControlStateSelected];
    
    LXY_ACCESSORYTYPE type = self.subType;
    
    if ([title isEqualToString:@"MACD"]) {
        type = LXY_ACCESSORYTYPEMACD;
    }else if ([title isEqualToString:@"KDJ"]) {
        type = LXY_ACCESSORYTYPEKDJ;
    }else if ([title isEqualToString:@"RSI"]) {
        type = LXY_ACCESSORYTYPERSI;
    }else if ([title isEqualToString:@"WR"]) {
        type = LXY_ACCESSORYTYPEWR;
    }
    
    self.subType = type;
    if (self.selectSubAccessoryBlock) {
        self.selectSubAccessoryBlock(type);
    }
    
    for (UIButton *btn in self.subBtnArray) {
        if (btn == sender) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    self.subHiddenButton.selected = NO;

    [self removeFromSuperview];
}

-(void)subHidden
{
    self.subHiddenButton.selected = YES;
    
    for (UIButton *btn in self.subBtnArray) {
        btn.selected = NO;
    }
    
    self.subType = LXY_ACCESSORYTYPENONE;
    if (self.selectSubAccessoryBlock) {
        self.selectSubAccessoryBlock(self.subType);
    }
    [self removeFromSuperview];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
