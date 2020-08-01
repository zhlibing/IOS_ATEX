//
//  UITextField+Helper.h
//  SiLuTianYu
//
//  Created by apple on 16/4/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITextField(Helper)
/**
 *限制小数点输入小数点后两位
 * ////使用规范
 * ///在UITextFieldDelegate
 *-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
 return [textField textFieldShouldChangeCharactersInRange:range replacementString:string];
 }
 */
-(BOOL)textFieldShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string dotNumber:(NSInteger)dotnumber;
/**
 *  限制字数
 */
-(void)setMaxLength:(NSInteger)maxlength;
@end
