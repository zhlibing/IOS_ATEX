//
//  VerifyCodeButton.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/3/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VerifyCodeButton : UIButton

// 由于有些时间需求不同，特意露出方法，倒计时时间次数
- (void)timeFailBeginFrom:(NSInteger)timeCount;

@end

NS_ASSUME_NONNULL_END
