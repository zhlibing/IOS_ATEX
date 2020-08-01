//
//  My_PrimaryCertificate_View.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_PrimaryCertificate_View.h"

@interface My_PrimaryCertificate_View ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIImageView *statusImageView;
@property (nonatomic, strong) UILabel *stautsLabel;
@end

@implementation My_PrimaryCertificate_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setUI];
    }
    return self;
}




#pragma mark - 点击当前认证视图的方法
-(void)clickEvent
{
    if (self.clickBlock)
    {
        self.clickBlock();
    }
}



#pragma mark - 设置数据模型
-(void)setUserModel:(SSKJ_UserInfo_Model *)userModel
{
    switch ([userModel.basicAuthenticationStatus integerValue])
    {
        #pragma mark case 0 未认证
        case 0:
        {  // 未认证
            self.infoLabel.hidden = NO;
            self.statusImageView.hidden = YES;
            self.stautsLabel.x = self.titleLabel.x;
            self.stautsLabel.text = SSKJLocalized(@"未认证", nil);
        }
            break;
        #pragma mark case 2 待审核
        case 2:
        {  // 待审核
            self.infoLabel.hidden = YES;
            self.statusImageView.hidden = YES;
            self.stautsLabel.x = self.titleLabel.x;
            self.stautsLabel.text = SSKJLocalized(@"审核中", nil);
        }
            break;
        #pragma mark case 3 已认证
        case 1:
        {   // 已认证
            self.infoLabel.text = [NSString stringWithFormat:@"%@ | %@",userModel.username,userModel.idCard];
            self.infoLabel.hidden = NO;
            self.statusImageView.hidden = NO;
            self.stautsLabel.x = self.statusImageView.right + ScaleW(5);
            self.stautsLabel.text = SSKJLocalized(@"认证成功", nil);
            
        }
            break;
        #pragma mark case 4 被拒绝
        case 4:
        {  // 被拒绝
            self.infoLabel.hidden = YES;
            self.statusImageView.hidden = YES;
            self.stautsLabel.x = self.titleLabel.x;
            self.stautsLabel.text = SSKJLocalized(@"被拒绝", nil);
        }
            break;
        default:
        {
            self.infoLabel.hidden = YES;
            self.statusImageView.hidden = YES;
            self.stautsLabel.x = self.titleLabel.x;
            self.stautsLabel.text = SSKJLocalized(@"待认证", nil);
        }
            break;
    }
}






#pragma mark - Deletage Method
-(void)setUI
{
    [self addSubview:self.backView];
    [self.backView addSubview:self.iconImageView];
    [self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.infoLabel];
    [self.backView addSubview:self.statusImageView];
    [self.backView addSubview:self.stautsLabel];
}

-(UIView *)backView
{
    if (nil == _backView)
    {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth - ScaleW(30), self.height)];
        _backView.backgroundColor = kBgColor;
        _backView.layer.cornerRadius = ScaleW(8);
         [_backView setUserInteractionEnabled:NO];
    }
    return _backView;
}

-(UIImageView *)iconImageView
{
    if (nil == _iconImageView)
    {
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.backView.width - ScaleW(21) - ScaleW(ScaleW(50)), ScaleW(50), ScaleW(50), ScaleW(50))];
        _iconImageView.centerY = self.height / 2;
        [_iconImageView setContentMode:UIViewContentModeScaleAspectFit];
        _iconImageView.image = [UIImage imageNamed:@"Mine_shiming"];
    }
    return _iconImageView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:systemFont(ScaleW(13.5))];
        [_titleLabel setText:SSKJLocalized(@"实名认证", nil)];
        [_titleLabel setFrame:CGRectMake(ScaleW(21), ScaleW(20), ScaleW(200), ScaleW(14))];
        [_titleLabel setTextColor:kTitleColor];
    }
    return _titleLabel;
}



-(UILabel *)infoLabel
{
    if (nil == _infoLabel)
    {
        _infoLabel = [[UILabel alloc]init];
        _infoLabel.text = SSKJLocalized(@"实名认证", nil);
        [_infoLabel setFont:systemFont(ScaleW(11.5))];
        [_infoLabel setTextColor:kSubTitleColor];
        [_infoLabel setFrame:CGRectMake(self.titleLabel.x, self.titleLabel.bottom + ScaleW(14), self.iconImageView.x - self.titleLabel.x, ScaleW(12))];
    }
    return _infoLabel;
}

-(UIImageView *)statusImageView
{
    if (nil == _statusImageView)
    {
        _statusImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.titleLabel.x, self.infoLabel.bottom + ScaleW(12), ScaleW(16.5), ScaleW(16.5))];
        _statusImageView.layer.masksToBounds = YES;
        _statusImageView.layer.cornerRadius = _statusImageView.height / 2;
        _statusImageView.image = [UIImage imageNamed:@"Mine_renzheng_yes"];
    }
    return _statusImageView;
}

-(UILabel *)stautsLabel
{
    if (nil == _stautsLabel)
    {
        _stautsLabel = [FactoryUI createLabelWithFrame:CGRectMake(self.statusImageView.right + ScaleW(5), 0, self.iconImageView.x - self.statusImageView.right - ScaleW(5), ScaleW(12)) text:SSKJLocalized(@"认证成功", nil) textColor:kBlueColor font:systemFont(ScaleW(11))];
        
        _stautsLabel.centerY = self.statusImageView.centerY;
    }
    return _stautsLabel;
}






@end
