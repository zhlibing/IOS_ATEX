//
//  Heyue_AllPingCang_AlertView.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/8/5.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Heyue_AllPingCang_AlertView : UIView

@property (nonatomic, copy) void (^AllPingCangBlock)(void);
-(void)showWithMessage:(NSString *)message;
-(void)hide;

@end

NS_ASSUME_NONNULL_END
