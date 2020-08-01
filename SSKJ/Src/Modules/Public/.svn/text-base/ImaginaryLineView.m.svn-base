//
//  ImaginaryLineView.m
//  Business
//
//  Created by zpz on 2017/11/3.
//  Copyright © 2017年 zpz. All rights reserved.
//

#import "ImaginaryLineView.h"

@implementation ImaginaryLineView

- (void)drawRect:(CGRect)rect{

    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(currentContext, kWhiteColor.CGColor);
    CGContextSetLineWidth(currentContext, .5);
    CGContextMoveToPoint(currentContext, 0, 0);
    CGContextAddLineToPoint(currentContext, self.frame.origin.x + self.frame.size.width, 0);
    CGFloat arr[] = {3,1};
    CGContextSetLineDash(currentContext, 0, arr, 2);
    CGContextDrawPath(currentContext, kCGPathStroke);
}

@end
