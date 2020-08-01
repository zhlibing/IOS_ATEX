//
//  LXY_KLine_PriceView.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/25.
//  Copyright © 2018年 James. All rights reserved.
//

#import "LXY_KLine_PriceLabel_View.h"



@interface LXY_KLine_PriceLabel_View ()
{
    BOOL _isLongPress;
    LXY_KLine_DataModel *_longPressModel;
    CGFloat _longPressPositionY;
//    LXY_KLine_DataModel *_lastModel;
//    LXY_KLine_StockChartPositionModel *_lastPositionModel;
    
    

    
}
@property (nonatomic, strong) UILabel *currentPriceLabel;
//@property (nonatomic, strong) UILabel *yingkuiLabel;        // 盈亏额


@property (nonatomic, strong) NSMutableArray *dataArray;

@end


@implementation LXY_KLine_PriceLabel_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.currentPriceLabel];
        self.userInteractionEnabled = NO;
    }
    return self;
}

-(UILabel *)currentPriceLabel
{
    if (nil == _currentPriceLabel) {
        _currentPriceLabel = [WLTools allocLabel:@"" font:systemFont(12) textColor:[UIColor lxy_FloatPriceColor] frame:CGRectMake(0, 0, self.width - 5, 12) textAlignment:NSTextAlignmentRight];
        _currentPriceLabel.backgroundColor = [UIColor lxy_kLineBGColor];
    }
    return _currentPriceLabel;
}

-(NSMutableArray *)dataArray
{
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}



-(void)drawView
{
    [self.dataArray removeAllObjects];
    for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i++) {
        [self.dataArray addObject:[self.dataSource objectAtIndex:i]];
    }

    [self setNeedsDisplay];
    
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (int i = 0; i < LXY_NumberofPriceline + 2; i++) {
        
        double price_scale = (self.maxPrice - self.minPrice) / (LXY_NumberofPriceline + 1);
        
        double price = self.maxPrice - price_scale * i;
        NSInteger count = LXY_DecimalNumber;
        if (![self.coinName containsString:@"BTC"]) {
            count = LXY_DecimalNumber;
        }
        
        NSString *formate = [NSString stringWithFormat:@"%%.%ldf",count];
        
//        NSString *priceString = [NSString stringWithFormat:formate,price];
        
        NSString *priceString = [WLTools noroundingStringWith:price afterPointNumber:count];
        
//        CGFloat width = [WLTools getWidthWithText:priceString font:systemFont(10)]  + 10;
        
        [[UIColor clearColor]setFill];//设置填充颜色
        [[UIColor whiteColor]setStroke];
        UIFont  *font = [UIFont boldSystemFontOfSize:10];//设置字体
        CGFloat y = 0;
        if (i == 0) {
            y = 0;
        }else if (i == LXY_NumberofPriceline + 1) {
            y = self.height - 10 - 1;
        }else{
            y =  10 + (self.height - 20) / (LXY_NumberofPriceline + 1) * i - 10 - 2;
        }
        
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [paragraphStyle setAlignment:NSTextAlignmentRight];
        NSDictionary *attribute = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor lxy_priceColor],NSParagraphStyleAttributeName:paragraphStyle};
        
        [priceString drawInRect:CGRectMake(0, y, self.width - 4,10) withAttributes:attribute];
        
//        NSString *currentPrice =  [WLTools noroundingStringWith:self.lastModel.close.doubleValue afterPointNumber:LXY_DecimalNumber];
//
//        y = self.lastPositionModel.closeY - 12;
//
////        attribute = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor lxy_priceColor]};
//
//        [currentPrice drawInRect:CGRectMake(0, y, width,10) withAttributes:attribute];
        
    }
    
    if (_isLongPress) {
//        [self drawLongPressLabel];
    }
    
    
}


-(void)refreshCurrentPricelabel
{
    
    
    NSString *currentPrice = [WLTools noroundingStringWith:self.lastModel.close.doubleValue afterPointNumber:LXY_DecimalNumber];
    
    self.currentPriceLabel.hidden = NO;
//    CGFloat width = [WLTools getWidthWithText:currentPrice font:self.currentPriceLabel.font];
//    self.currentPriceLabel.width = width + 5;
    self.currentPriceLabel.text = currentPrice;
    self.currentPriceLabel.y = self.lastPositionModel.closeY - 12;
  
    
}

-(void)hideCurrentPriceLabel
{
    
    self.currentPriceLabel.hidden = YES;

}

-(void)drawLongPressLabel
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSString *priceString = [WLTools noroundingStringWith:_longPressModel.close.doubleValue afterPointNumber:LXY_DecimalNumber];
    
    CGFloat width = [WLTools getWidthWithText:priceString font:systemFont(10)] + ScaleW(10);

    UIFont  *font = [UIFont boldSystemFontOfSize:10];//设置字体
    
    NSDictionary *attribute = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor lxy_priceColor],NSBackgroundColorAttributeName:[UIColor lxy_kLine_Main_BGColor]};
    
    [priceString drawInRect:CGRectMake(0, _longPressPositionY - 12, width,10) withAttributes:attribute];

    
}

-(void)longPressWithModel:(LXY_KLine_DataModel *)model positionY:(CGFloat)positionY;
{
    _isLongPress = YES;
    _longPressModel = model;
    _longPressPositionY = positionY;
    [self setNeedsDisplay];
}

-(void)hideLongPressLabel
{
    _isLongPress = NO;
    [self setNeedsDisplay];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
