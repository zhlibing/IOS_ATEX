//
//  VerifyCodeButton.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "VerifyCodeButton.h"

@interface VerifyCodeButton ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger count;

@end

@implementation VerifyCodeButton

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.font = systemFont(14);
    self.backgroundColor = kSubBgColor;
    self.layer.cornerRadius = 3.0;
    self.clipsToBounds = YES;
    [self setTitleColor:kBlueColor forState:UIControlStateNormal];
}

- (void)timeFailBeginFrom:(NSInteger)timeCount {
    self.count = timeCount;
    self.enabled = NO;
    // 加1个计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}

- (void)timerFired {
    if (self.count != 1) {
        self.count -= 1;
        [self setTitle:[NSString stringWithFormat:SSKJLocalized(@"%lds",nil), self.count] forState:UIControlStateDisabled];
    } else {
        self.enabled = YES;
        [self setTitle:SSKJLocalized(@"重新获取", nil) forState:UIControlStateNormal];
        self.count = 60;
        [self setTitle:[NSString stringWithFormat:SSKJLocalized(@"%lds",nil), self.count] forState:UIControlStateDisabled];
        [self.timer invalidate];
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
