//
//  BISecurityCenterTableViewCell.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BISecurityCenterTableViewCell.h"



@interface BISecurityCenterTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel; //!< 标题
@property (nonatomic, strong) UILabel *describeLabel; //!< 描述
@property (nonatomic, strong) UIImageView *accessoryImageView; //!< 附件
@property (nonatomic, strong) BISecuritySwitchControl *switchControl; //!< 开关
@property (nonatomic, strong) BISecuritySwitchControl *editControl; //!< 编辑
@property (nonatomic, strong) UIView *lineView; //!< 分割线

@property (nonatomic,weak) id <BISecurityCenterTableViewCellDelegate> delegate;




@end




@implementation BISecurityCenterTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.contentView setBackgroundColor:kBgColor];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.describeLabel];
        [self.contentView addSubview:self.accessoryImageView];
        [self.contentView addSubview:self.switchControl];
        [self.contentView addSubview:self.editControl];
        [self.contentView addSubview:self.lineView];
        
        
        [self setItemColor:NO];
    }
    return self;
}


-(void)setDelegate:(id<BISecurityCenterTableViewCellDelegate>)delegate withIndexPath:(NSInteger)indexPath
{
    [self setDelegate:delegate];
    [self.switchControl setTag:indexPath];
}



#pragma mark 点击编辑按钮触发事件
-(void)editBtnAction:(BISecuritySwitchControl*)sender
{
    if ([self.delegate respondsToSelector:@selector(editBtnAction:)])
    {
        [self.delegate editBtnAction:sender];
    }
}


#pragma mark 点击开关按钮触发事件
-(void)switchControlAction:(BISecuritySwitchControl *)sender
{
    if ([self.delegate respondsToSelector:@selector(switchControlAction:)])
    {
        [self.delegate switchControlAction:sender];
    }
}




