//
//  BIPaymentBoardItemView.h
//  SSKJ
//
//  Created by 姚立志 on 2019/6/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BIPaymentBoardItemTextField.h"
#import "BIPaymentUpLoadControl.h"
#import "BIPaymentOptionControl.h"
#import "BIPaymentLabel.h"



NS_ASSUME_NONNULL_BEGIN

@interface BIPaymentBoardItemView : UIView


@property (nonatomic,strong) UILabel *titleLabel; //!< 标题
@property (nonatomic,strong) BIPaymentLabel *describeLabel; //!< 描述标题
@property (nonatomic,strong) BIPaymentBoardItemTextField *textField; //!< 输入框
@property (nonatomic,strong) BIPaymentUpLoadControl *upLoadControl;//!< 上传图片按钮
@property (nonatomic,strong) BIPaymentOptionControl *optionControl; //!< 支付方式选择



@property (nonatomic,copy) NSString *codeUrl; //!< 二维码Url






-(void)setTitle:(NSString*)title withPlaceholder:(NSString*)placeholder;

-(void)setTitle:(NSString*)title withTip:(NSString*)tip withType:(NSInteger)type;

-(void)setTip:(NSString*)tip withType:(NSInteger)type;

- (instancetype)initWithType:(NSInteger)type;


-(void)resetFrame:(CGRect)frame withType:(NSInteger)type;

-(void)setPickImage:(UIImage*)image;


@end

NS_ASSUME_NONNULL_END
