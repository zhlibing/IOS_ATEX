
//
//  NSTimer+weakTimer.m
//  test_oc
//
//  Created by mac on 2020/3/6.
//  Copyright © 2020 mac. All rights reserved.
//

#import "NSTimer+weakTimer.h"



@implementation NSTimer (weakTimer)
+(NSTimer *)sxf_weakTimerSchedulTimerWithTimerinter:(NSTimeInterval)ti block:(void(^)(void))block repeats:(BOOL)yesOrNo{
    return [self scheduledTimerWithTimeInterval:ti target:self selector:@selector(sxf_blickInvoke:) userInfo:[block copy] repeats:yesOrNo];
}


+(void)sxf_blickInvoke:(NSTimer *)timer{
    void(^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}




@end