-(void)setModel:(BISecurityCenterModel *)model
{
    #pragma mark 先设置所有未隐藏状态
    {
        [self.titleLabel setHidden:YES];
        [self.describeLabel setHidden:YES];
        [self.switchControl setHidden:YES];
        [self.editControl setHidden:YES];
        [self.accessoryImageView setHidden:YES];
        [self.describeLabel setTextAlignment:NSTextAlignmentRight];
    }
    _model = model;
    switch (model.modelType)
    {
        #pragma mark case BISecurityCenterModelNormalType 普通
        case BISecurityCenterModelNormalType:
        {
            {
                [self.titleLabel setHidden:NO];
                [self.describeLabel setHidden:NO];
                [self.accessoryImageView setHidden:NO];
            }
            
            [self.titleLabel setFrame:CGRectMake(ScaleW(10), 0, ScaleW(120), model.height)];
            [self.describeLabel setFrame:CGRectMake(self.titleLabel.right,self.titleLabel.top,ScreenWidth-(ScaleW(155)) , self.titleLabel.height)];
            [self.accessoryImageView setFrame:CGRectMake(ScreenWidth-20, (self.titleLabel.height-ScaleW(15.0))/2.0,ScaleW(15), ScaleW(15))];
            [self.lineView setFrame:CGRectMake(self.titleLabel.left, model.height-ScaleW(0.5), ScreenWidth-ScaleW(20), ScaleW(0.5))];
            
            
            
            //!< 重置属性
            [self.describeLabel setFont:systemFont(14.0)];
            
            //!< 赋值
            [self.titleLabel setText:SSKJLocalized(model.title, nil)];
            [self.describeLabel setText:SSKJLocalized(model.describe, nil)];
            [self.accessoryImageView setImage:[UIImage imageNamed:@"Mine_jiantou_right"]];
        }
            break;
        #pragma mark case BISecurityCenterModelSwitchType 开关
        case BISecurityCenterModelSwitchType:
        {
            [self.switchControl setModel:model];
            {
                [self.titleLabel setHidden:NO];
                [self.describeLabel setHidden:NO];
                [self.switchControl setHidden:NO];
                [self.accessoryImageView setHidden:NO];
            }
            
            [self.titleLabel setFrame:CGRectMake(ScaleW(10), 0, ScaleW(120), model.height)];
            [self.describeLabel setFrame:CGRectMake(self.titleLabel.right,self.titleLabel.top,ScreenWidth-(ScaleW(155)) , self.titleLabel.height)];
            [self.switchControl resetFrame:CGRectMake(ScreenWidth-ScaleW(100),0,(ScaleW(100)) , model.height)];
            [self.switchControl setImageEdge:CGRectMake(30, (model.height-ScaleW(20))/2.0, 50, ScaleW(20))];
            
            
            [self.accessoryImageView setFrame:CGRectMake(ScreenWidth-20, (self.titleLabel.height-ScaleW(15.0))/2.0,ScaleW(15), ScaleW(15))];
            [self.lineView setFrame:CGRectMake(self.titleLabel.left, model.height-ScaleW(0.5), ScreenWidth-ScaleW(20), ScaleW(0.5))];
            
            
            //!< 重置属性
            [self.describeLabel setFont:systemFont(ScaleW(14.0))];
            [self.describeLabel setTextAlignment:NSTextAlignmentRight];
            
            //!< 赋值
            [self.titleLabel setText:SSKJLocalized(model.title, nil)];
            [self.describeLabel setText:SSKJLocalized(model.describe, nil)];
            
            [self.accessoryImageView setImage:[UIImage imageNamed:@"Mine_jiantou_right"]];
            
            
            switch (model.authType)
            {
                case BISecurityCenterNOAuthType:
                {
                    [self.describeLabel setHidden:NO];
                    [self.switchControl setHidden:YES];
                    [self.accessoryImageView setHidden:NO];
                }
                    break;
                case BISecurityCenterAuthType:
                {
                    [self.describeLabel setHidden:YES];
                    [self.switchControl setHidden:NO];
                    [self.accessoryImageView setHidden:YES];
                    
                }
                    break;
            }
            
            switch (model.switchType)
            {
                case BISecurityCenterOnType:
                {
                    [self.switchControl setImage:@"Mine_switch_on"];
                }
                    break;
                case  BISecurityCenterOffType:
                {
                   [self.switchControl setImage:@"lightning_mine_off"];
                    
                }
                    break;
            }
        }
            break;
        #pragma mark case BISecurityCenterModelSectionType 分区
        case BISecurityCenterModelSectionType:
        {
            [self.lineView setFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(10))];
        }
            break;
        #pragma mark case BISecurityCenterModelTipType 提示
        case BISecurityCenterModelTipType:
        {
            {
                [self.titleLabel setHidden:NO];
                [self.describeLabel setHidden:NO];
            }
            [self.titleLabel setFrame:CGRectMake(ScaleW(10), ScaleW(20), ScreenWidth-ScaleW(20), ScaleW(20))];
            [self.describeLabel setFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+ScaleW(10), self.titleLabel.width, ScaleW(50))];
            [self.lineView setFrame:CGRectMake(self.titleLabel.left, model.height-ScaleW(0.5), ScreenWidth-ScaleW(20), ScaleW(0.5))];
            
            //!< 重置Frame
            [self.describeLabel setTextColor:kTitleColor];
            [self.describeLabel setFont:systemFont(ScaleW(12.0))];
            [self.describeLabel setTextAlignment:NSTextAlignmentLeft];
            
            //!< 赋值
            [self.titleLabel setText:SSKJLocalized(model.title, nil)];
            [self.describeLabel setText:SSKJLocalized(model.describe, nil)];
        }
            break;
        #pragma mark case BISecurityCenterModelPaymentType 支付方式
        case BISecurityCenterModelPaymentType:
        {
            [self.switchControl setModel:model];
            {
                [self.titleLabel setHidden:NO];
                [self.describeLabel setHidden:NO];
                [self.switchControl setHidden:NO];
                [self.editControl setHidden:NO];
                [self.lineView setHidden:YES];
                [self.accessoryImageView setHidden:NO];
            }
            
            [self.accessoryImageView setFrame:CGRectMake(ScaleW(10), ScaleW(25), ScaleW(40), ScaleW(40))];
            [self.accessoryImageView setLayerCornerRadius:(self.accessoryImageView.height/2.0)];
            [self.titleLabel setFrame:CGRectMake(self.accessoryImageView.right+ScaleW(20), self.accessoryImageView.top, ScreenWidth - ScaleW(210), ScaleW(40))];
            [self.describeLabel setFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom, ScreenWidth-ScaleW(50+40), ScaleW(40))];
            [self.switchControl resetFrame:CGRectMake(ScreenWidth-ScaleW(70), self.titleLabel.top, ScaleW(70), ScaleW(40))];
            [self.switchControl setImageEdge:CGRectMake(ScaleW(10), ScaleW(10), ScaleW(50), ScaleW(20))];
            [self.editControl resetFrame:CGRectMake(ScreenWidth-ScaleW(130), self.titleLabel.top, ScaleW(60), self.titleLabel.height)];
            [self.editControl setTitleEdge:CGRectMake(0, 0, self.editControl.width, self.editControl.height)];
            
            switch (model.switchType)
            {
                case BISecurityCenterOffType:
                {
                    [self.switchControl setImage:@"lightning_mine_off"];
                }
                    break;
                case BISecurityCenterOnType:
                {
                    [self.switchControl setImage:@"Mine_switch_on"];
                }
                    break;
            }
            
            
            //!< 重置属性
            [self.describeLabel setTextColor:kTitleColor];
            [self.describeLabel setFont:systemFont(ScaleW(12.0))];
            [self.describeLabel setTextAlignment:NSTextAlignmentLeft];
            
            
            switch (model.paymentType)
            {
                case BISecurityCenterWeiXinType:
                {
                    [self.accessoryImageView setImage:[UIImage imageNamed:@"Mine_weixin"]];
                }
                    break;
                case BISecurityCenterAliPayType:
                {
                    [self.accessoryImageView setImage:[UIImage imageNamed:@"Mine_alipay"]];
                }
                    break;
                case BISecurityCenterBankCardType:
                {
                    [self.accessoryImageView setImage:[UIImage imageNamed:@"Mine_bank"]];
                }
                    break;
            }
            
            //!< 赋值
            [self.titleLabel setText:SSKJLocalized(model.title, nil)];
            [self.describeLabel setText:[NSString stringWithFormat:@"%@   %@",model.describe,model.account]];
            ;
        
        }
            break;
    }
    
    
    
}




