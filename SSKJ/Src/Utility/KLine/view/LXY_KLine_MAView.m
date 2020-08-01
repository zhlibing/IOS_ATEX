//
//  LXY_KLine_MAView.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/25.
//  Copyright © 2018年 James. All rights reserved.
//

#import "LXY_KLine_MAView.h"

@interface LXY_KLine_MAView ()
@property (nonatomic, strong) UILabel *maLabel;
@end

@implementation LXY_KLine_MAView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.maLabel];
    }
    return self;
}


-(UILabel *)maLabel
{
    if (nil == _maLabel) {
        _maLabel = [WLTools allocLabel:@"" font:systemFont(10) textColor:[UIColor whiteColor] frame:CGRectMake(0, 0, self.width, self.height) textAlignment:NSTextAlignmentLeft];
    }
    return _maLabel;
}


-(void)showViewWith:(LXY_KLine_DataModel *)model
{
    self.hidden = NO;
    NSInteger pointCount = LXY_DecimalNumber;
    
    if (self.mainAccessoryType == LXY_KMAINACCESSORYTYPEMA) {
        self.maLabel.hidden = NO;
        
        NSString *ma5 = [@"MA5:" stringByAppendingString:[WLTools noroundingStringWith:model.ma5 afterPointNumber:pointCount]];
        NSString *ma10 = [@"MA10:" stringByAppendingString:[WLTools noroundingStringWith:model.ma10 afterPointNumber:pointCount]];
        NSString *ma20 = [@"MA20:" stringByAppendingString:[WLTools noroundingStringWith:model.ma20 afterPointNumber:pointCount]];
        
        
        NSString *maString = [NSString stringWithFormat:@"%@    %@    %@",ma5,ma10,ma20];
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:maString];
        
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_MA5Color] range:NSMakeRange(0, ma5.length)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_MA10Color] range:NSMakeRange(ma5.length + 4, ma10.length)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_MA20Color] range:NSMakeRange(maString.length - ma20.length, ma20.length)];
        self.maLabel.attributedText = attributeString;
    }else if (self.mainAccessoryType == LXY_KMAINACCESSORYTYPEBOLL) {
        self.maLabel.hidden = NO;

        NSString *BOLL = [@"BOLL:" stringByAppendingString:[WLTools noroundingStringWith:model.BOLL_MB afterPointNumber:pointCount]];
        NSString *BOLL_UP = [@"UB:" stringByAppendingString:[WLTools noroundingStringWith:model.BOLL_UP afterPointNumber:pointCount]];
        NSString *BOLL_DN = [@"LB:" stringByAppendingString:[WLTools noroundingStringWith:model.BOLL_DN afterPointNumber:pointCount]];
        
        
        NSString *totalString = [NSString stringWithFormat:@"%@    %@    %@",BOLL,BOLL_UP,BOLL_DN];
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:totalString];
        
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_MA5Color] range:NSMakeRange(0, BOLL.length)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_MA10Color] range:NSMakeRange(BOLL.length + 4, BOLL_UP.length)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_MA20Color] range:NSMakeRange(totalString.length - BOLL_DN.length, BOLL_DN.length)];
        self.maLabel.attributedText = attributeString;
    }else{
        self.maLabel.hidden = YES;
    }
    
    
}
-(void)hideView
{
    self.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
