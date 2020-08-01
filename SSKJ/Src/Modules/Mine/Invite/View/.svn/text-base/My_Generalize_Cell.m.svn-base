//
//  My_Generalize_Cell.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Generalize_Cell.h"

@interface My_Generalize_Cell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *enterImageView;
@end

@implementation My_Generalize_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    [self addSubview:self.titleLabel];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor =kLineColor;
    

    [self.contentView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(ScaleW(15));
        make.right.equalTo(self.contentView).offset(ScaleW(15));

        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
 
    
    
//    [self addSubview:self.enterImageView];
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), 0, ScaleW(200), ScaleW(55)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UIImageView *)enterImageView
{
    if (nil == _enterImageView) {
        _enterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(7.5), 0, ScaleW(7.5), ScaleW(13))];
        _enterImageView.image = [UIImage imageNamed:@"enter_icon"];
        _enterImageView.centerY = ScaleW(27.5);
    }
    return _enterImageView;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
