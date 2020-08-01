//
//  LXY_DeepView.m
//  深度
//
//  Created by 刘小雨 on 2019/3/19.
//  Copyright © 2019年 MingShao. All rights reserved.
//

#import "LXY_DeepView.h"
#import "LXY_DeepModel.h"
#import "LXY_DeepPosition_Model.h"
#import "LXY_Deep_LongPressView.h"

#define kTop_gap    ScaleW(20)          // 上方空白高度
#define kBottom_gap    ScaleW(20)       // 下方时间轴高度

@interface LXY_DeepView ()
@property (nonatomic, strong) UIView *buyColorView;
@property (nonatomic, strong) UILabel *buyTitleLabel;
@property (nonatomic, strong) UIView *sellColorView;
@property (nonatomic, strong) UILabel *sellTitleLabel;


@property (nonatomic, strong) NSMutableArray *buyModelArray;
@property (nonatomic, strong) NSMutableArray *sellModelArray;

@property (nonatomic, strong) NSMutableArray *buyPositionArray;
@property (nonatomic, strong) NSMutableArray *sellPositionArray;

@property (nonatomic, assign) double maxPrice;      // 最高价格
@property (nonatomic, assign) double minPrice;      // 最低价格
@property (nonatomic, assign) double leftMaxPrice;      // 最高价格
@property (nonatomic, assign) double leftMinPrice;      // 最低价格
@property (nonatomic, assign) double rightMaxPrice;      // 最高价格
@property (nonatomic, assign) double rightMinPrice;      // 最低价格

@property (nonatomic, assign) double maxVolume;     // 最大成交量
@property (nonatomic, assign) double minVolume;     // 最小成交量

@property (nonatomic, strong) LXY_DeepPosition_Model *longPressPositionModel;
@property (nonatomic, strong) LXY_DeepModel *longPressModel;

@property (nonatomic, strong) LXY_Deep_LongPressView *longPressView;

@property (nonatomic, strong) UILabel *longPressVolumeLabel;
@property (nonatomic, strong) UILabel *longPressPriceLabel;

@property (nonatomic, assign) BOOL isLarge;

@end

@implementation LXY_DeepView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        self.backgroundColor = [UIColor clearColor];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressEvent:)];
        [self addGestureRecognizer:longPress];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


