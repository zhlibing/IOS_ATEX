//
//  MyCollectionHeaderViewRV.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2018/11/15.
//  Copyright © 2018 Wang. All rights reserved.
//

#import "MyCollectionHeaderViewRV.h"

@implementation MyCollectionHeaderViewRV

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBgColor;
        [self addSubview:self.backGroundImgeView];
        [self addSubview:self.assetImageView];
        [self addSubview:self.accountImgView];
        [self addSubview:self.accountBtn];
        [self addSubview:self.markControl];
        [self addSubview:self.vipImageView];
        [self addSubview:self.uidLabel];
        [self addSubview:self.zhzclabel];
        [self addSubview:self.pricelabel];
        [self addSubview:self.USDTlabel];
        [self addSubview:self.noticeView];
        [self addSubview:self.lineView];
        
        #pragma mark 重置Frame
        [self.backGroundImgeView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.accountImgView setFrame:CGRectMake(ScaleW(20), ScaleW(49), ScaleW(60), ScaleW(60))];
        [self.vipImageView setFrame:CGRectMake(ScaleW(self.accountImgView.right-ScaleW(15.5)), (self.accountImgView.bottom-ScaleW(15.5)), ScaleW(15), ScaleW(15))];
        [self.vipImageView.layer setCornerRadius:(self.vipImageView.height/2.0)];
        [self.accountBtn setFrame:CGRectMake(ScaleW((self.accountImgView.right+15)), ScaleW((self.accountImgView.top+10)), (frame.size.width-(ScaleW((self.accountImgView.top+10))+ScaleW(70))), 20)];
        
        
        
        [self.uidLabel setFrame:CGRectMake(self.accountBtn.left, (self.accountBtn.bottom+ScaleW(5.0)), self.accountBtn.width, self.accountBtn.height)];
        
        
        [self.assetImageView setFrame:CGRectMake(0, self.accountImgView.bottom+ScaleW(20), frame.size.width, ScaleW(103))];
        
        
        [self.markControl resetFrame:CGRectMake((frame.size.width-ScaleW(70)), self.accountBtn.top, ScaleW(70), ScaleW(30))];
        
        
        [self.noticeView setFrame:CGRectMake(0, self.assetImageView.bottom - ScaleW(5), frame.size.width, ScaleW(50))];
        

        #pragma mark 模拟数据
        [self.uidLabel setText:@"UID:--"];
        
        if (!kLogin){
            [self logout];
        }
        
    }
    return self;
}






#pragma mark - Private Method
-(void)markControlAction:(UIControl*)sender
{
    if (self.qiandaoBtnBlock)
    {
        self.qiandaoBtnBlock();
    }
}

#pragma mark - Getter / Setter
-(UIImageView *)backGroundImgeView
{
    if (!_backGroundImgeView)
    {
         UIImage *image = [UIImage imageNamed:@"mine_header_img"];
        _backGroundImgeView = [[UIImageView alloc]init];
        [_backGroundImgeView setImage:image];
        _backGroundImgeView.width = ScaleW(image.size.width);
        _backGroundImgeView.height = ScaleW(image.size.height);
    }
    return _backGroundImgeView;
}



-(UIImageView *)assetImageView
{
    if (_assetImageView == nil)
    {
        UIImage *image = [UIImage imageNamed:@"Mine_bg_card_mine"];
        _assetImageView = [[UIImageView alloc]init];
        [_assetImageView setImage:image];
        _assetImageView.width = ScaleW(image.size.width);
        _assetImageView.height = ScaleW(image.size.height);
    }
    return _assetImageView;
}


-(UIImageView *)accountImgView
{
    if (_accountImgView == nil) {
        UIImage *image = [UIImage imageNamed:@"icon_touxiang"];
        _accountImgView = [[UIImageView alloc]init];
        _accountImgView.layer.cornerRadius = ScaleW(55 / 2);
        _accountImgView.layer.masksToBounds = YES;
        [_accountImgView setImage:image];
        _accountImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerClicked)];
        [_accountImgView addGestureRecognizer:tap];
    }
    return _accountImgView;
}

- (MineMarkControl *)markControl
{
    if (_markControl == nil)
    {
        _markControl = [[MineMarkControl alloc]init];
        [_markControl setImage:@"Mine_qiandao_no"];
        [self addSubview:_markControl];
        [_markControl addTarget:self action:@selector(markControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _markControl;
}


-(UIImageView *)vipImageView
{
    if (!_vipImageView)
    {
        _vipImageView = [[UIImageView alloc]init];
        [_vipImageView setContentMode:UIViewContentModeScaleAspectFit];
        [_vipImageView setImage:[UIImage imageNamed:@""]];
    }
    return _vipImageView;
}


- (UIButton *)accountBtn
{
    if (_accountBtn==nil)
    {
        _accountBtn = [FactoryUI createButtonWithFrame:CGRectZero title:SSKJLocalized(@"请登录", nil) titleColor:kTitleColor  imageName:nil backgroundImageName:nil target:self selector:@selector(accountBtnAction) font:systemBoldFont(ScaleW(18))];
        _accountBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _accountBtn;
}


-(UILabel *)uidLabel
{
    if (nil == _uidLabel)
    {
        _uidLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kTitleColor font:systemFont(ScaleW(14))];
    }
    return _uidLabel;
}

- (UILabel *)zhzclabel{
    if (_zhzclabel==nil) {
        _zhzclabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"账户资产", nil) textColor:UIColorFromRGB(0x222222) font:systemFont(ScaleW(12))];
        
        _zhzclabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_zhzclabel];
        
        [_zhzclabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.assetImageView.mas_top).offset(ScaleW(13));
            make.left.equalTo(@(ScaleW(35)));
            make.right.equalTo(@0);
            make.height.equalTo(@(ScaleW(12)));
        }];
        
    }
    return _zhzclabel;
}

