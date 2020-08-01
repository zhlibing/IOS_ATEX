//
//  WL_Network_Model.m
//  WeiLv
//
//  Created by James on 16/6/3.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import "WL_Network_Model.h"

@implementation WL_Network_Model
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"status": @"code",
//             @"msg":@"message"
             };
}

- (NSString *)msg{
    if (!_msg.length) {
        _msg = self.message;
    }
    return _msg;
}
@end