-(NSMutableArray *)buyPositionArray
{
    if (nil == _buyPositionArray) {
        _buyPositionArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _buyPositionArray;
}
-(NSMutableArray *)sellPositionArray
{
    if (nil == _sellPositionArray) {
        _sellPositionArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _sellPositionArray;
}

#pragma mark - UI部分 红绿方块
-(void)setUI
{
    [self addSubview:self.buyTitleLabel];
    [self addSubview:self.buyColorView];
    [self addSubview:self.sellColorView];
    [self addSubview:self.sellTitleLabel];
}

-(UILabel *)buyTitleLabel
{
    if (nil == _buyTitleLabel) {
        
        NSString *lan = [[SSKJLocalized sharedInstance]currentLanguage];
        CGFloat width = ScaleW(25);
        if ([lan containsString:@"en"]) {
            width = ScaleW(50);
        }
        
        _buyTitleLabel = [WLTools allocLabel:SSKJLocalized(@"买入", nil)  font:systemFont(ScaleW(10)) textColor:[UIColor lxy_volumeColor] frame:CGRectMake(self.width / 2 - width, kTop_gap, width, ScaleW(10)) textAlignment:NSTextAlignmentCenter];
        _buyTitleLabel.adjustsFontSizeToFitWidth = YES;
        
    }
    return _buyTitleLabel;
}

-(UIView *)buyColorView
{
    if (nil == _buyColorView) {
        _buyColorView = [[UIView alloc]initWithFrame:CGRectMake(self.buyTitleLabel.x - ScaleW(15), self.buyTitleLabel.y, ScaleW(7), ScaleW(7))];
        _buyColorView.backgroundColor = [UIColor lxy_riseColor];
        _buyColorView.centerY = self.buyTitleLabel.centerY;
    }
    return _buyColorView;
}

-(UIView *)sellColorView
{
    if (nil == _sellColorView) {
        _sellColorView = [[UIView alloc]initWithFrame:CGRectMake(self.width / 2 + ScaleW(10), self.buyTitleLabel.y, ScaleW(7), ScaleW(7))];
        _sellColorView.backgroundColor = [UIColor lxy_fallColor];
        _sellColorView.centerY = self.buyTitleLabel.centerY;

    }
    return _sellColorView;
}
-(UILabel *)sellTitleLabel
{
    if (nil == _sellTitleLabel) {
        NSString *lan = [[SSKJLocalized sharedInstance]currentLanguage];
        CGFloat width = ScaleW(25);
        if ([lan containsString:@"en"]) {
            width = ScaleW(50);
        }
        _sellTitleLabel = [WLTools allocLabel:SSKJLocalized(@"卖出", nil) font:systemFont(ScaleW(10)) textColor:[UIColor lxy_volumeColor] frame:CGRectMake(self.sellColorView.right + ScaleW(8), self.buyTitleLabel.y, width, ScaleW(10)) textAlignment:NSTextAlignmentCenter];
        _sellTitleLabel.centerY = self.buyTitleLabel.centerY;
        _sellTitleLabel.adjustsFontSizeToFitWidth = YES;

    }
    return _sellTitleLabel;
}




#pragma mark - 添加数据
-(void)setData:(NSDictionary *)data isLarge:(BOOL)isLarge
{
    [self tapEvent:nil];
    _isLarge = isLarge;
    if (data) {
        self.stockCode = data[@"code"];
        
        self.buyModelArray = [LXY_DeepModel mj_objectArrayWithKeyValuesArray:[[data[@"bids"]reverseObjectEnumerator] allObjects]];
        
        self.sellModelArray = [LXY_DeepModel mj_objectArrayWithKeyValuesArray:data[@"asks"]];
        
        [self calculateMaxAndMin];
        
        [self calculatePositionModel];
        [self setNeedsDisplay];
    }
}

#pragma mark - 计算销量的最大值和最小值，成交量的最大值最小值

-(void)calculateMaxAndMin
{
    LXY_DeepModel *leftFirstModel = self.buyModelArray.firstObject;
    LXY_DeepModel *rightFirstModel = self.sellModelArray.firstObject;
    self.maxPrice = leftFirstModel.price.doubleValue;
    self.minPrice = leftFirstModel.price.doubleValue;
    self.leftMaxPrice = leftFirstModel.price.doubleValue;
    self.leftMinPrice = leftFirstModel.price.doubleValue;
    self.rightMaxPrice = rightFirstModel.price.doubleValue;
    self.rightMinPrice = rightFirstModel.price.doubleValue;

    self.maxVolume = leftFirstModel.volume.doubleValue;
    self.minVolume = leftFirstModel.volume.doubleValue;
    
    for (LXY_DeepModel *model in self.buyModelArray) {
        if (model.price.doubleValue > self.maxPrice) {
            self.maxPrice = model.price.doubleValue;
            self.leftMaxPrice = model.price.doubleValue;
        }
        
        if (model.price.doubleValue < self.minPrice) {
            self.minPrice = model.price.doubleValue;
            self.leftMinPrice = model.price.doubleValue;

        }
        
        if (model.volume.doubleValue > self.maxVolume) {
            self.maxVolume = model.volume.doubleValue;
            
        }
        
        if (model.volume.doubleValue < self.minVolume) {
            self.minVolume = model.volume.doubleValue;
        }
    }
    
    for (LXY_DeepModel *model in self.sellModelArray) {
        if (model.price.doubleValue > self.maxPrice) {
            self.maxPrice = model.price.doubleValue;
            self.rightMaxPrice = model.price.doubleValue;

        }
        
        if (model.price.doubleValue < self.minPrice) {
            self.minPrice = model.price.doubleValue;
            self.rightMinPrice = model.price.doubleValue;

        }
        
        if (model.volume.doubleValue > self.maxVolume) {
            self.maxVolume = model.volume.doubleValue;
        }
        
        if (model.volume.doubleValue < self.minVolume) {
            self.minVolume = model.volume.doubleValue;
        }
    }
}

#pragma mark - 计算各个model对用的位置model
-(void)calculatePositionModel
{
    [self.buyPositionArray removeAllObjects];
    [self.sellPositionArray removeAllObjects];
    
    if (self.maxVolume == self.minVolume || self.maxPrice == self.minPrice) {
        return;
    }
    // 每一点销量对应的高度
    CGFloat Yscale = (self.height - self.buyTitleLabel.bottom - ScaleW(10) - kBottom_gap) / (self.maxVolume - self.minVolume);
    CGFloat Xscale = (self.width) / (self.maxPrice - self.minPrice);
    
    
    CGFloat leftXscale = (self.width / 2) / (self.leftMaxPrice - self.leftMinPrice);
    
    CGFloat rightXscale = (self.width / 2) / (self.rightMaxPrice - self.rightMinPrice);
    
    if (self.buyModelArray.count == 1) {
        leftXscale = self.width / 2;
    }
    
    if (self.sellModelArray.count == 1) {
        rightXscale = 0;
    }
    
    for (LXY_DeepModel *model in self.buyModelArray) {
        LXY_DeepPosition_Model *positionModel = [[LXY_DeepPosition_Model alloc]init];
        positionModel.centerX = (model.price.doubleValue - self.leftMinPrice) * leftXscale;
        positionModel.centerY = (self.maxVolume - model.volume.doubleValue) * Yscale + self.buyTitleLabel.bottom + ScaleW(10);
        [self.buyPositionArray addObject:positionModel];
    }
    
    for (LXY_DeepModel *model in self.sellModelArray) {
        LXY_DeepPosition_Model *positionModel = [[LXY_DeepPosition_Model alloc]init];
        positionModel.centerX = self.width / 2 + (model.price.doubleValue - self.rightMinPrice) * rightXscale;
        positionModel.centerY = (self.maxVolume - model.volume.doubleValue) * Yscale +  + self.buyTitleLabel.bottom + ScaleW(10);
        [self.sellPositionArray addObject:positionModel];
    }
}


#pragma mark - 绘图

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self drawBuyLine];     // 画买xian
    [self drawBuyView];     // 画买线填充色图
    [self drawSellLine];     // 画卖线
    [self drawSellView];     // 画卖线填充色图
    
    if (self.isLarge) {
        [self drawVolume];      // 画成交量轴
        
        [self drawPrice];       // 画价格轴
    }

}



