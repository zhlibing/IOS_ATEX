//
//  BIPaymentMask.h
//  SSKJ
//
//  Created by 姚立志 on 2019/6/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BIPaymentMaskOptionControl.h"


@protocol BIPaymentMaskDelegate <NSObject>

-(void)paymentAction:(BIPaymentMaskOptionControl*_Nullable)sender;


@end

NS_ASSUME_NONNULL_BEGIN

@interface BIPaymentMask : UIView


- (instancetype)initWithDelegate:(id<BIPaymentMaskDelegate>)delegate;


-(void)resetFrame:(CGRect)frame;


@end

NS_ASSUME_NONNULL_END
