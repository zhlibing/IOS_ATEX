//
//  BW_OTCRoot_SegmentView.m
//  SSKJ
//
//  Created by terre sea on 2019/8/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_Nav_SegmentView.h"

@interface SSKJ_Nav_SegmentView()

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;

@property(nonatomic, strong)UIView *contentView;
@end

@implementation SSKJ_Nav_SegmentView

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize
{
    if (self = [super initWithFrame:frame]) {
        _titlesArray = titles;
        _fontSize = fontSize;
        _normalColor = normalColor;
        _selectedColor = selectedColor;
        [self addSubview:self.contentView];
        [self addSubview:self.selectView];
        [self addButtons];
        
    }
    return self;
}

- (void)setChangeForhyue:(BOOL)changeForhyue{
    _changeForhyue = changeForhyue;
    self.contentView.layer.cornerRadius = 0;
    _contentView.layer.borderColor = [UIColor clearColor].CGColor;
    
    _selectView.layer.borderColor = [UIColor clearColor].CGColor;
    _selectView.layer.cornerRadius = 0;
    _selectView.backgroundColor = self.selectedColor;
    
    
    _selectView.frame = CGRectMake(0, self.height - 3, ScaleW(25), 3);
    UIButton *btn = self.buttonArray.firstObject;
    self.selectView.centerX = btn.centerX;
}



- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.layer.cornerRadius = ScaleW(self.height) * 0.5;
        _contentView.layer.borderColor = _normalColor.CGColor;
        _contentView.layer.borderWidth = 1;
//        _contentView.backgroundColor = []
    }
    return _contentView;
}

-(NSMutableArray *)buttonArray
{
    if (nil == _buttonArray) {
        _buttonArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _buttonArray;
}


-(void)addButtons
{
    CGFloat width = self.width / (self.titlesArray.count);
    for (int i = 0; i < self.titlesArray.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(width * i, 0, width, self.height)];
        [self addSubview:btn];
        btn.titleLabel.font = systemFont(_fontSize);
        [btn setTitle:self.titlesArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.selectedColor forState:UIControlStateSelected];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn.tag = 100 + i;
        [self.buttonArray addObject:btn];
        if (i == 0) {
//            [btn setTitleColor:kWhiteColor forState:UIControlStateSelected];
            self.selectView.centerX = btn.centerX;
            btn.selected = YES;
        }
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(UIView *)selectView
{
    if (nil == _selectView) {
        
        _selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width/2, self.height)];
       _selectView.layer.borderColor = self.normalColor.CGColor;
        _selectView.layer.borderWidth = 1;
        _selectView.layer.cornerRadius = ScaleW(self.height) * 0.5;
        _selectView.backgroundColor = self.normalColor;
    }
    return _selectView;
}

-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    for (UIButton *btn in self.buttonArray) {
        if (btn.tag == 100 + selectedIndex) {
            btn.selected = YES;
            WS(weakSelf);
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.selectView.centerX = btn.centerX;
            }];
        }else{
            btn.selected = NO;
        }
    }
}


-(void)btnClicked:(UIButton *)sender
{
    
    if (sender.selected) {
        return;
    }
    
    NSInteger tag = sender.tag - 100;
    BOOL shouldSelect;
    if (self.selectedIndexBlock) {
        shouldSelect = self.selectedIndexBlock(tag);
    }
    
    if (!shouldSelect) {
        return;
    }
    
    for (UIButton *button in self.buttonArray) {
        if (button == sender) {
            button.selected = YES;
            _selectedIndex = sender.tag - 100;
            WS(weakSelf);
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.selectView.centerX = sender.centerX;
            }];
        }else{
            button.selected = NO;
        }
    }
    
    
    
}
@end