#pragma mark - 绘制buy线
- (void)drawBuyLine
{
    if (self.buyModelArray.count > 0) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 1.0f);
        CGContextSetStrokeColorWithColor(context, [UIColor lxy_riseColor].CGColor);
        CGFloat dash[] = {1,3};
        CGContextSetLineDash(context, 0, dash, 0);
        // 即时成交价线
        for (NSInteger i = 0; i < self.buyPositionArray.count; i ++) {
            LXY_DeepPosition_Model *positionModel = [self.buyPositionArray objectAtIndex:i];
            CGFloat x = positionModel.centerX;
            CGFloat y = positionModel.centerY;
            if (i == 0) {
                CGContextMoveToPoint(context, x, y);
            }
            else{
                CGContextAddLineToPoint(context, x, y);
            }
        }
        CGContextStrokePath(context);
    }
}


#pragma mark - 绘制sell线
- (void)drawSellLine
{
    if (self.buyModelArray.count > 0) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 1.0f);
        CGContextSetStrokeColorWithColor(context, [UIColor lxy_fallColor].CGColor);
        CGFloat dash[] = {1,3};
        CGContextSetLineDash(context, 0, dash, 0);
        // 即时成交价线
        for (NSInteger i = 0; i < self.sellPositionArray.count; i ++) {
            LXY_DeepPosition_Model *positionModel = [self.sellPositionArray objectAtIndex:i];
            CGFloat x = positionModel.centerX;
            CGFloat y = positionModel.centerY;
            if (i == 0) {
                CGContextMoveToPoint(context, x, y);
            }
            else{
                CGContextAddLineToPoint(context, x, y);
            }
        }
        CGContextStrokePath(context);
    }
}

