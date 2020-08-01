//
//  Market_Notice_Cell.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/4/26.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "Home_Notice_Cell.h"

@interface Home_Notice_Cell()

@property (nonatomic,strong) UIImageView * leftImg;
@property (nonatomic,strong) UIImageView * rightImg;

@property (nonatomic,strong) UILabel * titleLabel;

@end

@implementation Home_Notice_Cell


#pragma mark - 初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.contentView.backgroundColor=kSubBgColor;
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [self leftImg];
        [self rightImg];

        [self titleLabel];
        
        [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.mas_equalTo(ScaleW(15));
            make.width.mas_equalTo(ScaleW(6));
            make.height.mas_equalTo(ScaleW(6));
            
        }];
        [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(self);
           make.right.mas_equalTo(ScaleW(-15));
                   
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(ScaleW(21)));
            make.left.equalTo(self.leftImg.mas_right).offset(ScaleW(15));
            make.right.equalTo(self.rightImg.mas_left).offset(-ScaleW(15));
            make.height.mas_equalTo(ScaleW(14));
            make.bottom.mas_equalTo(self.mas_bottom).offset(-ScaleW(21));
        }];
       
    }
    
    return self;
}

- (UIImageView *)leftImg{
    if (_leftImg == nil) {
        UIImage *image = [UIImage imageNamed:@"Market_Notice_img"];
        _leftImg = [[UIImageView alloc]initWithImage:image];
        _leftImg.layer.masksToBounds = YES;
        _leftImg.backgroundColor = kTitleColor;
        _leftImg.layer.cornerRadius = ScaleW(3);
        [self.contentView addSubview:_leftImg];

    }
    return _leftImg;
}

- (UIImageView *)rightImg{
    if (_rightImg == nil) {
        UIImage *image = [UIImage imageNamed:@"mine_next"];
        _rightImg = [[UIImageView alloc]initWithImage:image];
        [self.contentView addSubview:_rightImg];

    }
    return _rightImg;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [WLTools allocLabel:@"标题" font:systemFont(14) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_titleLabel];
  
    }
    return _titleLabel;
}

- (void)initDataWithModel:(Home_NoticeIndex_Model *)Model
{    
    self.titleLabel.text = Model.title;
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
