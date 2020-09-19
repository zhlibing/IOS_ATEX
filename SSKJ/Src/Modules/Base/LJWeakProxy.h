//
//  LJWeakProxy.h
//  SSKJ
//
//  Created by 姚立志 on 2020/9/5.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJWeakProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)target;
@property (weak, nonatomic) id target;

@end

NS_ASSUME_NONNULL_END
