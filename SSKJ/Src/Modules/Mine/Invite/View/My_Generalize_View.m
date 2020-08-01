//
//  My_Generalize_View.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Generalize_View.h"
#import "MyButton.h"
@interface My_Generalize_View ()

@property (nonatomic, strong) UIImageView *headerImageView;

@property (nonatomic, strong) UILabel *kehuTitleLabel;
@property (nonatomic, strong) UILabel *kehuNumberLabel;

//@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *todayIncomeTitleLabel;
@property (nonatomic, strong) UILabel *todayIncomeLabel;

@property (nonatomic, strong) UILabel *totalIncomeTitleLabel;
@property (nonatomic, strong) UILabel *totalIncomeLabel;
@property (nonatomic, strong) NSMutableArray *numArray;

@end

@implementation My_Generalize_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = kSubBgColor;
        [self addNewUI];
    }
    return self;
}
-(void)addNewUI{
 
     [self addSubview:self.headerImageView];
    CGFloat space=ScaleW(15);
    
    CGFloat height=ScaleW(17);
    
    CGFloat topSpace=ScaleW(30);
    
    CGFloat width=(ScreenWidth-4*space)/3.0;
    
    _numArray=[NSMutableArray new];
    
    
    NSArray *array=@[SSKJLocalized(@"今日返佣(USDT)", nil)
                     ,SSKJLocalized(@"昨日返佣(USDT)", nil)
                     ,SSKJLocalized(@"累计返佣(USDT)", nil)
                     ,SSKJLocalized(@"今日新增", nil)
                     ,SSKJLocalized(@"直推人数", nil)
                     ,SSKJLocalized(@"团队人数", nil)];
    for (int i=0; i<6; i++) {
        
        
        UILabel *label=[UILabel new];
        
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self).offset(space+(width+space)*(i%3));
            
            make.top.equalTo(self).offset(2*space+(2*height+topSpace)*(i/3));
            
            make.width.mas_equalTo(width);
            
            make.height.mas_equalTo(height);
            
        }];
        
        label.textColor=kBgColor;
        
        label.font=systemFont(ScaleW(18));
        
        label.textAlignment=NSTextAlignmentCenter;
        
        label.adjustsFontSizeToFitWidth=YES;
        
        
        UILabel *bottomLabel=[UILabel new];
        bottomLabel.adjustsFontSizeToFitWidth=YES;

        [self addSubview:bottomLabel];
        
        bottomLabel.textColor=kBgColor;
        
        bottomLabel.font=systemFont(ScaleW(11));
        
        bottomLabel.textAlignment=NSTextAlignmentCenter;
        
        [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(space+(width+space)*(i%3));
            
            make.top.equalTo(label.mas_bottom).offset(ScaleW(10));
            
            make.width.mas_equalTo(width);
            
            make.height.mas_equalTo(height);
            
        }];
        label.text=@"0";
       
        
        bottomLabel.text=array[i];
        
        [_numArray addObject:label];
        
    }
    
}
-(void)setUI
{
    [self addSubview:self.headerImageView];
    [self addSubview:self.kehuTitleLabel];
    [self addSubview:self.kehuNumberLabel];
    
    [self addSubview:self.todayIncomeTitleLabel];
    [self addSubview:self.todayIncomeLabel];
    
    [self addSubview:self.totalIncomeTitleLabel];
    [self addSubview:self.totalIncomeLabel];
    
    self.height = self.totalIncomeTitleLabel.bottom + ScaleW(18);
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.totalIncomeTitleLabel.bottom+ScaleW(8), ScreenWidth, ScaleW(10))];
    line.backgroundColor = kBgColor;
    [self addSubview:line];
}


-(UIImageView *)headerImageView
{
    if (nil == _headerImageView) {
        _headerImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _headerImageView.image = [UIImage imageNamed:SSKJLocalized(@"lightning_yaoqingbg", nil)];
        
        _headerImageView.backgroundColor=[UIColor blueColor];
        
    }
    return _headerImageView;
}

-(UILabel *)kehuNumberLabel
{
    if (nil == _kehuNumberLabel) {
        _kehuNumberLabel = [WLTools allocLabel:SSKJLocalized(@"4", nil) font:systemBoldFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(0, self.headerImageView.bottom + ScaleW(20), self.width / 3, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
    }
    return _kehuNumberLabel;
}

-(UILabel *)kehuTitleLabel
{
    if (nil == _kehuTitleLabel) {
        _kehuTitleLabel = [WLTools allocLabel:SSKJLocalized(@"累计开户", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(0, self.kehuNumberLabel.bottom + ScaleW(15), self.kehuNumberLabel.width, ScaleW(13)) textAlignment:NSTextAlignmentCenter];
    }
    return _kehuTitleLabel;
}

-(UILabel *)todayIncomeLabel
{
    if (nil == _todayIncomeLabel) {
        _todayIncomeLabel = [WLTools allocLabel:SSKJLocalized(@"0", nil) font:systemBoldFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(self.kehuNumberLabel.right, self.kehuNumberLabel.y, self.width / 3, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
        _totalIncomeLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _todayIncomeLabel;
}

-(UILabel *)todayIncomeTitleLabel
{
    if (nil == _todayIncomeTitleLabel) {
        _todayIncomeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"今日收益(USDT)", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(self.todayIncomeLabel.x, self.kehuTitleLabel.y, self.kehuNumberLabel.width, ScaleW(13)) textAlignment:NSTextAlignmentCenter];
        _todayIncomeTitleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _todayIncomeTitleLabel;
}


-(UILabel *)totalIncomeLabel
{
    if (nil == _totalIncomeLabel) {
        _totalIncomeLabel = [WLTools allocLabel:SSKJLocalized(@"0", nil) font:systemBoldFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(self.todayIncomeLabel.right, self.kehuNumberLabel.y, self.width / 3, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
        _totalIncomeLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _totalIncomeLabel;
}

-(UILabel *)totalIncomeTitleLabel
{
    if (nil == _totalIncomeTitleLabel) {
        _totalIncomeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"累计收益(USDT)", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(self.totalIncomeLabel.x, self.kehuTitleLabel.y, self.kehuNumberLabel.width, ScaleW(13)) textAlignment:NSTextAlignmentCenter];
        _totalIncomeTitleLabel.adjustsFontSizeToFitWidth = YES;

    }
    return _totalIncomeTitleLabel;
}


-(void)setViewWithModel:(My_PromoteDetail_Model *)model
{
    
    NSArray *array=@[model.todayMoney,model.yesterdayMoney,model.totalMoney,model.directUserToday,model.directUser,model.totalDirectUser];
  

    for (int i=0 ; i<array.count; i++) {
        
        UILabel *label=_numArray[i];
        NSInteger num=[WLTools dotNumberOfAssetCoinName:@"DIG"];
        
        NSString *number=[NSString stringWithFormat:@"%@",array[i]];
        
        label.text=[WLTools noroundingStringWith:number.doubleValue afterPointNumber:num];
        
    }
//    self.kehuNumberLabel.text = model.countNum;
//
//    self.todayIncomeLabel.text = [WLTools noroundingStringWith:model.totalDay.doubleValue afterPointNumber:4];
//
//    self.totalIncomeLabel.text = [WLTools noroundingStringWith:model.total.doubleValue afterPointNumber:4];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
