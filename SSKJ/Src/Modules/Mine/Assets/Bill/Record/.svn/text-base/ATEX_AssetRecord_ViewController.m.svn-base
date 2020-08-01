//
//  ATEX_AssetRecord_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/16.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "ATEX_AssetRecord_ViewController.h"
#import "ATEX_ChargeRecord_ViewController.h"
#import "ATEX_ExtractRecord_ViewController.h"
#import "ATEX_OtherRecord_ViewController.h"
#import "Home_Segment_View.h"
@interface ATEX_AssetRecord_ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) Home_Segment_View *segmentControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ATEX_ChargeRecord_ViewController *chargeVc;
@property (nonatomic, strong) ATEX_ExtractRecord_ViewController *extractVc;
@property (nonatomic, strong) ATEX_OtherRecord_ViewController *otherVc;


@end

@implementation ATEX_AssetRecord_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavgationBackgroundColor:kSubBgColor alpha:0];
    self.navigationItem.titleView = self.segmentControl;
        
    [self.view addSubview:self.scrollView];
    
    self.segmentControl.selectedIndex = (NSInteger)(self.assetType);
    
    self.scrollView.contentOffset = CGPointMake(ScreenWidth * self.segmentControl.selectedIndex, 0);

}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


-(Home_Segment_View *)segmentControl
{
    if (nil == _segmentControl) {
        
        _segmentControl = [[Home_Segment_View alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - ScaleW(150), ScaleW(40)) titles:@[SSKJLocalized(@"充币记录", nil),SSKJLocalized(@"提币记录", nil),SSKJLocalized(@"其他", nil)] normalColor:kTitleColor selectedColor:kBlueColor fontSize:ScaleW(15)];
        [_segmentControl setBackgroundColor:kBgColor];
        
        WS(weakSelf);
        _segmentControl.selectedIndexBlock = ^(NSInteger index) {
            weakSelf.scrollView.contentOffset = CGPointMake(ScreenWidth * index, 0);
            [weakSelf setIndex:index];

            return YES;
        };
        
    }
    return _segmentControl;
}


- (UIScrollView *)scrollView{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
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
        
        self.chargeVc = [[ATEX_ChargeRecord_ViewController alloc]init];
        [self addChildViewController:self.chargeVc];
        self.chargeVc.view.frame = CGRectMake(0, 0, ScreenWidth, self.scrollView.height);
        [_scrollView addSubview:self.chargeVc.view];
        
        self.extractVc = [[ATEX_ExtractRecord_ViewController alloc]init];
        [self addChildViewController:self.extractVc];
        self.extractVc.view.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, self.scrollView.height);
        [_scrollView addSubview:self.extractVc.view];
        
        self.otherVc = [[ATEX_OtherRecord_ViewController alloc]init];
        [self addChildViewController:self.otherVc];
        self.otherVc.view.frame = CGRectMake(ScreenWidth * 2, 0, ScreenWidth, self.scrollView.height);
        [_scrollView addSubview:self.otherVc.view];
        
        
    }
    return _scrollView;
}

-(void)setIndex:(NSInteger)index
{
    if (index == 0) {
        [self.chargeVc viewWillAppear:YES];
    }else if (index == 1){
        [self.extractVc viewWillAppear:YES];
    }else{
        [self.otherVc viewWillAppear:YES];
    }
}


#pragma mark - scroll delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    
    if (offset.x < 0) {
        return;
    }

    self.segmentControl.selectedIndex = offset.x/ScreenWidth;

    [self setIndex:self.segmentControl.selectedIndex];
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