#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kTitleColor font:systemFont(ScaleW(16))];
    }
    return _titleLabel;
}


-(UILabel *)describeLabel
{
    if (!_describeLabel)
    {
        _describeLabel = [[UILabel alloc]init];
        [_describeLabel setTextAlignment:NSTextAlignmentRight];
        [_describeLabel setTextColor:kSubTitleColor];
        [_describeLabel setNumberOfLines:0];
    }
    return _describeLabel;
}


-(UIImageView *)accessoryImageView
{
    if (!_accessoryImageView)
    {
        _accessoryImageView = [[UIImageView alloc]init];
        [_accessoryImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _accessoryImageView;
}


-(BISecuritySwitchControl *)switchControl
{
    if (!_switchControl)
    {
        _switchControl = [[BISecuritySwitchControl alloc]init];
        [_switchControl addTarget:self action:@selector(switchControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchControl;
}

- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:kBgColor];
    }
    return _lineView;
}


-(BISecuritySwitchControl *)editControl
{
    if (!_editControl)
    {
        _editControl = [[BISecuritySwitchControl alloc]init];
        [_editControl setTitle:@"修改"];
        [_editControl setFont:systemFont(ScaleW(14))];
        [_editControl setTextColor:kBlueColor];
        [_editControl setTextAlignment:NSTextAlignmentRight];
        [_editControl addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editControl;
}



-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.titleLabel setBackgroundColor:[UIColor orangeColor]];
        [self.describeLabel setBackgroundColor:[UIColor purpleColor]];
        [self.accessoryImageView setBackgroundColor:[UIColor redColor]];
        [self.switchControl setBackgroundColor:[UIColor yellowColor]];
        [self.editControl setBackgroundColor:[UIColor redColor]];
    }
}

@end
