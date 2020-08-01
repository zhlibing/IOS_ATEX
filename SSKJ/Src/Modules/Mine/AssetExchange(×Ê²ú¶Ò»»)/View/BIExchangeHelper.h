//
//  BIExchangeHelper.h
//  SSKJ
//
//  Created by 姚立志 on 2019/6/28.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BIExchangeHelper : NSObject



#pragma mark 判断用户输入数据是否合法
-(NSString*)opinion:(NSString*)title withNumer:(NSInteger)numer;


@end

NS_ASSUME_NONNULL_END
