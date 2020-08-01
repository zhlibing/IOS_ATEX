//
//  MineTableCell.m
//  SSKJ
//
//  Created by apple on 2019/8/16.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "MineTableCell.h"

@implementation MineTableCell
{
    UIImageView *_iconImg;
    
    UILabel *_titleLabel;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self configUI];
        
    }
    return self;
    
}

-(void)configUI{
    
    
    _iconImg=[UIImageView new];
    _iconImg.contentMode = UIViewContentModeScaleAspectFill;
    
    _titleLabel=[UILabel new];
    
    UIView *lineView=[UIView new];
    
    UIImageView *rightImg=[UIImageView new];

    [self.contentView addSubview:_iconImg];
    
    [self.contentView addSubview:_titleLabel];
    
    [self.contentView addSubview:lineView];
    
    [self.contentView addSubview:rightImg];
    
    
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(ScaleW(17));
        
        make.centerY.equalTo(self.contentView);
        
        make.width.mas_equalTo(ScaleW(17));
        
        make.height.mas_equalTo(ScaleW(17));
        
        
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_iconImg.mas_right).offset(ScaleW(15));
        
        make.centerY.equalTo(self->_iconImg);
        
        make.width.mas_equalTo(ScaleW(150));
        
        make.height.mas_equalTo(ScaleW(14));
        
        
    }];
    
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.contentView);
        
        make.bottom.equalTo(self.contentView);
        
        make.height.mas_equalTo(0.5);
        
    }];
    
    
    [rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-ScaleW(20));
        
        make.height.mas_equalTo(ScaleW(11));
        make.width.mas_equalTo(ScaleW(7));
        make.centerY.equalTo(self->_iconImg);


    }];
    
    _iconImg.backgroundColor=[UIColor clearColor];
    
    _titleLabel.textColor=kTitleColor;
    
    _titleLabel.font=systemFont(ScaleW(14));
    
    [rightImg setImage:[UIImage imageNamed:@"root_next"]];
    
    lineView.backgroundColor=kLineColor;
    
    
    _subTitleLabel = [UILabel createWithText:@"" textColor:kSubTitleColor font:kFont(14)];
    [self.contentView addSubview:_subTitleLabel];
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(rightImg.mas_left).offset(ScaleW(-10));
    }];
    self.subTitleLabel.hidden = YES;

}

-(void)setDataWithDict:(NSDictionary *)dict{
    
    [_iconImg setImage:[UIImage imageNamed:dict[@"icon"]]];
    
    _titleLabel.text=SSKJLocalized([dict objectForKey:@"title"], nil);
}

@end
