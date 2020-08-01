//
//  BFEXReChartWayTableViewCell.m
//  ZYW_MIT
//
//  Created by 张本超 on 2018/7/3.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "BFEXReChartWayTableViewCell.h"
#import "ManagerSocket.h"


@interface BFEXReChartWayTableViewCell()
//支付方式img
@property (nonatomic, strong) UIImageView *imgTitle;
//支付name
@property (nonatomic, strong) UILabel *weChatLabel;
//支付详情
@property (nonatomic, strong) UILabel *messageLabel;
//修改按钮
@property (nonatomic, strong) UIButton *changedBtn;
//开关
@property (nonatomic, strong) UIButton *switchButton;

@property (nonatomic, strong) FB_PayWayModel *model;
@end

@implementation BFEXReChartWayTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = kBgColor;
        [self viewConfigs];
    }
    return self;
}

-(void)viewConfigs
{
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectZero];
    
    lineView.backgroundColor = kLineColor;
    
    [self.contentView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.equalTo(self.contentView);
         make.left.equalTo(self.contentView).offset(ScaleW(15));
 
         make.height.mas_equalTo(1);
         make.bottom.equalTo(self.contentView);
    }];
    [self imgTitle];
    [self weChatLabel];
    [self messageLabel];
    [self switchButton];
    [self changedBtn];
}
-(UIImageView *)imgTitle
{
    if (!_imgTitle) {
        _imgTitle = [[UIImageView alloc]init];
        _imgTitle.image = [UIImage imageNamed:@""];
        [self.contentView addSubview:_imgTitle];
        [_imgTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(15)));
//            make.height.equalTo(@(ScaleW(33)));
            make.top.equalTo(@(ScaleW(20)));
        }];
    }
    return _imgTitle;
}

-(UILabel *)weChatLabel{
    if (!_weChatLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:ScaleW(15)];
        label.text = SSKJLocalized(@"微信", nil);
        label.textColor = kTitleColor;
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self->_imgTitle.mas_centerY);
            make.left.equalTo(self->_imgTitle.mas_right).offset(ScaleW(15));
        }];
        _weChatLabel = label;
    }
    return _weChatLabel;
}
-(UILabel *)messageLabel{
    if (!_messageLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:ScaleW(12)];
        label.text = @"";
        label.textColor = kTitleColor;
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_weChatLabel.mas_bottom).offset(ScaleW(13));
            make.left.equalTo(self->_weChatLabel.mas_left);
        }];
        _messageLabel = label;
    }
    return _messageLabel;
}
-(UIButton *)changedBtn{
    if (!_changedBtn) {
        UIButton *button = [[UIButton alloc] init];
        button.titleLabel.font = [UIFont systemFontOfSize:ScaleW(14)];
        [button setTitle:SSKJLocalized(@"修改", nil) forState:UIControlStateNormal];
        [button setTitleColor:kBlueColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self->_imgTitle.mas_right).offset(ScaleW(15));
            make.top.equalTo(self->_messageLabel.mas_bottom).offset(ScaleW(15));
            make.height.equalTo(@(ScaleW(30)));
        }];
        _changedBtn = button;
    }
    return _changedBtn;
}

-(void)buttonClicked:(UIButton *)sender
{
    !self.edtingBlock?:self.edtingBlock(self.model);
}

-(UIButton *)switchButton
{
    if (!_switchButton) {
        _switchButton = [[UIButton alloc]init];
        [_switchButton setImage:[UIImage imageNamed:@"mine_switch_on"] forState:UIControlStateNormal];
        [_switchButton setImage:[UIImage imageNamed:@"mine_switch_off"] forState:UIControlStateSelected];
        [self.contentView addSubview:_switchButton];
        [_switchButton addTarget:self action:@selector(swithAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.changedBtn.mas_right).offset(ScaleW(20));
            make.centerY.equalTo(self.changedBtn.mas_centerY);
        }];
    }
    return _switchButton;
}
-(void)swithAction:(UIButton *)swith
{
    if (self.switchBlock) {
        self.switchBlock(self.model);
    }
}
-(void)setValueData:(FB_PayWayModel *)model
{
    _model = model;
    NSString *img = nil;
    NSString *payType = nil;
    if ([model.payType isEqualToString:@"3"]) {
      //银行卡
        img = @"root_yhk";
        payType = SSKJLocalized(@"银行卡", nil);
    }
    if ([model.payType isEqualToString:@"1"]) {
      img = @"root_wx";
        payType = SSKJLocalized(@"微信", nil);

    }
    if ([model.payType isEqualToString:@"2"]) {
      img = @"root_alipay";
        payType = SSKJLocalized(@"支付宝", nil);
    }
    
    
    _imgTitle.image = [UIImage imageNamed:img];
    _weChatLabel.text = payType;
    _messageLabel.text = [NSString stringWithFormat:@"%@  %@",model.account,[SSKJ_User_Tool sharedUserTool].userInfoModel.username];
    self.switchButton.selected = model.status.boolValue;
};
@end