- (UILabel *)pricelabel{
    if (_pricelabel==nil) {
        _pricelabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"----" textColor:UIColorFromRGB(0x222222) font:systemBoldFont(ScaleW(25))];
        _pricelabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_pricelabel];
        [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.zhzclabel.mas_bottom).offset(ScaleW(6));
            make.left.equalTo(self.zhzclabel.mas_left);
        }];
        
    }
    return _pricelabel;
}

-(UILabel *)cnyLabel
{
    if (nil == _cnyLabel) {
        _cnyLabel = [WLTools allocLabel:@"≈0 CNY" font:systemFont(ScaleW(10)) textColor:UIColorFromRGB(0x222222) frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        [self addSubview:_cnyLabel];
        [_cnyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.USDTlabel.mas_right).offset(ScaleW(22));
            make.bottom.equalTo(self.pricelabel.mas_bottom).offset(-3);
        }];
    }
    return _cnyLabel;
}

- (UILabel *)USDTlabel{
    if (_USDTlabel==nil) {
        _USDTlabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"BTC" textColor:UIColorFromRGB(0x878889) font:[UIFont systemFontOfSize:ScaleW(14)]];
        _USDTlabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_USDTlabel];
        [_USDTlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.pricelabel.mas_bottom);
            make.left.equalTo(self.pricelabel.mas_right).offset(ScaleW(5));
//            make.height.equalTo(@(ScaleW(14)));
        }];
        
    }
    return _USDTlabel;
}

-(UIView *)lineView
{
    if (_lineView == nil) {
        
        _lineView = [FactoryUI createViewWithFrame:CGRectZero Color:kBgColor];
        
        [self addSubview:_lineView];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.bottom.equalTo(@0);
            
            make.height.equalTo(@(ScaleW(10)));
        }];
    }
    return _lineView;
}


-(SSKJ_ScrollNotice_View *)noticeView
{
    if (nil == _noticeView) {
        _noticeView = [[SSKJ_ScrollNotice_View alloc]initWithFrame:CGRectMake(0, self.assetImageView.bottom - ScaleW(15), ScreenWidth, ScaleW(50))];
        _noticeView.backgroundColor = kSubBgColor;
    }
    return _noticeView;
}


- (void)accountBtnAction{
    
    if (kLogin)
    {
        [self headerClicked];
    }
    else
    {
        if (self.userBtnBlock)
        {
            self.userBtnBlock();
        }
    }
    
}

- (void)qiandaoBtnAction{
    if (self.qiandaoBtnBlock)
    {
        self.qiandaoBtnBlock();
    }
}

-(void)setUserModel:(SSKJ_UserInfo_Model *)userModel
{
    
    //用户名
    if ([WLTools judgeString:userModel.tel] || [WLTools judgeString:userModel.email])
    {
        
        self.markControl.hidden = NO;

        //!< 签到状态 1已签到 0未签到
        if (userModel.signStatus.integerValue == 1) {
            [self.markControl setImage:@"Mine_qiandao_yes"];
            [self.markControl setTitle:@"已签到" titleColor:kSubTitleColor];
            self.markControl.userInteractionEnabled = NO;
        }else{
            [self.markControl setImage:@"Mine_qiandao_no"];
            [self.markControl setTitle:@"签到" titleColor:kTitleColor];
            self.markControl.userInteractionEnabled = YES;
        }
        
        self.uidLabel.text = [NSString stringWithFormat:@"UID:%@",[SSKJ_User_Tool sharedUserTool].userInfoModel.userUid];
        
        self.uidLabel.hidden = NO;
        
        NSString *str = kAccount;
        
        NSMutableString* str1 = [[NSMutableString alloc]initWithString:str];
        
        NSString *mobileStr;
        
        if (![RegularExpression validateEmail:str] )
        {
            
            mobileStr = [str stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            
        }else{
            
            mobileStr = [WLTools hideEmailWithEmail:str];
        }
        
        
        [self.accountBtn setTitle:mobileStr forState:UIControlStateNormal];
        
        self.accountBtn.y = self.accountImgView.top + ScaleW(10);
//        self.accountBtn.enabled=NO;
    }
    else
    {
        self.accountBtn.enabled=YES;
        self.accountBtn.centerY = self.accountImgView.centerY;
    }
    
    if (kLogin)
    {
        
        self.pricelabel.text= [WLTools noroundingStringWith:userModel.found.btcTotal.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:@"BTC"]];
    }
    else
    {
        self.pricelabel.text=@"----";
    }

    
    NSString *vipLevel = userModel.vipLevel;
    
    if ([vipLevel integerValue])
    {
        self.vipImageView.hidden = NO;

        NSString *vipImageName = [NSString stringWithFormat:@"V%@",vipLevel];
        self.vipImageView.image = [UIImage imageNamed:vipImageName];
    }
    else
    {
        self.vipImageView.hidden = YES;
    }

    self.cnyLabel.text = [NSString stringWithFormat:@"≈%.2f CNY",[WLTools noroundingStringWith:userModel.found.usdtTotal.doubleValue afterPointNumber:2].doubleValue];
}


-(void)headerClicked
{
    if (self.headerBlock) {
        self.headerBlock();
    }
}


-(void)logout
{
    self.pricelabel.text = @"----";
    
    [self.accountBtn setTitle:SSKJLocalized(@"请登录", nil) forState:0];
    self.accountBtn.centerY = self.accountImgView.centerY;

    self.cnyLabel.text = @"----";
    self.accountBtn.enabled=YES;
    
    self.markControl.hidden = YES;
    
    self.uidLabel.hidden = YES;
}


@end
