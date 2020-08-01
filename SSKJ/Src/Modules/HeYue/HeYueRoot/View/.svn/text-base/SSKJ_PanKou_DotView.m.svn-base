//
//  SSKJ_PanKou_DotView.m
//  SSKJ
//
//  Created by zpz on 2019/10/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_PanKou_DotView.h"

@interface SSKJ_PanKou_DotView()

@property (nonatomic, strong) UIView *dotSelectBackView;
@property (nonatomic, strong) UILabel *dotLabel;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, assign) NSInteger maxDotNumber;

@end

@implementation SSKJ_PanKou_DotView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI
{
        [self addSubview:self.dotSelectBackView];
        [self.dotSelectBackView addSubview:self.dotLabel];
        [self.dotSelectBackView addSubview:self.selectButton];
}

-(UIView *)dotSelectBackView
{
    if (nil == _dotSelectBackView) {
        _dotSelectBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, ScaleW(33))];
        _dotSelectBackView.layer.masksToBounds = YES;
        _dotSelectBackView.layer.borderColor = kLineColor.CGColor;
        _dotSelectBackView.layer.borderWidth = 0.5;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectDotEvent)];
        [_dotSelectBackView addGestureRecognizer:tap];
    }
    return _dotSelectBackView;
}

-(UILabel *)dotLabel
{
    if (nil == _dotLabel) {
        _dotLabel = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(10), 0, ScaleW(100), self.dotSelectBackView.height) textAlignment:NSTextAlignmentLeft];
    }
    return _dotLabel;
}

-(UIButton *)selectButton
{
    if (nil == _selectButton) {
        _selectButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - ScaleW(25), 0, ScaleW(25), self.dotSelectBackView.height)];
        [_selectButton setImage:[UIImage imageNamed:@"hy_down_gray"] forState:UIControlStateNormal];
    }
    return _selectButton;
}

-(void)selectDotEvent
{
    
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 1; i <= self.maxDotNumber; i++) {
        [array addObject:[NSString stringWithFormat:@"%d%@",i,SSKJLocalized(@"位小数", nil)]];
    }
    
    WS(weakSelf);
    [SSKJ_Default_ActionsheetView showWithItems:array title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
        NSString *title = array[selectIndex];
        weakSelf.dotLabel.text = title;
        if (weakSelf.changeDotBlock) {
            weakSelf.changeDotBlock(selectIndex + 1);
        }
    } cancleBlock:^{
        
    }];
}

- (void)setCoin:(NSString *)coin{
    _coin = coin;
    
    NSInteger maxDotNumber = [SSTool MarketPrice:coin];
    self.dotLabel.text = [NSString stringWithFormat:@"%ld%@",maxDotNumber,SSKJLocalized(@"位小数", nil)];
    self.maxDotNumber = maxDotNumber;
}

@end
