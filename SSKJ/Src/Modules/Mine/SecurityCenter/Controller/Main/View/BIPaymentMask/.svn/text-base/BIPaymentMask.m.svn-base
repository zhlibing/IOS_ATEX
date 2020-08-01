//
//  BIPaymentMask.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BIPaymentMask.h"


@interface BIPaymentMask  ()



@property (nonatomic,strong) BIPaymentMaskOptionControl *alipayControl; //!< 支付宝支付
@property (nonatomic,strong) BIPaymentMaskOptionControl *weixinPayControl; //!< 微信支付
@property (nonatomic,strong) BIPaymentMaskOptionControl *bankControl; //!<



@property (nonatomic,weak) id <BIPaymentMaskDelegate> delegate;



@end

@implementation BIPaymentMask



- (instancetype)initWithDelegate:(id<BIPaymentMaskDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        [self setBackgroundColor:kTitleColor];
        [self setDelegate:delegate];
        [self addSubview:self.alipayControl];
        [self addSubview:self.weixinPayControl];
        [self addSubview:self.bankControl];
    }
    return self;
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    [self.weixinPayControl resetFrame:CGRectMake(0,0, frame.size.width, ScaleW(40))];
    [self.alipayControl resetFrame:CGRectMake(0, self.weixinPayControl.bottom, self.weixinPayControl.width, self.weixinPayControl.height)];
    [self.bankControl resetFrame:CGRectMake(0, self.alipayControl.bottom, self.alipayControl.width, self.alipayControl.height)];
}

-(void)maskControlAction:(BIPaymentMaskOptionControl*)control
{
    [self setHidden:YES];
    
    if ([self.delegate respondsToSelector:@selector(paymentAction:)])
    {
        [self.delegate paymentAction:control];
    }
}

#pragma mark - Getter / Setter
-(BIPaymentMaskOptionControl *)weixinPayControl
{
    if (!_weixinPayControl)
    {
        _weixinPayControl = [[BIPaymentMaskOptionControl alloc]init];
        [_weixinPayControl setTitle:@"微信"];
        [_weixinPayControl addTarget:self action:@selector(maskControlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_weixinPayControl setTag:1];
    }
    return _weixinPayControl;
}

-(BIPaymentMaskOptionControl *)alipayControl
{
    if (!_alipayControl)
    {
        _alipayControl = [[BIPaymentMaskOptionControl alloc]init];
        [_alipayControl setTitle:@"支付宝"];
        [_alipayControl addTarget:self action:@selector(maskControlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_alipayControl setTag:2];
    }
    return _alipayControl;
}


-(BIPaymentMaskOptionControl *)bankControl
{
    if (!_bankControl)
    {
        _bankControl = [[BIPaymentMaskOptionControl alloc]init];
        [_bankControl setTitle:@"银行卡"];
        [_bankControl addTarget:self action:@selector(maskControlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bankControl setTag:3];
    }
    return _bankControl;
}





@end
