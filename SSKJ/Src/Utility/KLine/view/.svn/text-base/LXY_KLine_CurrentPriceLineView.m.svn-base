//
//  LXY_KLine_CurrentPriceLineView.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/26.
//  Copyright © 2018年 James. All rights reserved.
//

#import "LXY_KLine_CurrentPriceLineView.h"
#import "LXY_KLineAnimationView.h"
#import "LXY_KLinePositionTool.h"
@interface LXY_KLine_CurrentPriceLineView ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) LXY_KLineAnimationView *animationView;

@property (nonatomic, strong) UIButton *currentPriceButton;

@property (nonatomic, assign) CGFloat positionX;

@property (nonatomic, assign) BOOL isShowCurrent;
@end

@implementation LXY_KLine_CurrentPriceLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self addSubview:self.lineView];
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        [self addSubview:self.animationView];
        [self addSubview:self.currentPriceButton];
    }
    return self;
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        _lineView.backgroundColor = [UIColor redColor];
        _lineView.centerY = self.height / 2;
    }
    return _lineView;
}

-(LXY_KLineAnimationView *)animationView
{
    if (nil == _animationView) {
        _animationView = [[LXY_KLineAnimationView alloc]initWithFrame:CGRectMake(self.width - self.height / 2, 0, self.height, self.height)];
        _animationView.centerY = self.height / 2;
    }
    return _animationView;
}

-(UIButton *)currentPriceButton
{
    if (nil == _currentPriceButton) {
        _currentPriceButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
        _currentPriceButton.centerY = self.height / 2;
        _currentPriceButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _currentPriceButton.backgroundColor = kBgColor;
        _currentPriceButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _currentPriceButton.layer.borderWidth = 1;
        _currentPriceButton.layer.cornerRadius = _currentPriceButton.height / 2;
        [_currentPriceButton setTitleColor:[UIColor lxy_priceColor] forState:UIControlStateNormal];
        _currentPriceButton.titleLabel.font = systemFont(14);
        [_currentPriceButton addTarget:self action:@selector(toLast) forControlEvents:UIControlEventTouchUpInside];
    }
    return _currentPriceButton;
}

-(void)setCurrentPriceWithPositionY:(CGFloat)positionY positionX:(CGFloat)positionX isLast:(BOOL)isLast currentPrice:(NSString *)currentPrice
{
    
    NSString *formate = [NSString stringWithFormat:@"%%.%ldf",LXY_DecimalNumber];
    
    currentPrice = [NSString stringWithFormat:formate,currentPrice.doubleValue];
        
//    self.lineView.width = positionX;
    self.animationView.centerX = positionX;
    self.animationView.hidden = !isLast;
    _positionX = positionX;
    if (positionX >= self.width -  1.5 *([LXY_KLinePositionTool kLineWidth] + [LXY_KLinePositionTool kLineGap])) {
        self.animationView.hidden = YES;
        self.currentPriceButton.hidden = NO;
        self.currentPriceButton.centerX = ScreenWidth - 100;
        [self.currentPriceButton setTitle:[currentPrice stringByAppendingString:@"→"] forState:UIControlStateNormal];
        _isShowCurrent = NO;
    }else{
        self.animationView.hidden = NO;
        self.currentPriceButton.hidden = YES;
        _isShowCurrent = YES;
    }
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGFloat lengths[] = {4,2};
    CGContextSetLineDash(context, 0, lengths, 2);
//    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(context, kBlueColor.CGColor);

    [[UIColor clearColor]setFill];
    CGContextSetLineWidth(context, 1);
    if (_isShowCurrent == YES) {
        CGContextMoveToPoint(context, self.positionX, self.height / 2);
        CGContextAddLineToPoint(context, self.width, self.height / 2);
    }else{
        CGContextMoveToPoint(context, 0, self.height / 2);
        CGContextAddLineToPoint(context, self.currentPriceButton.x, self.height / 2);
        
        CGContextMoveToPoint(context, self.currentPriceButton.right, self.height / 2);
        CGContextAddLineToPoint(context, self.width, self.height / 2);
    }
    
    CGContextStrokePath(context);
    
    
}

-(void)toLast
{
    if (self.toLastBlock) {
        self.toLastBlock();
    }
}
-(void)setSocketPrice:(NSString *)socketPrice
{
    [self.currentPriceButton setTitle:[socketPrice stringByAppendingString:@"→"]  forState:UIControlStateNormal];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // 1.判断当前控件能否接收事件
    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) return nil;
    // 2. 判断点在不在当前控件
    if ([self pointInside:point withEvent:event] == NO) return nil;
    // 3.从后往前遍历自己的子控件
    NSInteger count = self.subviews.count;
    for (NSInteger i = count - 1; i >= 0; i--) {
        UIView *childView = self.subviews[i];
        // 把当前控件上的坐标系转换成子控件上的坐标系
        CGPoint childP = [self convertPoint:point toView:childView];
        UIView *fitView = [childView hitTest:childP withEvent:event];
        if (fitView) { // 寻找到最合适的view
            return fitView;
        }
    }
    
    
    NSArray *array = self.superview.superview.subviews;
    for (UIView *view in array) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            return view;
        }
    }
    // 循环结束,表示没有比自己更合适的view
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
