//
//  BIAlipaWeiXinyPaymentScrollView.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BIAlipaWeiXinyPaymentScrollView.h"

@implementation BIAlipaWeiXinyPaymentScrollView



- (instancetype)initWithType:(NSInteger)type
{
    self = [super init];
    if (self)
    {
        
        [self setShowsVerticalScrollIndicator:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        switch (type)
        {
            case 1:
            {
                [self addSubview:self.nameView];
                [self addSubview:self.accountNumnerView];
                [self addSubview:self.codeView];
                [self addSubview:self.passwordView];
            }
                break;
            case 2:
            {
                [self addSubview:self.nameView];
                [self addSubview:self.accountNumnerView];
                [self addSubview:self.bankNumberView];
                [self addSubview:self.openBankView];
                [self addSubview:self.passwordView];
            }
                break;
        }
        
    }
    return self;
}



-(void)resetFrame:(CGRect)frame withType:(NSInteger)type
{
    [self setFrame:frame];
    switch (type)
    {
        case 1:
        {
            [self.nameView resetFrame:CGRectMake(0,0, frame.size.width, ScaleW(85)) withType:4];
            
            [self.accountNumnerView resetFrame:CGRectMake(self.nameView.left, self.nameView.bottom, self.nameView.width, self.nameView.height) withType:1];
            [self.codeView resetFrame:CGRectMake(self.nameView.left, self.accountNumnerView.bottom, self.nameView.width, ScaleW(135)) withType:2];
            [self.passwordView resetFrame:CGRectMake(self.nameView.left, self.codeView.bottom, self.nameView.width, self.nameView.height) withType:1];
            
            
            SSLog(@"%f",self.passwordView.bottom);
            
        }
            break;
        case 2:
        {
            [self.nameView resetFrame:CGRectMake(0,0, frame.size.width, ScaleW(85)) withType:4];
            [self.accountNumnerView resetFrame:CGRectMake(self.nameView.left, self.nameView.bottom, self.nameView.width, self.nameView.height) withType:1];
            [self.bankNumberView resetFrame:CGRectMake(self.nameView.left, self.accountNumnerView.bottom, self.nameView.width, self.nameView.height) withType:1];
            [self.openBankView resetFrame:CGRectMake(self.nameView.left, self.bankNumberView.bottom, self.nameView.width, self.nameView.height) withType:1];
            [self.passwordView resetFrame:CGRectMake(self.nameView.left, self.openBankView.bottom, self.nameView.width, self.nameView.height) withType:1];
            
        }
            break;
    }
}






/**
 
 @param username 用户名
 @param account 付款账号
 @param url 二维码Url
 */
-(void)setUserName:(NSString*)username withPayAccount:(NSString*)account withQRUrl:(NSString*)url
{
    [self.nameView.describeLabel.describeLabel setText:username];
    [self.accountNumnerView.textField setText:account];
    [self.codeView.upLoadControl setImageUrl:url];
    [self.codeView setCodeUrl:url];
}






/**
 
 @param username 用户名
 @param bankName 银行名称
 @param account 银行卡账号
 @param openOptionBank 开户行
 */
-(void)setUserName:(NSString*)username withBankName:(NSString*)bankName withPayAccount:(NSString*)account withOpenOptionBank:(NSString*)openOptionBank
{
    [self.nameView.describeLabel.describeLabel setText:username];
    [self.accountNumnerView.textField setText:bankName];
    [self.bankNumberView.textField setText:account];
    [self.openBankView.textField setText:openOptionBank];
}




-(void)setImage:(UIImage*)image
{
    [self.codeView setPickImage:image];
}



#pragma mark - Getter / Setter


-(BIPaymentBoardItemView *)nameView
{
    if (!_nameView)
    {
        _nameView = [[BIPaymentBoardItemView alloc]initWithType:4];
    }
    return _nameView;
}


-(BIPaymentBoardItemView *)accountNumnerView
{
    if (!_accountNumnerView)
    {
        _accountNumnerView = [[BIPaymentBoardItemView alloc]initWithType:1];
    }
    return _accountNumnerView;
}


-(BIPaymentBoardItemView *)codeView
{
    if (!_codeView)
    {
        _codeView = [[BIPaymentBoardItemView alloc]initWithType:2];
    }
    return _codeView;
}


-(BIPaymentBoardItemView *)passwordView
{
    if (!_passwordView)
    {
        _passwordView = [[BIPaymentBoardItemView alloc]initWithType:1];
        [_passwordView.textField setSecureTextEntry:YES];
    }
    return _passwordView;
}


-(BIPaymentBoardItemView *)bankNumberView
{
    if (!_bankNumberView)
    {
        _bankNumberView = [[BIPaymentBoardItemView alloc]initWithType:1];
    }
    return _bankNumberView;
}

-(BIPaymentBoardItemView *)openBankView
{
    if (!_openBankView)
    {
        _openBankView = [[BIPaymentBoardItemView alloc]initWithType:1];
    }
    return _openBankView;
}

@end
