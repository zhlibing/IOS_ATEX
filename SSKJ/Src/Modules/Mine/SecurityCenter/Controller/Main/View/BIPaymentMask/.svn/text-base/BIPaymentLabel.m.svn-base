//
//  BIPaymentLabel.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/26.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BIPaymentLabel.h"

@implementation BIPaymentLabel


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.describeLabel];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.describeLabel setFrame:CGRectMake(ScaleW(10), 0, frame.size.width-ScaleW(20),frame.size.height)];
}






-(UILabel *)describeLabel
{
    if (!_describeLabel)
    {
        _describeLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:[UIColor whiteColor] font:systemFont(ScaleW(13.0))];
    }
    return _describeLabel;
}


@end
