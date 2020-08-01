//
//  BFEXMoneyEdtingTableViewCell.m
//  ZYW_MIT
//
//  Created by 张本超 on 2018/7/17.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Mine_AddressList_TableViewCell.h"


@interface Mine_AddressList_TableViewCell()

@property (nonatomic, strong) UIView *contView;
//描述
@property (nonatomic, strong) UILabel *descrptionLabel;
//地址
@property (nonatomic, strong) UILabel *addressLabel;
//删除
@property (nonatomic, strong) UIButton *deleBtn;
@end
@implementation Mine_AddressList_TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kBgColor;
        [self viewConfig];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)viewConfig
{
    [self contView];
}

-(UIView *)contView{
    if (!_contView) {
        _contView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth - ScaleW(30), ScaleW(84))];
        _contView.backgroundColor = kSubBgColor;
        [self.contentView addSubview:_contView];
        [_contView addSubview:self.deleBtn];
        [_contView addSubview:self.descrptionLabel];
        [_contView addSubview:self.addressLabel];
        
    }
    return _contView;
}
-(UIButton *)deleBtn{
    if (!_deleBtn) {
        _deleBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.contView.width - ScaleW(15) - ScaleW(40), 0, ScaleW(40), ScaleW(40))];
        [_deleBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        _deleBtn.centerY = self.descrptionLabel.centerY;
        [_deleBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleBtn;
}

-(void)deleteAction
{
    if (self.deleBlock) {
        self.deleBlock();
    }
}
-(UILabel *)descrptionLabel{
    if (!_descrptionLabel) {
        _descrptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(26), ScaleW(200), ScaleW(15))];
        _descrptionLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView label:_descrptionLabel font:ScaleW(15) textColor:kTitleColor text:@"-----"];
        
    }
    return _descrptionLabel;
}

-(UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.descrptionLabel.x, self.descrptionLabel.bottom + ScaleW(18), self.contView.width - ScaleW(30), ScaleW(12))];
        _addressLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView label:_addressLabel font:ScaleW(12) textColor:kSubTitleColor text:@"----"];
    }
    return _addressLabel;
}

-(void)setValueWithData:(ExtractAddress_IndexModel *)model
{
    self.descrptionLabel.text = model.notes;
    self.addressLabel.text = model.address;
}

@end
