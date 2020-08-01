//
//  SSKJ_UserInfo_Model.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2020/3/25.
//  Copyright © 2020 Wang. All rights reserved.
//

#import "SSKJ_UserInfo_Model.h"

@implementation SSKJ_UserInfo_Model
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"UID": @"id",
             };
}
@end
