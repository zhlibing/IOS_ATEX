//
//  Heyue_root_OrderSectionView.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/29.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_root_OrderSectionView.h"

@interface Heyue_root_OrderSectionView()

@property (nonatomic,strong) UILabel * bottomLabel;


@property (nonatomic,strong) UIView * lineView;

@end

@implementation Heyue_root_OrderSectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBgColor;
        
        [self bottomLabel];
        
        [self allOrderBtn];
        
//        [self lineView];
    }
    return self;
}

- (UILabel *)bottomLabel{
    if (_bottomLabel == nil) {
        _bottomLabel = [UILabel new];
        _bottomLabel.text = SSKJLocalized(@"当前委托", nil);
        _bottomLabel.font = systemFont(ScaleW(16));
        _bottomLabel.textColor = kTitleColor;
        [self addSubview:_bottomLabel];
        [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(@(ScaleW(18)));
            make.top.equalTo(@(ScaleW(0)));
            make.bottom.equalTo(@(ScaleW(0)));
            make.width.equalTo(@(200));
         }];
    }
    return _bottomLabel;
}

- (UIButton *)allOrderBtn{
    if (_allOrderBtn == nil) {
        _allOrderBtn = [WLTools allocButton:SSKJLocalized(@"全部订单", nil) textColor:kBlueColor nom_bg:nil hei_bg:nil frame:CGRectZero];
        _allOrderBtn.titleLabel.font = systemFont(ScaleW(16));
        _allOrderBtn.contentHorizontalAlignment  =  UIControlContentHorizontalAlignmentRight; //标题靠右
        [_allOrderBtn addTarget:self action:@selector(allOrderBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_allOrderBtn];
        [_allOrderBtn mas_makeConstraints:^(MASConstraintMaker *make){
             make.right.equalTo(@(ScaleW(-18)));
             make.centerY.equalTo(self.mas_centerY);
             make.width.equalTo(@(ScaleW(120)));
             make.height.equalTo(@(ScaleW(25)));
         }];
    }
    return _allOrderBtn;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kBgColor;
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@(ScaleW(0)));
            make.height.equalTo(@(ScaleW(1)));
        }];
    }
    return _lineView;
}

- (void)allOrderBtnAction{
    if (self.AllOrderBlock) {
        self.AllOrderBlock();
    }
}



- (void)setIsTimeHeyue:(BOOL)isTimeHeyue {
    _isTimeHeyue = isTimeHeyue;
    if (isTimeHeyue) {
        self.bottomLabel.text = SSKJLocalized(@"当前持仓", nil);
    } else {
        self.bottomLabel.text = SSKJLocalized(@"当前委托", nil);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
