//
//  STO_BB_DepthView.m
//  SSKJ
//
//  Created by zpz on 2019/7/30.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "STO_BB_DepthView.h"
#import "LXY_DeepView.h"
#import "LXY_DeepModel.h"
static NSString *cellid = @"STO_BB_DepthViewCell";


@interface STO_BB_DepthView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong)UIView *depthView;
@property (nonatomic, strong) LXY_DeepView *deepView;// 深度图

@property(nonatomic, strong)NSArray *array;

@property(nonatomic, strong)UILabel *headerBuyCoin;
@property(nonatomic, strong)UILabel *headerSellCoin;
@property(nonatomic, strong)UILabel *headerPriceCoin;
@end

@implementation STO_BB_DepthView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBgColor;
        [self depthView];
        [self tableView];
    }
    return self;
}

- (void)setArray:(NSArray *)array{
    _array = array;
    [self.tableView reloadData];
    self.tableView.height = ScaleW(24) * array.count + ScaleW(40);
    self.height = self.depthView.height + self.tableView.height;
}

- (UIView *)depthView{
    if (!_depthView) {
        _depthView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(200))];
        [self addSubview:_depthView];
        
        _deepView = [[LXY_DeepView alloc]initWithFrame:_depthView.bounds];
        [_deepView changeTitleForHeyue];
        [_depthView addSubview:_deepView];
    }
    return _depthView;
}


-(void)setDeepData:(NSDictionary *)deepData
{
    [self.deepView setData:deepData isLarge:YES];
//    deepData[@"code"]
    NSArray *coin = [[deepData[@"code"] uppercaseString]  componentsSeparatedByString:@"_"];
    self.headerBuyCoin.text = [NSString stringWithFormat:@"%@(%@)", SSKJLanguage(@"数量"), coin.firstObject];
    self.headerSellCoin.text = [NSString stringWithFormat:@"%@(%@)", SSKJLanguage(@"数量"), coin.firstObject];
    self.headerPriceCoin.text = [NSString stringWithFormat:@"%@(%@)", SSKJLanguage(@"价格"), coin.lastObject];

    NSArray *buyArray = [LXY_DeepModel mj_objectArrayWithKeyValuesArray:deepData[@"bids"]];
    NSArray *sellArray = [LXY_DeepModel mj_objectArrayWithKeyValuesArray:deepData[@"asks"]];
    NSInteger count = MIN(buyArray.count, sellArray.count);
    count = MIN(count, 30);
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:count];
    for (int i =0; i < count; i++) {
        LXY_DeepModel *buy = buyArray[i];
        LXY_DeepModel *sell = sellArray[i];
        NSMutableDictionary *info = [NSMutableDictionary dictionary];
        info[@"index"] = [NSString stringWithFormat:@"%d", i + 1];
        NSString *code = deepData[@"code"];

        
        info[@"buyNum"] = [SSTool MarketPname:code num:buy.volume];
        info[@"buyPrice"] = [SSTool MarketPname:code price:buy.price];
        info[@"sellNum"] = [SSTool MarketPname:code num:sell.volume];
        info[@"sellPrice"] = [SSTool MarketPname:code price:sell.price];
        [arr addObject:info];
    }
    self.array = [arr copy];
}