#pragma mark - 绘制buy填充色
- (void)drawBuyView
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGMutablePathRef fillPath = CGPathCreateMutable();
    
    if (self.buyPositionArray.count > 0 ) {
        
        for (int i = 0; i < self.buyPositionArray.count; i++)
        {
            LXY_DeepPosition_Model *model = [self.buyPositionArray objectAtIndex:i];
            if (i == 0) {
                CGPathMoveToPoint(fillPath, NULL, model.centerX, self.height - kBottom_gap);
//                SSLog(@"%f",self.height);
                CGPathAddLineToPoint(fillPath, NULL, model.centerX, model.centerY);
            } else if (i == self.buyPositionArray.count - 1) {
                CGPathAddLineToPoint(fillPath, NULL, model.centerX, model.centerY);
                CGPathAddLineToPoint(fillPath, NULL, model.centerX, self.height - kBottom_gap);
                CGPathCloseSubpath(fillPath);
            }  else{
                CGPathAddLineToPoint(fillPath, NULL, model.centerX, model.centerY);
            }
        }
        
    }
    [self drawLinearGradient:context path:fillPath alpha:1 startColor:[UIColor lxy_riseColor].CGColor endColor:[UIColor lxy_riseColor].CGColor];
    
    
    CGPathRelease(fillPath);
    
    CGContextRestoreGState(context);
}


#pragma mark - 绘制sell填充色
- (void)drawSellView
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGMutablePathRef fillPath = CGPathCreateMutable();
    
    if (self.sellPositionArray.count > 0 ) {
        
        for (int i = 0; i < self.sellPositionArray.count; i++)
        {
            LXY_DeepPosition_Model *model = [self.sellPositionArray objectAtIndex:i];
            if (i == 0) {
                CGPathMoveToPoint(fillPath, NULL, model.centerX, self.height - kBottom_gap);
//                SSLog(@"%f",self.height);
                CGPathAddLineToPoint(fillPath, NULL, model.centerX, model.centerY);
            } else if (i == self.sellPositionArray.count - 1) {
                CGPathAddLineToPoint(fillPath, NULL, model.centerX, model.centerY);
                CGPathAddLineToPoint(fillPath, NULL, model.centerX, self.height - kBottom_gap);
                CGPathCloseSubpath(fillPath);
            }  else{
                CGPathAddLineToPoint(fillPath, NULL, model.centerX, model.centerY);
            }
        }
        
    }
    
//    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    [self drawLinearGradient:context path:fillPath alpha:1 startColor:[UIColor lxy_fallColor].CGColor endColor:[UIColor lxy_fallColor].CGColor];
    
    
    CGPathRelease(fillPath);
    
    CGContextRestoreGState(context);
}


#pragma mark - 绘制填充色
- (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                     alpha:(CGFloat)alpha
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextSetAlpha(context, 0.2);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}


#pragma mark - 画成交量坐标
-(void)drawVolume
{
    double volumeArea = self.maxVolume - self.minVolume;
    double volumeScale = volumeArea / 5;
    for (int i = 0; i < 6; i++) {
        if (i == 5) {
            break;
        }
        NSString *volumeString = [WLTools noroundingStringWith:self.maxVolume - volumeScale * i afterPointNumber:0];

        
        [[UIColor redColor]setStroke];
        UIFont  *font = systemFont(ScaleW(10));//设置字体
        CGFloat height = ScaleW(12);
        if (self.width <= ScreenWidth / 2) {
            font = systemFont(ScaleW(7));
        }
        
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [paragraphStyle setAlignment:NSTextAlignmentRight];
        NSDictionary *attribute = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor lxy_volumeColor],NSParagraphStyleAttributeName:paragraphStyle};
        
        CGFloat yScale = (self.height - self.buyTitleLabel.bottom - ScaleW(10) - kBottom_gap) / 5;
        
        [volumeString drawInRect:CGRectMake(0, self.buyTitleLabel.bottom + ScaleW(10) + yScale * i, self.width,height) withAttributes:attribute];
    }
    
}

