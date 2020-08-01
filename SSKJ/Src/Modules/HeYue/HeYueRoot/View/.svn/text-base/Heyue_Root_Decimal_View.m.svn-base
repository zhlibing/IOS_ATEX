//
//  Heyue_Root_Decimal_View.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/26.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_Root_Decimal_View.h"

#define Halfwidth ScreenWidth / 2

@interface Heyue_Root_Decimal_View()

@property (nonatomic,strong) UIButton * wenhaoBtn;



@end

@implementation Heyue_Root_Decimal_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.baocangBtn];
        [self addSubview:self.wenhaoBtn];
        
        [self.baocangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.wenhaoBtn.mas_left).offset(-ScaleW(14));
        }];
        [self.wenhaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(ScaleW(-15));
            make.size.mas_equalTo(CGSizeMake(ScaleW(11), ScaleW(11)));
        }];
    }
    return self;
}

- (UIButton *)baocangBtn{
    if (_baocangBtn == nil) {
        _baocangBtn = [WLTools allocButton:[NSString stringWithFormat:@"%@",SSKJLocalized(@"风险率", nil)] textColor:kBlueColor nom_bg:nil hei_bg:nil frame:CGRectMake(ScaleW(0), 0, Halfwidth * 0.4 - ScaleW(30), ScaleW(30))];
        [_baocangBtn addTarget:self action:@selector(baocangBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _baocangBtn.titleLabel.font = systemFont(ScaleW(13));
    }
    return _baocangBtn;
}

- (UIButton *)wenhaoBtn{
    if (_wenhaoBtn == nil) {
        _wenhaoBtn = [WLTools allocButton:SSKJLocalized(@"", nil) textColor:kBlueColor nom_bg:nil hei_bg:nil frame:CGRectMake(self.baocangBtn.right + ScaleW(5), 0, ScaleW(20), ScaleW(30))];
        [_wenhaoBtn addTarget:self action:@selector(baocangBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_wenhaoBtn setImage:[UIImage imageNamed:@"hy_wenhao"] forState:UIControlStateNormal];
    }
    return _wenhaoBtn;
}





#pragma mark -- 爆仓率点击方法--
- (void)baocangBtnAction{
    if (self.HeyueBaoCangBlock) {
        self.HeyueBaoCangBlock();
    }
}

#pragma mark -- 更换小数位数  点击方法 --
- (void)decimalBtnAction{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