-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _depthView.bottom, self.width, self.height - self.depthView.height) style:UITableViewStyleGrouped];
        [self addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kBgColor;
        _tableView.rowHeight = ScaleW(24);
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(40))];
        header.backgroundColor = kBgColor;
        _tableView.tableHeaderView = header;

        UILabel *maiLable = [self getHeaderLabel];
        maiLable.frame = CGRectMake(ScaleW(13), 0, ScaleW(26), header.height);
        maiLable.text = SSKJLanguage(@"买盘");
        [header addSubview:maiLable];
        
        UILabel *maiNumLable = [self getHeaderLabel];
        maiNumLable.frame = CGRectMake(maiLable.right, 0, ScaleW(70), header.height);
        maiNumLable.text = SSKJLanguage(@"数量(BTC)");
        maiNumLable.textAlignment = NSTextAlignmentCenter;
        [header addSubview:maiNumLable];
        self.headerBuyCoin = maiNumLable;
        
        UILabel *priceLable = [self getHeaderLabel];
        priceLable.frame = CGRectMake(maiNumLable.right, 0, ScreenWidth - maiNumLable.right * 2, header.height);
        priceLable.text = SSKJLanguage(@"价格(USDT)");
        priceLable.textAlignment = NSTextAlignmentCenter;
        [header addSubview:priceLable];
        self.headerPriceCoin = priceLable;
        
        UILabel *maiiNumLable = [self getHeaderLabel];
        maiiNumLable.frame = CGRectMake(priceLable.right, 0, ScaleW(70), header.height);
        maiiNumLable.text = SSKJLanguage(@"数量(BTC)");
        maiiNumLable.textAlignment = NSTextAlignmentCenter;
        [header addSubview:maiiNumLable];
        self.headerSellCoin = maiiNumLable;
        
        UILabel *maiiLable = [self getHeaderLabel];
        maiiLable.frame = CGRectMake(maiiNumLable.right, 0, ScaleW(26), header.height);
        maiiLable.text = SSKJLanguage(@"卖盘");
        maiiLable.textAlignment = NSTextAlignmentRight;
        [header addSubview:maiiLable];
        
        [_tableView registerClass:[STO_BB_DepthViewCell class] forCellReuseIdentifier:cellid];
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        _tableView.scrollEnabled = NO;
        
    }
    return _tableView;
}


- (UILabel *)getHeaderLabel{
    UILabel *label = [WLTools allocLabel:nil font:kFont(10) textColor:kSubTitleColor frame:CGRectZero textAlignment:(NSTextAlignmentLeft)];
    label.numberOfLines = 1;
    label.adjustsFontSizeToFitWidth = YES;
    return label;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    STO_BB_DepthViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    NSDictionary *info = self.array[indexPath.row];
    cell.maiLabel.text = info[@"index"];
    cell.maiNumLabel.text = info[@"buyNum"];
    cell.maiPriceLabel.text = info[@"buyPrice"];
    cell.mLabel.text = info[@"index"];
    cell.mNumLabel.text = info[@"sellNum"];
    cell.mPriceLabel.text = info[@"sellPrice"];

    return cell;
    
}



@end


@implementation STO_BB_DepthViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    self.maiLabel = [self getContentLabel];
    self.maiLabel.frame = CGRectMake(ScaleW(13), 0, ScaleW(26), ScaleW(24));
    [self.contentView addSubview:self.maiLabel];
    
    self.maiNumLabel = [self getContentLabel];
    self.maiNumLabel.frame = CGRectMake(self.maiLabel.right, 0, ScaleW(70), ScaleW(24));
    self.maiNumLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.maiNumLabel];
    
    self.maiPriceLabel = [self getContentLabel];
    self.maiPriceLabel.frame = CGRectMake(self.maiNumLabel.right, 0, ScreenWidth * 0.5 - self.maiNumLabel.right - ScaleW(10), ScaleW(24));
    self.maiPriceLabel.textAlignment = NSTextAlignmentRight;
//    self.maiPriceLabel.textColor = [kSubTitleColor colorWithMultiplier:0.8];
    [self.contentView addSubview:self.maiPriceLabel];
    
    self.mPriceLabel = [self getContentLabel];
    self.mPriceLabel.frame = CGRectMake(self.maiPriceLabel.right + ScaleW(20), 0, self.maiPriceLabel.width, ScaleW(24));
    [self.contentView addSubview:self.mPriceLabel];
    
    self.mNumLabel = [self getContentLabel];
    self.mNumLabel.frame = CGRectMake(self.mPriceLabel.right, 0, self.maiNumLabel.width, ScaleW(24));
    self.mNumLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.mNumLabel];
    
    self.mLabel = [self getContentLabel];
    self.mLabel.frame = CGRectMake(self.mNumLabel.right, 0, self.maiLabel.width, ScaleW(24));
    self.mLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.mLabel];
    
    self.maiPriceLabel.textColor = kMarketUp;
    self.mPriceLabel.textColor = kMarketDown;

}


- (UILabel *)getContentLabel{
    UILabel *label = [WLTools allocLabel:nil font:kFont(12) textColor:kTitleColor frame:CGRectZero textAlignment:(NSTextAlignmentLeft)];
    label.numberOfLines = 1;
    label.adjustsFontSizeToFitWidth = YES;
    return label;
}

@end
