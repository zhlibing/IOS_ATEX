//
//  BIBindOptionView.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BIBindOptionView.h"

@interface BIBindOptionView ()

@property (nonatomic,strong) UITextField *inputTextField; //!< 输入框
@property (nonatomic,strong) UIView *lineView; //!< 分割线



@end

@implementation BIBindOptionView


-(instancetype)initWithFrame:(CGRect )frame placeHolder:(NSString *)placeHolder keyBoardType:(UIKeyboardType)keyBoardType setSecureTextEntry:(BOOL)secureTextEntry
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.inputTextField];
        [self addSubview:self.lineView];
        
        [self.inputTextField setFrame:CGRectMake(ScaleW(10), 0, frame.size.width-ScaleW(20), frame.size.height)];
        [self.lineView setFrame:CGRectMake(self.inputTextField.left, frame.size.height-ScaleW(0.5), self.inputTextField.width, ScaleW(0.5))];
        [self.inputTextField setPlaceholder:placeHolder];
        [self.inputTextField setKeyboardType:keyBoardType];
        [self.inputTextField setSecureTextEntry:secureTextEntry];
//        [self.inputTextField setValue:UIColorFromRGB(0x898d98) forKeyPath:@"_placeholderLabel.textColor"];
        
       
        
    }
    return self;
}


#pragma mark - Getter / Setter
- (UITextField *)inputTextField
{
    if (!_inputTextField)
    {
        _inputTextField = [[UITextField alloc]init];
        _inputTextField.textColor = kTitleColor;
        [_inputTextField setFont:systemFont(ScaleW(15))];
    }
    return _inputTextField;
}


-(UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]init];
        
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}



-(NSString *)valueText
{
    return self.inputTextField.text;
}



@end
