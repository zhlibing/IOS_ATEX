//
//  Heyue_Nodata_Cell.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/8/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_Nodata_Cell.h"

@interface Heyue_Nodata_Cell()

@property (nonatomic,strong) UIImageView *nodataImgV;

@property (nonatomic,strong) UILabel *noDataLabel;

@end

@implementation Heyue_Nodata_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView setBackgroundColor:kBgColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.nodataImgV];
        [self.contentView addSubview:self.noDataLabel];
        [self setUIFrame];
    }
    return self;
}

- (void)setUIFrame{
    UIImage *image = [UIImage imageNamed:@"public_noData"];
    [self.nodataImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ScaleW(image.size.width)));
        make.height.equalTo(@(ScaleW(image.size.height)));
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.nodataImgV.mas_bottom).offset(ScaleW(10));
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
}

- (UIImageView *)nodataImgV{
    if (_nodataImgV == nil) {
        _nodataImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"public_noData"]];
    }
    return _nodataImgV;
}

- (UILabel *)noDataLabel{
    if (_noDataLabel == nil) {
        _noDataLabel = [WLTools allocLabel:SSKJLocalized(@"暂无记录", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(0, self.nodataImgV.bottom + ScaleW(15), ScreenWidth, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
    }
    return _noDataLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
