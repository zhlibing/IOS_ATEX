//
//  UILabel+WJUI.m
//  WJShaSengProject
//
//  Created by James on 2018/12/7.
//  Copyright © 2018年 JamesWu. All rights reserved.
//

#import "UILabel+WJFUN.h"
#import <objc/runtime.h>
@implementation UILabel (WJFUN)


- (void)text:(NSString *)str color:(UIColor *)color font:(UIFont *)font
{
    if (!str)
        str = self.text;
    if (!color)
        color = self.textColor;
    if (!font)
        font = self.font;
    [self.attributeString setAttributes:@{NSForegroundColorAttributeName:color,
                                          NSFontAttributeName:font}
                                  range:[self.text rangeOfString:str]];
    
    self.attributedText = self.attributeString;
}

- (NSMutableAttributedString *)attributeString
{
    NSMutableAttributedString *attributeString = objc_getAssociatedObject(self, _cmd);
    if (attributeString && [attributeString.string isEqualToString:self.text]) {
        return attributeString;
    }
    attributeString = [[NSMutableAttributedString alloc] initWithString:self.text];
    objc_setAssociatedObject(self, _cmd, attributeString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return attributeString;
}

+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    if (label.attributedText) {
        attributedString=[label.attributedText mutableCopy];
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [paragraphStyle setAlignment:label.textAlignment];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    if (label.attributedText) {
        attributedString=[label.attributedText mutableCopy];
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:label.textAlignment];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    if (label.attributedText) {
        attributedString=[label.attributedText mutableCopy];
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [paragraphStyle setAlignment:label.textAlignment];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

- (CGSize)contentSize
{
    return [self textSizeIn:self.bounds.size];
}

- (CGSize)textSizeIn:(CGSize)size
{
    NSLineBreakMode breakMode = self.lineBreakMode;
    UIFont *font = self.font;
    CGSize contentSize = CGSizeZero;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = breakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    NSDictionary* attributes = @{NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle};
    contentSize = [self.text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    contentSize = CGSizeMake((int)contentSize.width + 1, (int)contentSize.height + 1);
    return contentSize;
}

@end

@implementation WJCustomInsetLabel

- (void)drawTextInRect:(CGRect)rect{
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _contentInset)];
}

- (CGSize)contentSize{
    CGRect rect = UIEdgeInsetsInsetRect(self.bounds, _contentInset);
    CGSize size = [super textSizeIn:rect.size];
    return CGSizeMake(size.width + _contentInset.left + _contentInset.right, size.height + _contentInset.top + _contentInset.bottom);
}

- (CGSize)textSizeIn:(CGSize)size{
    size.width -= _contentInset.left + _contentInset.right;
    size.height -= _contentInset.top + _contentInset.bottom;
    CGSize textSize = [super textSizeIn:size];
    return CGSizeMake(textSize.width + _contentInset.left + _contentInset.right, textSize.height + _contentInset.top + _contentInset.bottom);
}
@end
