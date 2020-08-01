//
//  SSKJ_AreaCode_View.m
//  SSKJ
//
//  Created by zpz on 2019/9/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_AreaCode_View.h"

@interface SSKJ_AreaCode_View()

@property(nonatomic, strong)UIButton *bgButton;
@property(nonatomic, strong)UIImageView *imageV;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIImageView *iconImageV;

@property(nonatomic, strong)UIColor *fontColor;

@property(nonatomic, strong)NSArray *areaArray;

@end

@implementation SSKJ_AreaCode_View



- (instancetype)initWithColor:(UIColor *)color{
    if (self = [super init]) {
        self.fontColor = color;
        [self setupUI];
    }
    return self;
}


- (void)setupUI{
    
    [self titleLabel];
    [self imageV];
    [self iconImageV];
    
    UIView *line = [UIView new];
    line.backgroundColor = kLineColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@(ScaleW(0.5)));
        make.bottom.equalTo(@0);
    }];
    
    self.bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.bgButton];
    [self.bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(@0);
    }];
    [self.bgButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    _areaArray = [SSKJ_AreaCode_Model mj_objectArrayWithKeyValuesArray:[SSTool getAreaCode]];
    
    if (!_areaArray.count) {
        SSKJ_AreaCode_Model *model = [SSKJ_AreaCode_Model new];
        model.areaName = @"中国";
        model.areaCode = @"+86";
        _areaArray = @[model];
    }
    
    SSKJ_AreaCode_Model *model = _areaArray.firstObject;
    self.titleLabel.text = model.areaName;
}



- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLanguage(@"中国") font:kFont(16) textColor:self.fontColor frame:CGRectZero textAlignment:(NSTextAlignmentLeft)];
        [self addSubview:_titleLabel];
        
//        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@(ScaleW(40)));
//            make.centerY.equalTo(@0);
//        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(0)));
            make.centerY.equalTo(@0);
        }];
    }
    return _titleLabel;
}

- (UIImageView *)imageV{
    if (_imageV == nil) {
        _imageV = [WLTools allocImageView:CGRectZero image:[UIImage imageNamed:@"login_area"]];
        [self addSubview:_imageV];
        
//        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.mas_left).offset(ScaleW(15));
//            make.centerY.equalTo(@0);
//        }];
    }
    return _imageV;
}


- (UIImageView *)iconImageV{
    if (_iconImageV == nil) {
        _iconImageV = [WLTools allocImageView:CGRectZero image:[UIImage imageNamed:@"login_down"]];
        [self addSubview:_iconImageV];
        
        [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(ScaleW(-15));
            make.centerY.equalTo(@0);
        }];
    }
    return _iconImageV;
}

- (void)click{
    
    NSMutableArray *arr = [NSMutableArray array];
    for (SSKJ_AreaCode_Model *model in self.areaArray) {
        [arr addObject:model.areaName];
    }
    
    WS(weakSelf);
    [SSKJ_Default_ActionsheetView showWithItems:arr title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
        
        SSKJ_AreaCode_Model *model = weakSelf.areaArray[selectIndex];
        weakSelf.titleLabel.text = model.areaName;

    } cancleBlock:^{
        
    }];
}

- (NSString *)getCode{
    
    NSString *areacode;
    for (SSKJ_AreaCode_Model *model in self.areaArray) {
        if ([self.titleLabel.text isEqualToString:model.areaName]) {
            areacode = model.areaCode;
            break;
        }
    }
    return [areacode stringByReplacingOccurrencesOfString:@"+" withString:@""];
}
@end


@implementation SSKJ_AreaCode_Model
@end
