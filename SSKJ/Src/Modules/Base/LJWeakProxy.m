//
//  LJWeakProxy.m
//  SSKJ
//
//  Created by 姚立志 on 2020/9/5.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "LJWeakProxy.h"

@implementation LJWeakProxy


+ (instancetype)proxyWithTarget:(id)target
{
    LJWeakProxy *proxy = [LJWeakProxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:self.target];
}


@end
