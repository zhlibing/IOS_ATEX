//
//  Heyue_root_leverage_View.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/26.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_root_leverage_View.h"

@interface Heyue_root_leverage_View()

@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,strong) UILabel *countTitle;//杠杆倍数
@property (nonatomic,strong) UILabel *timeTitle;
@property (nonatomic,strong) UIImageView *pullImage;//杠杆数

@end

@implementation Heyue_root_leverage_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBgColor;
        self.layer.borderColor = kLineColor.CGColor;
        self.layer.borderWidth = .5f;
        self.cornerRadius = ScaleW(4);
        [self createUI];
       
    }
    return self;
}

- (void)createUI{
    
    [self addSubview:self.countTitle];
    [self addSubview:self.showTitle];
    [self addSubview:self.pullImage];

    [self.countTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(ScaleW(5));
        make.width.equalTo(@(ScaleW(70)));
    }];
    [self.showTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.countTitle.mas_right).offset(ScaleW(5));
//        make.right.equalTo(self.mas_right).offset(ScaleW(-35));
    }];
    [self.pullImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(ScaleW(12), ScaleW(7)));
        make.right.equalTo(self.mas_right).offset(ScaleW(-19));
    }];
}

- (void)setDesTitle:(NSString *)desTitle {
    _desTitle = desTitle;
    self.countTitle.text = SSKJLanguage(desTitle);
}

- (void)setIsTime:(BOOL)isTime {
    _isTime = isTime;
    if (isTime) {
        [self addSubview:self.timeTitle];
        [self.timeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.showTitle.mas_right).offset(ScaleW(5));
//            make.right.equalTo(self.mas_right).offset(ScaleW(-35));
        }];
    }
}
- (UILabel *)countTitle{
    if (_countTitle == nil) {
        _countTitle= [WLTools allocLabel:SSKJLocalized(@"杠杆倍数", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(self.width - ScaleW(40), 0, ScaleW(40), ScaleW(40)) textAlignment:NSTextAlignmentCenter];
        _countTitle.adjustsFontSizeToFitWidth = YES;
        _countTitle.numberOfLines = 1;
    }
    return _countTitle;
}

- (UILabel *)showTitle{
    if (_showTitle == nil) {
        _showTitle= [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.width - ScaleW(40), 0, ScaleW(40), ScaleW(40)) textAlignment:NSTextAlignmentLeft];
        _showTitle.adjustsFontSizeToFitWidth = YES;
        _countTitle.numberOfLines = 1;
    }
    return _showTitle;
}

- (UILabel *)timeTitle{
    if (_timeTitle == nil) {
        _timeTitle= [WLTools allocLabel:SSKJLocalized(@"分钟", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.showTitle.right + ScaleW(5), 0, ScaleW(40), ScaleW(40)) textAlignment:NSTextAlignmentCenter];
        _timeTitle.adjustsFontSizeToFitWidth = YES;
        _timeTitle.numberOfLines = 1;
    }
    return _timeTitle;
}

- (UIImageView *)pullImage{
    if (_pullImage == nil) {
        _pullImage = [[UIImageView alloc] init];
        _pullImage.image = [UIImage imageNamed:@"hy_down_gray"];
    }
    return _pullImage;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
