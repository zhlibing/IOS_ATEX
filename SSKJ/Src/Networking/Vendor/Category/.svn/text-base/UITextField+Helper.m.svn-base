//
//  UITextField+Helper.m
//  SiLuTianYu
//
//  Created by apple on 16/4/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UITextField+Helper.h"
#import <objc/runtime.h>
static const void *kmaxlen = "maxlen";
@interface UITextField()
@property(nonatomic,copy) NSString *maxlen;
@end
@implementation UITextField(Helper)
-(void)setMaxlen:(NSString *)maxlen{
     objc_setAssociatedObject(self, kmaxlen, maxlen, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)maxlen{
    
    return objc_getAssociatedObject(self, kmaxlen);
}
-(void)setMaxLength:(NSInteger)maxlength{
    self.maxlen=[NSString stringWithFormat:@"%@",@(maxlength)];
    [self addTarget:self action:@selector(TextFieldChange:) forControlEvents:UIControlEventEditingChanged];
}
-(void)TextFieldChange:(UITextField *)obj{
    UITextField *NameText=(UITextField *)obj;
    NSInteger _maxlength=[self.maxlen integerValue];
    NSString *toBeString = NameText.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [NameText markedTextRange];
        //获取高亮部分
        UITextPosition *position = [NameText positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > _maxlength) {
                NameText.text = [toBeString substringToIndex:_maxlength];
            }
        }
        else{
            
        }
    }
    else{
        if (toBeString.length > _maxlength) {
            NameText.text = [toBeString substringToIndex:_maxlength];
        }
    }

}
-(BOOL)textFieldShouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string dotNumber:(NSInteger)dotnumber{
    if (self.keyboardType == UIKeyboardTypeDecimalPad) {
  
        BOOL isHaveDian = YES;
        if ([self.text rangeOfString:@"."].location==NSNotFound) {
            isHaveDian=NO;
        }
        if ([string length]>0)
        {
            unichar single=[string characterAtIndex:0];//当前输入的字符
            if ((single >='0' && single<='9') || single=='.')//数据格式正确
            {
                //首字母不能为0和小数点
                if([self.text length]==0){
                    if(single == '.'){
                    [self.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    }
//                    if (single == '0') {
//                        
//                        [self.text stringByReplacingCharactersInRange:range withString:@""];
//                        return NO;
//                        
//                    }
                }
                if (single=='.')
                {
                    if(!isHaveDian)//text中还没有小数点
                    {
                        isHaveDian=YES;
                        return YES;
                    }else
                    {
                        [self.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                else
                {
                    if (isHaveDian)//存在小数点
                    {
                        //判断小数点的位数
                        NSRange ran=[self.text rangeOfString:@"."];
                        NSInteger tt=range.location-ran.location;
                        if (tt <= dotnumber){
                            return YES;
                        }else{
                            return NO;
                        }
                    }
                    else
                    {
                        return YES;
                    }
                }
            }else{//输入的数据格式不正确
                [self.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else
        {
            return YES;  
        }  

    }
      return YES;
}

/*-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    NSString *string=pasteboard.string;
    if (action == @selector(paste:) && ((self.keyboardType==UIKeyboardTypeNumberPad || self.keyboardType==UIKeyboardTypeDecimalPad || self.keyboardType==UIKeyboardTypePhonePad))) {
     return NO;
   }
    return YES;
}*/
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
