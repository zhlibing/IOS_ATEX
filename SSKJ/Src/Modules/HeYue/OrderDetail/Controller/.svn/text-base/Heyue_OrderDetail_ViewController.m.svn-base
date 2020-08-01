//
//  Heyue_OrderDetail_ViewController.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_OrderDetail_ViewController.h"

#import "Heyue_orderDetail_headerView.h"

#import "NinaPagerView.h"

#import "Heyue_ChiCang_Order_VC.h"

#import "Heyue_WeiTuo_Order_VC.h"

#import "Heyue_CengJiao_Order_VC.h"

#import "Heyue_OrderInfo_Model.h"

@interface Heyue_OrderDetail_ViewController ()<NinaPagerViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) Heyue_orderDetail_headerView *headerView;

@property (nonatomic, strong) Home_Segment_View *segmentControl;
@property (nonatomic, strong) UIScrollView *scrollView;


@property (nonatomic, strong) NinaPagerView *ninaPagerView;

@property (nonatomic, strong) Heyue_ChiCang_Order_VC *chicangVC;

@property (nonatomic, strong) Heyue_WeiTuo_Order_VC *weituoVC;

@property (nonatomic, strong) Heyue_CengJiao_Order_VC *chengjiaoVC;

//自动刷新Timer
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation Heyue_OrderDetail_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = SSKJLocalized(@"订单明细", nil);
    self.view.backgroundColor = kBgColor;
    [self.view addSubview:self.headerView];
//    [self ninaPagerView];
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.scrollView];
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(timerRefreash:) userInfo:nil repeats:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setNavgationBackgroundColor:kSubBgColor alpha:1];

}

-(void)timerRefreash:(NSTimer *)timer{
    [self request_Tongji_URL];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self request_Tongji_URL];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_timer invalidate];
    _timer = nil;
}

- (Heyue_orderDetail_headerView *)headerView{
    if (_headerView == nil) {
        _headerView = [[Heyue_orderDetail_headerView alloc]initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScaleW(175))];
    }
    return _headerView;
}

- (NinaPagerView *) ninaPagerView
{
    if (!_ninaPagerView)
    {
        //持仓
        self.chicangVC= [[Heyue_ChiCang_Order_VC alloc]init];
        WS(weakSelf);
        self.chicangVC.updateBlock = ^(NSArray * array) {
            [weakSelf.headerView updateWith:array];
        };
        
        //委托
        self.weituoVC = [[Heyue_WeiTuo_Order_VC alloc]init];
//        self.weituoVC.model = self.model;

        //成交
        self.chengjiaoVC = [[Heyue_CengJiao_Order_VC alloc]init];
//        self.chengjiaoVC.model = self.model;

        NSArray *controllers=@[self.chicangVC,
                               self.weituoVC,
                               self.chengjiaoVC
                               ];

        NSArray *titleArray =@[SSKJLocalized(@"持仓", nil),
                               SSKJLocalized(@"委托", nil),
                               SSKJLocalized(@"成交", nil)
                               ];
        _ninaPagerView = [[NinaPagerView alloc]initWithFrame:CGRectMake(0, _headerView.bottom + ScaleW(10), ScreenWidth, ScreenHeight  - _headerView.bottom - Height_NavBar) WithTitles:titleArray WithObjects:controllers];
        
        _ninaPagerView.topTabBackGroundColor = kSubBgColor;
        
        _ninaPagerView.topTabHeight = ScaleW(45);
        
        _ninaPagerView.titleFont = ScaleW(15);
        
        
        _ninaPagerView.selectTitleColor = kBlueColor;
        _ninaPagerView.unSelectTitleColor = kTitleColor;

        _ninaPagerView.underlineColor = kBlueColor;
        
        _ninaPagerView.nina_autoBottomLineEnable = YES;
        
        _ninaPagerView.nina_scrollEnabled = YES;
        
        _ninaPagerView.delegate = self;
        
        _ninaPagerView.ninaDefaultPage = self.seletedIndex;
        
        _ninaPagerView.selectBottomLinePer = .2;
        
        _ninaPagerView.selectBottomLineHeight = ScaleW(2);
                
        [self.view addSubview:_ninaPagerView];
    }
    return _ninaPagerView;
}

