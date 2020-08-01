//
//  Heyue_OrderDdetail_Model.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/8/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_OrderDdetail_Model.h"

@implementation Heyue_OrderDdetail_Model


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"marketPrice": @"newprice",
             @"ID": @"id"

             };
}


@end
