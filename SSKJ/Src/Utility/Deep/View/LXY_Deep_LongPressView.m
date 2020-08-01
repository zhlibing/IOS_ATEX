//
//  LXY_Deep_LongPressView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/3/19.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "LXY_Deep_LongPressView.h"

@interface LXY_Deep_LongPressView ()
@property (nonatomic, strong) UIView *centerView;
@end

@implementation LXY_Deep_LongPressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.centerView];
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = self.height / 2;
    }
    return self;
}

-(UIView *)centerView
{
    if (nil == _centerView) {
        _centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(5), ScaleW(5))];
        _centerView.layer.cornerRadius = ScaleW(2.5);
        _centerView.center = CGPointMake(self.width / 2, self.height / 2);
        
    }
    return _centerView;
}

-(void)setType:(NSInteger)type
{
    _type = type;
    UIColor *color;
    if (type == 0) {
        color = [UIColor lxy_riseColor];
    }else{
        color = [UIColor lxy_fallColor];
    }
    
    self.layer.borderColor = color.CGColor;
    self.centerView.backgroundColor = color;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
