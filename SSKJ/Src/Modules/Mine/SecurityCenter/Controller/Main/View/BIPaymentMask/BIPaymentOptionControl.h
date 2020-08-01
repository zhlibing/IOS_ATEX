//
//  BIPaymentOptionControl.h
//  SSKJ
//
//  Created by 姚立志 on 2019/6/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BIPaymentOptionControl : UIControl

@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UIImageView *iconImageView;






-(void)resetFrame:(CGRect)frame;


-(void)setTip:(NSString*)tip;


@end

NS_ASSUME_NONNULL_END
