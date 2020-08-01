//
//  SSKJ_Login_Model.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/12/10.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import "SSKJ_Login_Model.h"

@implementation SSKJ_Login_Model

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"uid": @"id",
             @"mobile": @"tel"
             };
}
@end
