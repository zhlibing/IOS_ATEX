//
//  BIPaymentLabel.h
//  SSKJ
//
//  Created by 姚立志 on 2019/6/26.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BIPaymentLabel : UIView


@property (nonatomic, strong) UILabel *describeLabel;

-(void)resetFrame:(CGRect)frame;


@end

NS_ASSUME_NONNULL_END