- (void)ninaCurrentPageIndex:(NSInteger)currentPage currentObject:(id)currentObject lastObject:(id)lastObject
{
    
    switch (currentPage) {
        case 0:
        {
            [self.chicangVC openTimer];

            [self.weituoVC closetimer];
        }
            break;
        case 1:
        {
            [self.weituoVC openTimer];
            
            [self.chicangVC closetimer];
        }
            break;
        case 2:
        {
            [self.chicangVC closetimer];
            
            [self.weituoVC closetimer];
            
            [self.chengjiaoVC beginrefreashData];
        }
            break;
            
            
        default:
            break;
    }
}


-(Home_Segment_View *)segmentControl
{
    if (nil == _segmentControl) {
        
        _segmentControl = [[Home_Segment_View alloc]initWithFrame:CGRectMake(0, self.headerView.bottom + ScaleW(10), ScreenWidth, ScaleW(40)) titles:@[SSKJLocalized(@"持仓", nil),SSKJLocalized(@"委托", nil),SSKJLocalized(@"成交", nil)] normalColor:kTitleColor selectedColor:kBlueColor fontSize:ScaleW(15)];
        [_segmentControl setBackgroundColor:kSubBgColor];
        
        WS(weakSelf);
        _segmentControl.selectedIndexBlock = ^(NSInteger index) {
            
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.scrollView.contentOffset = CGPointMake(ScreenWidth * index, 0);
            }];
            [weakSelf setCurrentIndex:index];
            return YES;
        };
        
    }
    return _segmentControl;
}


- (UIScrollView *)scrollView{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.segmentControl.bottom + ScaleW(2), ScreenWidth, ScreenHeight - self.segmentControl.bottom - ScaleW(2))];
        [self.view addSubview:_scrollView];

        
        if (@available(iOS 11.0, *)){
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }

        _scrollView.contentSize = CGSizeMake(ScreenWidth * 3, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = kBgColor;
        
        
        self.chicangVC= [[Heyue_ChiCang_Order_VC alloc]init];
        [self addChildViewController:self.chicangVC];
        [self.scrollView addSubview:self.chicangVC.view];
        self.chicangVC.view.frame = CGRectMake(0, 0, ScreenWidth, self.scrollView.height);
        WS(weakSelf);
        self.chicangVC.updateBlock = ^(NSArray * array) {
            [weakSelf.headerView updateWith:array];
        };
        
        //委托
        self.weituoVC = [[Heyue_WeiTuo_Order_VC alloc]init];
        [self addChildViewController:self.weituoVC];
        [self.scrollView addSubview:self.weituoVC.view];
        self.weituoVC.view.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, self.scrollView.height);

        //成交
        self.chengjiaoVC = [[Heyue_CengJiao_Order_VC alloc]init];
        [self.scrollView addSubview:self.chengjiaoVC.view];
        [self addChildViewController:self.chengjiaoVC];
        self.chengjiaoVC.view.frame = CGRectMake(ScreenWidth * 2, 0, ScreenWidth, self.scrollView.height);
        
    }
    return _scrollView;
}

#pragma mark -- 网络请求 浮动盈亏 爆仓率 --
- (void)request_Tongji_URL{
    
    //Heyue_Tongji_Api
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_HEYUE_Info_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200) {
            Heyue_OrderInfo_Model *model = [Heyue_OrderInfo_Model mj_objectWithKeyValues:netModel.data];
            
            [self.headerView initDataWithOrderInfoModel:model];
            
            
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
    }];
}


#pragma mark - scroll delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    
    if (offset.x < 0) {
        return;
    }

    self.segmentControl.selectedIndex = offset.x/ScreenWidth;
    
    [self setCurrentIndex:self.segmentControl.selectedIndex];

}


-(void)setCurrentIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            [self.chicangVC openTimer];

            [self.weituoVC closetimer];
        }
            break;
        case 1:
        {
            [self.weituoVC openTimer];
            
            [self.chicangVC closetimer];
        }
            break;
        case 2:
        {
            [self.chicangVC closetimer];
            
            [self.weituoVC closetimer];
            
            [self.chengjiaoVC beginrefreashData];
        }
            break;
            
            
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
