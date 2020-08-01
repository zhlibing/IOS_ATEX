//
//  ChangeLanguage_TableViewCell.m
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/15.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "ChangeLanguage_TableViewCell.h"

@interface ChangeLanguage_TableViewCell ()
@property (nonatomic, strong) UILabel *languageLabel;
@property (nonatomic, strong) UIButton *selectBtn;
@end

@implementation ChangeLanguage_TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kBgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.languageLabel];
        [self addSubview:self.selectBtn];
    }
    return self;
}

-(UILabel *)languageLabel
{
    if (nil == _languageLabel) {
        _languageLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), 0, ScaleW(200), ScaleW(50)) textAlignment:NSTextAlignmentLeft];
    }
    return _languageLabel;
}

-(UIButton *)selectBtn
{
    if (nil == _selectBtn) {
        _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(45), 0, ScaleW(45), ScaleW(40))];
        _selectBtn.centerY = self.languageLabel.centerY;
        [_selectBtn setImage:[UIImage imageNamed:@"lan_select"] forState:UIControlStateNormal];
        _selectBtn.userInteractionEnabled = NO;
    }
    return _selectBtn;
}

-(void)setTitle:(NSString *)title andSelected:(BOOL)isSelected
{
    self.languageLabel.text = title;
    self.selectBtn.hidden = !isSelected;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
