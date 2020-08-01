//
//  BIPaymentMaskOptionControl.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BIPaymentMaskOptionControl.h"

@interface BIPaymentMaskOptionControl ()

@property (nonatomic,strong) UILabel *titleLabel; //!< 标题


@end

@implementation BIPaymentMaskOptionControl


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.titleLabel];
    }
    return self;
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.titleLabel setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
}

-(void)setTitle:(NSString*)title
{
    [self.titleLabel setText:SSKJLocalized(title, nil)];
}


#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kBgColor font:systemFont(ScaleW(14.0))];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}



@end
