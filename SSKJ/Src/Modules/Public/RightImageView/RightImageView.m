//
//  RightImageView.m
//  SSKJ
//
//  Created by zpz on 2019/11/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "RightImageView.h"
@interface RightImageView()
@property(nonatomic, strong)UIButton *bgBtn;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIImageView *imageV;
@end

@implementation RightImageView

- (instancetype)initWithWithTitle:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font Img:(NSString *)img space:(CGFloat)space target:(id)target action:(SEL)action{
    self = [super init];
    if (self) {
        self.titleLabel = [UILabel createWithText:title textColor:color font:font];
        [self addSubview:self.titleLabel];
        
        self.imageV = [[UIImageView alloc] initWithImage:UIImageNamed(img)];
        [self addSubview:self.imageV];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.bottom.equalTo(@0);
        }];
        
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.right.equalTo(@0);
            make.left.equalTo(self.titleLabel.mas_right).offset(space);
            make.width.mas_equalTo(ScaleW(6.5));
            make.height.mas_equalTo(ScaleW(3.5));
        }];
        
        self.bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.bgBtn];
        [self.bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(@0);
        }];
        [self.bgBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}

@end
