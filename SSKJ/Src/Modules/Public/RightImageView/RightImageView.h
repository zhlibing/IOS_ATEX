//
//  RightImageView.h
//  SSKJ
//
//  Created by zpz on 2019/11/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RightImageView : UIView

- (instancetype)initWithWithTitle:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font Img:(NSString *)img space:(CGFloat)space target:(_Nullable id)target action:(_Nullable SEL)action;

@end

NS_ASSUME_NONNULL_END
