//
//  LXY_KLineAnimationView.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/26.
//  Copyright © 2018年 James. All rights reserved.
//

#import "LXY_KLineAnimationView.h"
#import "UIColor+LXYKline.h"

@interface LXY_KLineAnimationView ()
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIView *flashView;
@end

@implementation LXY_KLineAnimationView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.layer addAnimation:[self AlphaLight:1] forKey:<#(nullable NSString *)#>
        [self addSubview:self.flashView];
        [self addSubview:self.centerView];
        [self begigFlashAnimation];
    }
    return self;
}

-(UIView *)flashView
{
    if (nil == _flashView) {
        _flashView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        _flashView.center = CGPointMake(self.width / 2, self.height / 2);
        _flashView.layer.cornerRadius = _flashView.height  / 2;
        _flashView.backgroundColor = [UIColor clearColor];
    }
    return _flashView;
}

-(UIView *)centerView
{
    if (nil == _centerView) {
        _centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        _centerView.center = CGPointMake(self.width / 2, self.height / 2);
        _centerView.layer.cornerRadius = _centerView.height  / 2;
        _centerView.layer.borderColor =[UIColor lxy_animationColor].CGColor;
        _centerView.layer.borderWidth = 3;
//        _centerView.backgroundColor = [UIColor whiteColor];
        _centerView.backgroundColor = kBlueColor;
    }
    return _centerView;
}


-(void)begigFlashAnimation {
    // 缩放 + 透明度动画
    
    WS(weakSelf);
//    self.flashView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.6 animations:^{
        weakSelf.centerView.alpha = 0;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.6 animations:^{
            weakSelf.centerView.alpha = 1;
        }completion:^(BOOL finished) {
            [weakSelf begigFlashAnimation];
        }];
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