#pragma mark - 画价格坐标
-(void)drawPrice
{
    
    NSInteger dotNumber = [SSTool MarketPrice:self.stockCode];
    
    NSString *minPriceString = [WLTools roundingStringWith:self.minPrice afterPointNumber:dotNumber];
    [[UIColor redColor]setStroke];
    UIFont  *font = systemFont(ScaleW(10));//设置字体
    CGFloat height = ScaleW(12);
    if (self.width <= ScreenWidth / 2) {
        font = systemFont(ScaleW(7));
    }
    CGFloat minWidth = [WLTools getWidthWithText:minPriceString font:font] + ScaleW(5);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [paragraphStyle setAlignment:NSTextAlignmentRight];
    NSDictionary *attribute = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor lxy_priceColor],NSParagraphStyleAttributeName:paragraphStyle};
    [minPriceString drawInRect:CGRectMake(0, self.height - kBottom_gap + (kBottom_gap - height) / 2, minWidth,height) withAttributes:attribute];
    
    
    LXY_DeepPosition_Model *centerPositionModel1 = self.buyPositionArray.lastObject;
    LXY_DeepModel *centerModel1 = self.buyModelArray.lastObject;
    NSString *centerPriceString1 = [WLTools roundingStringWith:centerModel1.price.doubleValue afterPointNumber:dotNumber];
    CGFloat centerWidth1 = [WLTools getWidthWithText:centerPriceString1 font:font] + ScaleW(5);
    
    [[UIColor redColor]setStroke];
    paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [paragraphStyle setAlignment:NSTextAlignmentRight];
    attribute = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor lxy_priceColor],NSParagraphStyleAttributeName:paragraphStyle};
    [centerPriceString1 drawInRect:CGRectMake(centerPositionModel1.centerX - centerWidth1  - ScaleW(2), self.height - kBottom_gap + (kBottom_gap - height) / 2, centerWidth1,height) withAttributes:attribute];
    
    
    LXY_DeepPosition_Model *centerPositionModel2 = self.sellPositionArray.firstObject;
    LXY_DeepModel *centerModel2 = self.sellModelArray.firstObject;
    NSString *centerPriceString2 = [WLTools roundingStringWith:centerModel2.price.doubleValue afterPointNumber:dotNumber];
    CGFloat centerWidth2 = [WLTools getWidthWithText:centerPriceString2 font:font] + ScaleW(5);
    
    [[UIColor redColor]setStroke];
    paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [paragraphStyle setAlignment:NSTextAlignmentRight];
    attribute = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor lxy_priceColor],NSParagraphStyleAttributeName:paragraphStyle};
    [centerPriceString2 drawInRect:CGRectMake(centerPositionModel2.centerX + ScaleW(2), self.height - kBottom_gap + (kBottom_gap - height) / 2, centerWidth2,height) withAttributes:attribute];
    
    
    NSString *maxPriceString = [WLTools roundingStringWith:self.maxPrice afterPointNumber:dotNumber];
    CGFloat maxWidth = [WLTools getWidthWithText:maxPriceString font:font] + ScaleW(5);
    
    [[UIColor redColor]setStroke];
    paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [paragraphStyle setAlignment:NSTextAlignmentRight];
    attribute = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor lxy_priceColor],NSParagraphStyleAttributeName:paragraphStyle};
    [maxPriceString drawInRect:CGRectMake(self.width - maxWidth, self.height - kBottom_gap + (kBottom_gap - height) / 2, maxWidth,height) withAttributes:attribute];
}

#pragma mark - 长按手势
-(void)longPressEvent:(UILongPressGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:self];
    
    LXY_DeepPosition_Model *longPressModel;
    
    double fabsX = 1000000;
    
    NSInteger type = 0; // 0 是buy 1 是sell
    
    
    for (int i = 0; i < self.buyPositionArray.count; i++) {
        LXY_DeepPosition_Model *positionModel = self.buyPositionArray[i];
        if (fabsX >  fabs(point.x - positionModel.centerX)) {
            fabsX = fabs(point.x - positionModel.centerX);
            longPressModel = positionModel;
            self.longPressModel = self.buyModelArray[i];
            type = 0;
        }
    }
    
    for (int i = 0; i < self.sellPositionArray.count; i++) {
        LXY_DeepPosition_Model *positionModel = self.sellPositionArray[i];
        if (fabsX >  fabs(point.x - positionModel.centerX)) {
            fabsX = fabs(point.x - positionModel.centerX);
            longPressModel = positionModel;
            self.longPressModel = self.sellModelArray[i];
            type = 1;
        }
    }
    
    self.longPressPositionModel = longPressModel;
    [self addLongPressViewWithType:type positionModel:self.longPressPositionModel];
    
    [self addSubview:self.longPressVolumeLabel];
    
    
