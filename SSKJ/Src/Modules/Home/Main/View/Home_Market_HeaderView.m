//
//  Hebi_Market_HeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/9.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "Home_Market_HeaderView.h"
#import "SDCycleScrollView.h"
#import "SSKJ_Market_Index_Model.h"
#import "Home_Coin_View.h"

@interface Home_Market_HeaderView ()<SDCycleScrollViewDelegate>


@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) SDCycleScrollView *bannerView;    // 轮播图

@property(nonatomic, strong)UIView *coinView;
@property(nonatomic, strong)Home_Coin_View *coinContentView;

@property (nonatomic, strong) UIImageView *leftImageView;


@end

@implementation Home_Market_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        self.backgroundColor = kBgColor;
    }
    return self;
}


#pragma mark - UI
-(void)setUI
{
    // 轮播图
//    [self addSubview:self.backImageView];
    [self addSubview:self.bannerView];
    
    // 通知
    [self addSubview:self.noticeView];

    [self addSubview:self.coinView];
    [self setupCoinView];
    
    [self addSubview:self.leftImageView];
    
    self.height = self.leftImageView.bottom + ScaleW(10);

}

-(UIImageView *)backImageView
{
    if (nil == _backImageView) {
        _backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(300) + Height_StatusBar)];
        _backImageView.image = UIImageNamed(@"home_bg");
    }
    return _backImageView;
}

#pragma mark - 播视图
-(SDCycleScrollView *)bannerView
{
    if (_bannerView==nil)
    {

        CGFloat width = ScreenWidth - ScaleW(28);
        _bannerView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(ScaleW(14),ScaleW(0), width, width * 9/16.0) delegate:self placeholderImage:[UIImage imageNamed:@"banner_default"]];
        _bannerView.backgroundColor = [UIColor clearColor];
        _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        
        _bannerView.delegate = self;
        
        _bannerView.autoScrollTimeInterval = 3.0;
        
        _bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
        
//        _bannerView.currentPageDotImage = [UIImage imageNamed:@"lunbo_selected"];
//
//        _bannerView.pageDotImage = [UIImage imageNamed:@"lunbo_normal"];
        _bannerView.layer.masksToBounds = YES;
        _bannerView.layer.cornerRadius = ScaleW(10);
    }
    
    return _bannerView;
}

-(UIView *)coinView
{
    if (nil == _coinView) {
        _coinView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(0), self.noticeView.bottom, ScreenWidth, ScaleW(120))];
        _coinView.backgroundColor = kBgColor;
    }
    return _coinView;
}
- (void)setupCoinView{
    _coinContentView = [[Home_Coin_View alloc] initWithFrame:CGRectMake(0, ScaleW(10), self.coinView.width, self.coinView.height - ScaleW(20))];
    [self.coinView addSubview:_coinContentView];

    WS(weakSelf);
    _coinContentView.selectBlock = ^(NSInteger index) {
        if (weakSelf.hotCoinBlock) {
            weakSelf.hotCoinBlock(weakSelf.coinArray[index]);
        }
    };
    
}

-(SSKJ_ScrollNotice_View *)noticeView
{
    if (nil == _noticeView) {
        _noticeView = [[SSKJ_ScrollNotice_View alloc]initWithFrame:CGRectMake(0, self.bannerView.bottom, ScreenWidth, ScaleW(45))];
        [_noticeView setIsMainPage];
        WS(weakSelf);
        _noticeView.clickBlock = ^(NSInteger index) {
            if (weakSelf.noticeBlock) {
                weakSelf.noticeBlock(index);
            }
        };
        
        _noticeView.moreBlock = ^{
            if (weakSelf.noticeMoreBlock) {
                weakSelf.noticeMoreBlock();
            }
        };
    }
    return _noticeView;
}


-(UIImageView *)leftImageView
{
    if (nil == _leftImageView) {
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), self.coinView.bottom, ScreenWidth - ScaleW(30), ScaleW(80))];
        _leftImageView.userInteractionEnabled = YES;
        _leftImageView.layer.masksToBounds = YES;
        _leftImageView.layer.cornerRadius = ScaleW(5);
        
        _leftImageView.image = UIImageNamed(SSKJLocalized(@"home_invicate", nil));
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(invicateEvent)];
        [_leftImageView addGestureRecognizer:tap];
       
        
    }
    return _leftImageView;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.bannerBlock) {
        self.bannerBlock(index);
    }
}

#pragma mark - 用户操作


-(void)invicateEvent
{
    if (self.invicateBlock) {
        self.invicateBlock();
    }
}

-(void)hotCoinClickEvent:(SSKJ_Market_Index_Model *)coinModel
{
    if (self.hotCoinBlock) {
        self.hotCoinBlock(coinModel);
    }
}


#pragma mark - 推送数据

-(void)setCoinArray:(NSArray *)coinArray
{
    _coinArray = coinArray;
    self.coinContentView.array = coinArray;
}

-(void)setBannerArray:(NSArray *)bannerArray
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    
    for (Home_MarketBanner_Model *model in bannerArray)
    {
//        [array addObject:[WLTools imageURLWithURL:model.image]];
        [array addObject:model.image];
    }
    
    self.bannerView.imageURLStringsGroup = array;
}

-(void)setNoticeArray:(NSArray *)noticeArray
{
    
    NSMutableArray *array = [NSMutableArray array];
    for (Home_NoticeIndex_Model *noticeModel in noticeArray) {
        
        [array addObject:noticeModel.title];

    }
    
    [self.noticeView configureModels:array];
}




@end
