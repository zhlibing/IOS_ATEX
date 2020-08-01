


//
//  UIView+cornerAndColors.m
//  SSKJ
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "UIView+cornerAndColors.h"


@implementation UIView (cornerAndColors)

- (void)setCornerRadius:(CGFloat)cornerRadius corners:(UIRectCorner)corners  colors:(NSArray<UIColor *> *)colors{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius,cornerRadius)];

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

    maskLayer.frame = self.bounds;

    maskLayer.path = maskPath.CGPath;

    self.layer.mask = maskLayer;
    
    //添加渐变色
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    
    if (colors.count == 2) {
        gradientLayer.colors = @[(__bridge id)colors[0].CGColor,(__bridge id)colors[1].CGColor, ];
        gradientLayer.startPoint = CGPointMake(0.0, 0.5);
        gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    }else if(colors.count == 3){
        gradientLayer.colors = @[(__bridge id)colors[0].CGColor,(__bridge id)colors[1].CGColor, (__bridge id)colors[2].CGColor];
        gradientLayer.startPoint = CGPointMake(0.0, 0);
        gradientLayer.endPoint = CGPointMake(0.0, 1);
    }
    
    

    gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));

    [self.layer addSublayer:gradientLayer];
    
}


- (void)setCornerRadius:(CGFloat)cornerRadius corners:(UIRectCorner)corners {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius,cornerRadius)];

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

    maskLayer.frame = self.bounds;

    maskLayer.path = maskPath.CGPath;

    self.layer.mask = maskLayer;
}




@end