//    NSArray *array = [[self.stockCode uppercaseString] componentsSeparatedByString:@"_"];
    
    NSString *string = [SSTool MarketPname:self.stockCode num:self.longPressModel.volume];
    CGFloat width = [WLTools getWidthWithText:string font:self.longPressVolumeLabel.font];
    self.longPressVolumeLabel.x = self.width - width - ScaleW(5);
    self.longPressVolumeLabel.width = width + ScaleW(5);
    self.longPressVolumeLabel.text = string;
    self.longPressVolumeLabel.centerY = self.longPressPositionModel.centerY;
    
    
    [self addSubview:self.longPressPriceLabel];
    string = [WLTools roundingStringWith:self.longPressModel.price.doubleValue afterPointNumber:[SSTool MarketPrice:self.stockCode]];
    width = [WLTools getWidthWithText:string font:self.longPressVolumeLabel.font] + ScaleW(5);
    self.longPressPriceLabel.centerX = self.longPressPositionModel.centerX;
    self.longPressPriceLabel.width = width + ScaleW(5);
    if (_longPressPriceLabel.x < 1) {
        _longPressPriceLabel.x = 1;
    }
    if (_longPressPriceLabel.right > self.width - 1) {
        _longPressPriceLabel.right = self.width - 1;
    }
    self.longPressPriceLabel.text = string;
}


#pragma mark - 点击手势
-(void)tapEvent:(UITapGestureRecognizer *)gesture
{
    if (self.longPressModel) {
        self.longPressModel = nil;
        [self.longPressView removeFromSuperview];
        [self.longPressVolumeLabel removeFromSuperview];
        [self.longPressPriceLabel removeFromSuperview];
        [self setNeedsDisplay];
    }
}

-(void)addLongPressViewWithType:(NSInteger)type positionModel:(LXY_DeepPosition_Model *)positionModel
{
    [self setNeedsDisplay];
    
    [self addSubview:self.longPressView];
    [_longPressView setType:type];
    _longPressView.center = CGPointMake(positionModel.centerX, positionModel.centerY);
}


// 长按时出现的小圆圈
-(LXY_Deep_LongPressView *)longPressView
{
    if (nil == _longPressView) {
        _longPressView = [[LXY_Deep_LongPressView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(15), ScaleW(15))];
    }
    return _longPressView;
}

// 长按时出现的销量label
- (UILabel *)longPressVolumeLabel
{
    if (nil == _longPressVolumeLabel) {
        _longPressVolumeLabel = [WLTools allocLabel:@"" font:systemFont(10) textColor:kTitleColor frame:CGRectMake(self.width - ScaleW(40), 0, ScaleW(40), ScaleW(15)) textAlignment:NSTextAlignmentRight];
        _longPressVolumeLabel.backgroundColor = [UIColor lxy_kLine_Main_BGColor];
        _longPressVolumeLabel.layer.borderWidth = 1.0f;
        _longPressVolumeLabel.layer.borderColor = [UIColor lxy_volumeColor].CGColor;
    }
    return _longPressVolumeLabel;
}
// 长按时出现的价格label
- (UILabel *)longPressPriceLabel
{
    if (nil == _longPressPriceLabel) {
        _longPressPriceLabel = [WLTools allocLabel:@"" font:systemFont(10) textColor:kTitleColor frame:CGRectMake(0, self.height - kBottom_gap, ScaleW(40), kBottom_gap - ScaleW(2)) textAlignment:NSTextAlignmentCenter];
        _longPressPriceLabel.backgroundColor = [UIColor lxy_kLine_Main_BGColor];
        _longPressPriceLabel.layer.borderWidth = 1.0f;
        _longPressPriceLabel.layer.borderColor = [UIColor lxy_volumeColor].CGColor;
    }
    return _longPressPriceLabel;
}

// 成交量格式转换
-(NSString *)volumeStringWithVolume:(NSString *)volume
{
    if (volume.doubleValue > 1000) {
        return [NSString stringWithFormat:@"%.2fk",volume.doubleValue];
    }else {
        return [NSString stringWithFormat:@"%.2f",volume.doubleValue];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) changeTitleForTimeHeyue{
    self.buyTitleLabel.text = SSKJLanguage(@"买涨");
    self.sellTitleLabel.text = SSKJLanguage(@"买跌");
}
- (void)changeTitleForHeyue{
    self.buyTitleLabel.text = SSKJLanguage(@"做多");
    self.sellTitleLabel.text = SSKJLanguage(@"做空");
}
- (void)changeUIPrice{
    [self drawPrice];
}

#pragma mark - 添加数据
-(void)setData:(NSDictionary *)data
{
    [self setData:data isLarge:NO];
}


@end
