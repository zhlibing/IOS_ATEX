


//
//  SSKJ_baseTableViewCell.m
//  SSKJ
//
//  Created by mac on 2019/12/7.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SSKJ_baseTableViewCell.h"

@implementation SSKJ_baseTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addChildrenViews];
    }
    return self;
}


- (void) addChildrenViews{
    [self.contentView addSubview:self.bgView];
}




- (void)layoutSubviews{
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScaleW(0));
        make.bottom.mas_equalTo(self.contentView).offset(ScaleW(0));
        make.left.mas_equalTo(self.contentView).offset(ScaleW(0));
        make.right.mas_equalTo(self.contentView).offset(ScaleW(0));
    }];
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = kBgColor;
        _bgView.layer.cornerRadius = ScaleW(0);
        _bgView.layer.shadowColor = kLineColor.CGColor;
        _bgView.layer.shadowOffset = CGSizeMake(0, 0);
        _bgView.layer.shadowRadius = ScaleW(0);
        _bgView.layer.shadowOpacity = 0.0;
    }
    return _bgView;
}


@end
