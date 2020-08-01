//
//  WL_BaseModel.m
//  WeiLv
//
//  Created by James on 16/5/19.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
// 【诸葛信用管家】->实体 基类

#import "WL_BaseModel.h"

@implementation WL_BaseModel

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if (oldValue == nil) {
        return @"";  // 以字符串类型为例
    }
    return oldValue;
}


@end
