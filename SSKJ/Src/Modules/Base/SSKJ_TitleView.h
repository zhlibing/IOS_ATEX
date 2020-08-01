//
//  SSKJ_TitleView.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/12/6.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSKJ_TitleView : UIView
-(void)changeTitle:(NSString *)title;
-(void)changeTitleColor:(UIColor *)titleColor;
-(void)changeTitleFont:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
