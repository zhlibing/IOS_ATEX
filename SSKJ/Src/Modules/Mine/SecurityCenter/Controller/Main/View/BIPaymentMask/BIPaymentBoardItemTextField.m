//
//  BIPaymentBoardItemTextField.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BIPaymentBoardItemTextField.h"

@implementation BIPaymentBoardItemTextField





-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectMake(ScaleW(10),0 , bounds.size.width-ScaleW(20), bounds.size.height);
}


//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(ScaleW(10),0 , bounds.size.width-ScaleW(20), bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectMake(ScaleW(10),0 , bounds.size.width-ScaleW(20), bounds.size.height);
}


@end
