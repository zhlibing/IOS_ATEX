//
//  MyWithdrawMoneyView.h
//  SSKJ
//
//  Created by mac on 2019/9/12.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyWithdrawMoneyView : UIView
@property (nonatomic, strong) FSTextView *textView;

@property (nonatomic, copy) NSString *valueString;
-(instancetype)initWithFrame:(CGRect )frame title:(NSString *)title placeHolder:(NSString *)placeHolder keyBoardType:(UIKeyboardType)keyBoardType;
@end

NS_ASSUME_NONNULL_END
