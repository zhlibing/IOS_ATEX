//
//  JB_BBTrade_SocketDealOrder_HeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/15.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_BBTrade_SocketDealOrder_HeaderView.h"

@interface JB_BBTrade_SocketDealOrder_HeaderView ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *amountLabel;



@end

@implementation JB_BBTrade_SocketDealOrder_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBgColor;
        [self addLabels];
    }
    return self;
}

-(void)addLabels
{
    NSArray *array = @[SSKJLocalized(@"时间", nil),SSKJLocalized(@"方向", nil),SSKJLocalized(@"价格", nil),SSKJLocalized(@"数量", nil)];
    
    CGFloat width = (self.width - ScaleW(30)) / 4;
    
    for (int i = 0; i < array.count; i++) {
        NSString *title = array[i];
        UILabel *label = [WLTools allocLabel:title font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15) + i * width, 0, width, self.height) textAlignment:NSTextAlignmentLeft];
        NSTextAlignment aligment;
        if (i == 0) {
            aligment = NSTextAlignmentLeft;
            self.timeLabel = label;
        }else if (i == 1){
            aligment = NSTextAlignmentLeft;
            self.typeLabel = label;
        }else if (i == 2){
            aligment = NSTextAlignmentCenter;
            self.priceLabel = label;
        }else{
            self.amountLabel = label;
            aligment = NSTextAlignmentRight;
        }
        
        label.textAlignment = aligment;
        
        [self addSubview:label];
        
        
    }
    
}

-(void)setCoinModel:(SSKJ_Market_Index_Model *)coinModel
{
    NSArray *array = [[coinModel.code uppercaseString] componentsSeparatedByString:@"_"];
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"价格", nil),array.lastObject];
    
    self.amountLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"数量", nil),array.firstObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
