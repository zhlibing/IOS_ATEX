//
//  GoCoin_ZiXun_ViewController.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/3/28.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "News_Root_ViewController.h"

#import "News_SystemConsult_VC.h"//系统资讯

#import "News_TradingGuide_VC.h"//交易指南

#import "SSKJ_Nav_SegmentView.h"


@interface News_Root_ViewController ()<UIScrollViewDelegate>


@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)News_SystemConsult_VC *newsVc;

@property (nonatomic,strong)News_TradingGuide_VC *noticeVc;


@property (nonatomic, strong) SSKJ_Nav_SegmentView *segmentView;


@end

@implementation News_Root_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)setUI{
    self.navigationItem.titleView = self.segmentView;
    [self scrollView];
}


- (UIScrollView *)scrollView{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(@0);
            make.top.equalTo(@(Height_NavBar));
            make.bottom.equalTo(@0);
        }];
        
        if (@available(iOS 11.0, *)){
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }

        _scrollView.contentSize = CGSizeMake(ScreenWidth * 2, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = kBgColor;
        
        self.newsVc = [[News_SystemConsult_VC alloc]init];
        [self addChildViewController:self.newsVc];
        [_scrollView addSubview:self.newsVc.view];
        
        self.noticeVc = [[News_TradingGuide_VC alloc]init];
        [self addChildViewController:self.noticeVc];
        [_scrollView addSubview:self.noticeVc.view];
        
        
        [self.newsVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(@0);
            make.width.equalTo(@(ScreenWidth));
            make.height.equalTo(@(ScreenHeight - Height_NavBar - Height_TabBar));
        }];
        
        [self.noticeVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.newsVc.view);
            make.left.equalTo(self.newsVc.view.mas_right);
            make.width.height.equalTo(self.newsVc.view);
        }];
        
        
    }
    return _scrollView;
}

-(SSKJ_Nav_SegmentView *)segmentView
{
    if (nil == _segmentView) {
        _segmentView = [[SSKJ_Nav_SegmentView alloc]initWithFrame:CGRectMake((ScreenWidth-ScaleW(160))/2, Height_NavBar - 10 - 30, ScaleW(160), 30) titles:@[SSKJLocalized(@"行业资讯", nil),SSKJLocalized(@"交易指南", nil)] normalColor:kBlueColor selectedColor:kTitleColor fontSize:ScaleW(13.5)];
        WS(weakSelf);
        _segmentView.selectedIndexBlock = ^BOOL(NSInteger index) {

            CGPoint offsize = weakSelf.scrollView.contentOffset;
            offsize.x = index * ScreenWidth;
            [weakSelf.scrollView setContentOffset:offsize animated:YES];
            
            return YES;
        };
        
    }
    return _segmentView;
}


#pragma mark - scroll delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    
    if (offset.x < 0) {
        return;
    }

    [self.segmentView setSelectedIndex:offset.x/ScreenWidth];

}

@end
