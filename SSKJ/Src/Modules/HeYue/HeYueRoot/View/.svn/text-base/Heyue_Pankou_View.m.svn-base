//
//  Heyue_Pankou_View.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/26.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_Pankou_View.h"

#import "Heyue_Pankou_Cell.h"

#import "Heyue_Pankou_sectionView.h"

#import "SSKJ_PanKou_DotView.h"

static NSString * PankouCell = @"PankouCellID";

@interface Heyue_Pankou_View()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)SSKJ_PanKou_DotView *dotView;

@property (nonatomic,strong) UITableView *tableView;

@property(nonatomic, strong)Heyue_Pankou_sectionView *titleView;
@property(nonatomic, strong)UIView *priceView;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *cnyPriceLabel;

@property (nonatomic,strong) PanKou_Socket_Model *pankouModel1;

@property (nonatomic,strong) NSMutableArray * numberArr;

@property (nonatomic,strong) NSMutableArray * widArr;

@property (nonatomic,strong) NSMutableArray * rightnumberArr;

@property (nonatomic,strong) NSMutableArray * rightwidArr;

@property (nonatomic, strong) SSKJ_Market_Index_Model *model1;

@property(nonatomic)NSInteger rowNum;

@end

@implementation Heyue_Pankou_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.rowNum = 7;
        self.backgroundColor = kBgColor;
        [self addSubview:self.dotView];
        [self addSubview:self.tableView];
    }
    return self;
}

- (SSKJ_PanKou_DotView *)dotView{
    if (!_dotView) {
        _dotView = [[SSKJ_PanKou_DotView alloc] initWithFrame:CGRectMake(ScaleW(5), 0, self.width - ScaleW(5), ScaleW(1))];
        _dotView.hidden = YES;
    }
    return _dotView;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.dotView.bottom, self.width, self.height - self.dotView.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;   
        [_tableView registerClass:[Heyue_Pankou_Cell class] forCellReuseIdentifier:PankouCell];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rowNum;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (self.height - self.dotView.height - self.titleView.height - self.priceView.height) * 0.5 / self.rowNum;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.titleView;
    }else{
        
        return self.priceView;
    }
}

- (Heyue_Pankou_sectionView *)titleView{
    if (!_titleView) {
        _titleView = [[Heyue_Pankou_sectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth / 2, ScaleW(30))];
    }
    return _titleView;
}

- (UIView *)priceView{
    if (!_priceView) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, ScaleW(70))];
        UIView * topLine = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(2), self.width, ScaleW(.5f))];
        topLine.backgroundColor = kSubBgColor;
        
        UIView * bottonLine = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(67.5), self.width, ScaleW(.5f))];
        bottonLine.backgroundColor = kSubBgColor;
        
        NSString *price = [SSTool MarketPname:self.model1.code price:self.model1.price];
        
        UIColor *color = kMarketUp;
        if (_model1.change.doubleValue < 0) {
            color = kMarketDown;
        }
        self.priceLabel = [WLTools allocLabel:price font:kBoldFont(20) textColor:color frame:CGRectMake(ScaleW(8), ScaleW(16), self.width, ScaleW(24)) textAlignment:NSTextAlignmentLeft];
        self.priceLabel.adjustsFontSizeToFitWidth = YES;
        self.priceLabel.textColor = color;
        
        self.cnyPriceLabel = [WLTools allocLabel:[NSString stringWithFormat:@"≈%@CNY",[SSTool disposePname:@"cny" price:self.model1.cnyPrice]] font:systemFont(ScaleW(11)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(10), ScaleW(43), self.width, ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        
        [view addSubview:self.priceLabel];
        [view addSubview:self.cnyPriceLabel];
        [view addSubview:topLine];
        [view addSubview:bottonLine];
        _priceView = view;
    }
    return _priceView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.titleView.height;
    }else{
        return self.priceView.height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        Heyue_Pankou_Cell *pankouCell = [tableView dequeueReusableCellWithIdentifier:PankouCell forIndexPath:indexPath];
        pankouCell.priceLabel.textColor = kMarketDown;
        pankouCell.noLabel.text = [NSString stringWithFormat:@"%ld",self.rowNum-indexPath.row];
        if (self.pankouModel1.asks.count > 0) {
            PanKou_Socket_Price_Model * model = [[PanKou_Socket_Price_Model mj_objectArrayWithKeyValuesArray:self.pankouModel1.asks] objectAtIndex:self.rowNum - 1 - indexPath.row];
            
            pankouCell.priceLabel.text = [SSTool MarketPname:self.pankouModel1.code price:model.price];
            pankouCell.numberLabel.text = [WLTools noroundingStringWith:model.totalSize.doubleValue afterPointNumber:0];
//            pankouCell.numberLabel.text = [SSTool disposeZeroPname:@"4" price:model.totalSize];
        }
        
        pankouCell.bgView.backgroundColor = [kMarketDown colorWithAlphaComponent:0.3];
        if (indexPath.row < self.rightwidArr.count) {
            [pankouCell.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@([self.rightwidArr[indexPath.row] doubleValue]));
            }];
        }
        
        return pankouCell;
    }else {
        
        Heyue_Pankou_Cell *pankouCell = [tableView dequeueReusableCellWithIdentifier:PankouCell];
        pankouCell.priceLabel.textColor = kMarketUp;
        pankouCell.noLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row + 1];
        if (self.pankouModel1.bids.count > 0) {
            PanKou_Socket_Price_Model * model = [[PanKou_Socket_Price_Model mj_objectArrayWithKeyValuesArray:self.pankouModel1.bids] objectAtIndex: indexPath.row];

            
            pankouCell.priceLabel.text = [SSTool MarketPname:self.pankouModel1.code price:model.price];
            
                        pankouCell.numberLabel.text = [WLTools noroundingStringWith:model.totalSize.doubleValue afterPointNumber:0];
//            pankouCell.numberLabel.text = [SSTool disposeZeroPname:@"4" price:model.totalSize];

        }
        
        pankouCell.bgView.backgroundColor = [kMarketUp colorWithAlphaComponent:0.3];

        if (indexPath.row < self.widArr.count) {
            [pankouCell.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@([self.widArr[indexPath.row] doubleValue]));
            }];
        }
        
        return pankouCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PanKou_Socket_Price_Model * model;
    if (indexPath.section == 1) {
        model = [[PanKou_Socket_Price_Model mj_objectArrayWithKeyValuesArray:self.pankouModel1.bids] objectAtIndex: indexPath.row];

    }else{
        model = [[PanKou_Socket_Price_Model mj_objectArrayWithKeyValuesArray:self.pankouModel1.asks] objectAtIndex:self.rowNum - 1 - indexPath.row];
    }
    

    NSString *price = [SSTool HeyueCoin:self.pankouModel1.code price:model.price];
    
    if (self.CurrentPriceBlock) {
        self.CurrentPriceBlock(price);
    }
}

