//
//  Nodata_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/15.
//  Copyright © 2019年 James. All rights reserved.
//

#import "Nodata_Cell.h"

@interface Nodata_Cell ()
@property (nonatomic, strong) UIImageView *nodataImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation Nodata_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.nodataImageView];
    [self addSubview:self.titleLabel];
}

-(UIImageView *)nodataImageView
{
    if (nil == _nodataImageView) {
        _nodataImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScaleW(50), ScaleW(187), ScaleW(144))];
        _nodataImageView.centerX = ScreenWidth / 2;
        _nodataImageView.image = [UIImage imageNamed:@"public_noData"];
    }
    return _nodataImageView;
    
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"暂无记录",nil) font:systemFont(ScaleW(13)) textColor:kBlueColor frame:CGRectMake(0, self.nodataImageView.bottom + ScaleW(20), ScreenWidth, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(void)setCellWithTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
