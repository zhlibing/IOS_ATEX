//
//  RechargeModel.m
//  SSKJ
//
//  Created by 姚立志 on 2020/8/2.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "RechargeModel.h"

@implementation RechargeModel

-(void)setCode:(NSString *)code
{
    NSArray *codeArray = [code componentsSeparatedByString:@"-"];
    if ([codeArray count]>=2)
    {
        _code = [codeArray lastObject];
    }
    else
    {
        _code = code;
    }
}

@end