- (void)setPankouModel:(PanKou_Socket_Model *)pankouModel{
    self.pankouModel1 = pankouModel;
    [self.numberArr removeAllObjects];
    
    [self.widArr removeAllObjects];
    
    [self.rightwidArr removeAllObjects];
    
    [self.rightnumberArr removeAllObjects];
    
    for (int i = 0 ; i< 7; i++) {
        if (pankouModel.bids.count <= i) {
            break;
        }
        PanKou_Socket_Price_Model *model = [[PanKou_Socket_Price_Model mj_objectArrayWithKeyValuesArray:pankouModel.bids] objectAtIndex:i];
        [self.numberArr addObject:[NSNumber numberWithFloat:model.totalSize.floatValue]];
    }
    
    for (int i = 0 ; i< 7; i++) {
        if (pankouModel.bids.count <= i) {
            break;
        }
        PanKou_Socket_Price_Model *model = [[PanKou_Socket_Price_Model mj_objectArrayWithKeyValuesArray:pankouModel.asks] objectAtIndex:self.rowNum - 1 - i];
        [self.rightnumberArr addObject:[NSNumber numberWithFloat:model.totalSize.floatValue]];
    }
    
    NSMutableArray * totalArr = [NSMutableArray array];
    
    [totalArr addObjectsFromArray:self.numberArr];
    
    [totalArr addObjectsFromArray:self.rightnumberArr];
    
    CGFloat maxValue = [[totalArr valueForKeyPath:@"@max.doubleValue"] floatValue];
    
    for (NSString * numberstr in self.numberArr) {
        
        CGFloat width = ((ScreenWidth / 2) - ScaleW(30)) * (numberstr.doubleValue / maxValue);
        
        [self.widArr addObject:[NSString stringWithFormat:@"%f",width]];
    }
    
    for (NSString * numberstr in self.rightnumberArr) {
        
        CGFloat width = ((ScreenWidth / 2) - ScaleW(30)) * (numberstr.doubleValue / maxValue);
        
        [self.rightwidArr addObject:[NSString stringWithFormat:@"%f",width]];
    }
    
    [self.tableView reloadData];
}

- (void)setModel:(SSKJ_Market_Index_Model *)model{
    self.model1 = model;

    NSString *price = [SSTool MarketPname:self.model1.code price:self.model1.price];
    UIColor *color = kMarketUp;
    if (_model1.change.doubleValue < 0) {
        color = kMarketDown;
    }
    self.priceLabel.text = price;
    self.priceLabel.textColor = color;
    
    self.cnyPriceLabel.text = [NSString stringWithFormat:@"≈%@CNY",[SSTool disposePname:@"cny" price:self.model1.cnyPrice]];
    
    self.cnyPriceLabel.text = [NSString stringWithFormat:@"≈ %@ CNY", [WLTools noroundingStringWith:model.cnyPrice.doubleValue afterPointNumber:2]];
  
    
    self.dotView.coin = model.code;
}

- (NSMutableArray *)numberArr{
    if (_numberArr == nil) {
        _numberArr = [NSMutableArray array];
    }
    return _numberArr;
}

- (NSMutableArray *)widArr{
    if (_widArr == nil) {
        _widArr = [NSMutableArray array];
    }
    return _widArr;
}

- (NSMutableArray *)rightnumberArr{
    if (_rightnumberArr == nil) {
        _rightnumberArr = [NSMutableArray array];
    }
    return _rightnumberArr;
}

- (NSMutableArray *)rightwidArr{
    if (_rightwidArr == nil) {
        _rightwidArr = [NSMutableArray array];
    }
    return _rightwidArr;
}

@end
