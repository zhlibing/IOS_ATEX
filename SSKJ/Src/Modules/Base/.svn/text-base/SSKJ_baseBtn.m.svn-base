//
//  SSKJ_baseBtn.m
//  SSKJ
//
//  Created by mac on 2019/11/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_baseBtn.h"

@implementation SSKJ_baseBtn

+ (instancetype) creatBtnWithFrame:(CGRect)fraqme title:(NSString *)title font:(UIFont *)font titleColor:(UIColor*)titleColor btnType:(ButtonType)btnType{
    return [SSKJ_baseBtn creatBtnWithFrame:fraqme bgImgeStr:@"" title:title font:font titleColor:titleColor btnType:btnType];
}

+ (instancetype) creatBtnWithFrame:(CGRect)fraqme bgImgeStr:(NSString *)bgImgStr title:(NSString *)title font:(UIFont *)font titleColor:(UIColor*)titleColor btnType:(ButtonType)btnType{
    SSKJ_baseBtn *btn = [SSKJ_baseBtn buttonWithType:UIButtonTypeCustom];
    
    NSString *disableImgStr = @"";
    if (btnType == ButtonType_Default) {
        if (bgImgStr.length == 0) {
               bgImgStr = @"baseBgBtnImge";
           }
        disableImgStr = @"disableImgStr";
    }else if (btnType == ButtonType_Radius){
        if (bgImgStr.length == 0) {
            bgImgStr = @"bgCornerBtnImge";
        }
    }else if (btnType == ButtonType_Border){
        btn.layer.borderColor = [UIColor blackColor].CGColor;
    }
    btn.layer.borderWidth = ScaleW(1);
    btn.layer.cornerRadius = ScaleW(5);
    
    [btn setFrame:fraqme];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:bgImgStr] forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:disableImgStr] forState:UIControlStateDisabled];
    btn.backgroundColor = [UIColor clearColor];
    
    return btn;
}










@end
