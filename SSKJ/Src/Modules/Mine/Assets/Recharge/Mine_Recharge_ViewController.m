//
//  My_Charge_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "Mine_Recharge_ViewController.h"
#import "Mine_RechargeTop_View.h"
#import "Home_Segment_View.h"
#import "Mine_BindGoogle_AlertView.h"
#import "ATEX_AssetRecord_ViewController.h"
#import "RechargeModel.h"





@interface Mine_Recharge_ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) Mine_RechargeTop_View *chargeView;  //!< 充币地址，上部分内容

@property (nonatomic, strong) UILabel *warnTitleLabel;
@property (nonatomic, strong) UILabel *warnLabel;

@property(nonatomic, strong)Home_Segment_View *segmentControl;
@property(nonatomic, strong)UIView *segmentView;


@property (nonatomic, strong) NSMutableArray *rechargeArray; //!< 充值数组



@end

@implementation Mine_Recharge_ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBgColor;    
    self.title = SSKJLanguage(@"充币");

    
    [self addRightNavgationItemWithImage:UIImageNamed(@"充币--记录")];
    
    [self requestAddress];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)rigthBtnAction:(id)sender{
    ATEX_AssetRecord_ViewController *vc = [ATEX_AssetRecord_ViewController new];
    vc.assetType = AssetTypeCharge;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)selectCoin:(NSInteger)index
{
    RechargeModel *model = [self.rechargeArray objectAtIndex:index];
    [self.chargeView setAddress:model.address];
    [self.chargeView.qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:model.qrcode]];
    
}

#pragma mark - setUI

-(void)setUI
{
//    self.navigationItem.titleView = self.mainTitleView;
    
//    self.title = self.assetModel.stockCode;
    
    [self.view addSubview:self.scrollView];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(15), ScaleW(10), ScreenWidth - ScaleW(30), ScaleW(50))];
    view.backgroundColor = kSubBgColor;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = ScaleW(5);
    [self.scrollView addSubview:view];
    [view addSubview:self.segmentControl];
    self.segmentView = view;
    [self.scrollView addSubview:self.chargeView];
    [self.scrollView addSubview:self.warnTitleLabel];
    [self.scrollView addSubview:self.warnLabel];
    _warnTitleLabel.hidden = YES;
    
    self.warnLabel.text = SSKJLanguage(@"请勿向上述地址充值任何非USDT资产，否则资产将不可找回。 您充值至上述地址后，需要整个网络节点的确认，6次网络确认后 到账。 您可以在充值记录里查看充值状态！");
    
    [_warnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(ScaleW(15));
        make.right.mas_equalTo(self.view).offset(ScaleW(-15));
        make.top.mas_equalTo(self.warnTitleLabel.mas_top);
    }];
    
    
    WS(weakSelf);
    [self.rechargeArray enumerateObjectsUsingBlock:^(RechargeModel  *obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        switch (idx)
        {
            case 0:
            {
                [weakSelf.chargeView setAddress:obj.address];
                [weakSelf.chargeView.qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:obj.qrcode]];
            }
                break;
        }
    }];
    
}


-(Home_Segment_View *)segmentControl
{
    if (nil == _segmentControl)
    {
        WS(weakSelf);
        NSMutableArray *itemArray = [NSMutableArray array];
        [self.rechargeArray enumerateObjectsUsingBlock:^(RechargeModel  *obj, NSUInteger idx, BOOL * _Nonnull stop)
        {
            [itemArray addObject:obj.code];
        }];
        
        
        _segmentControl = [[Home_Segment_View alloc]initWithFrame:CGRectMake(0, 0, ScaleW(200), ScaleW(50)) titles:itemArray normalColor:kSubTitleColor selectedColor:kBlueColor fontSize:ScaleW(15)];
        [_segmentControl setBackgroundColor:kSubBgColor];
        
        _segmentControl.selectedIndexBlock = ^(NSInteger index)
        {
            [weakSelf selectCoin:index];
            return YES;
        };
        
    }
    return _segmentControl;
}


-(UIScrollView *)scrollView
{
    if (nil == _scrollView)
    {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScreenHeight - Height_NavBar)];
        
        
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _scrollView;
}

-(Mine_RechargeTop_View *)chargeView
{
    if (nil == _chargeView) {
        _chargeView = [[Mine_RechargeTop_View alloc]initWithFrame:CGRectMake(ScaleW(15), self.segmentView.bottom + ScaleW(10), ScreenWidth - ScaleW(30), ScaleW(400))];
    }
    return _chargeView;
}

-(UILabel *)warnTitleLabel
{
    if (nil == _warnTitleLabel) {
        _warnTitleLabel  = [FactoryUI createLabelWithFrame:CGRectMake(self.chargeView.x, self.chargeView.bottom + ScaleW(10), self.chargeView.width, ScaleW(14)) text:SSKJLocalized(@"充币说明:", nil) textColor:kSubTitleColor font:systemFont(ScaleW(14))];
    }
    return _warnTitleLabel;
}

-(UILabel *)warnLabel
{
    if (nil == _warnLabel) {
        _warnLabel = [FactoryUI createLabelWithFrame:CGRectMake(self.chargeView.x, self.warnTitleLabel.bottom + ScaleW(-20), self.chargeView.width, ScaleW(12)) text:SSKJLocalized(@"--", nil) textColor:kSubTitleColor font:systemFont(ScaleW(12))];
        _warnLabel.numberOfLines = 0;
        
        
    }
    return _warnLabel;
}


-(NSMutableArray <RechargeModel*> *)rechargeArray
{
    if (!_rechargeArray)
    {
        _rechargeArray = [[NSMutableArray alloc]init];
    }
    return _rechargeArray;
}






- (void)requestAddress
{
    #pragma mark 处理
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);

    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_RechargeAddr_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject)
    {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if ([responseObject[@"code"] integerValue] == 200)
        {
            
            NSArray *itemArray = [responseObject objectForKey:@"data"];
            
            for (NSDictionary *object in itemArray)
            {
                RechargeModel *model = [[RechargeModel alloc]init];
                [model setAddress:[object objectForKey:@"address"]];
                [model setCode:[object objectForKey:@"code"]];
                [model setQrcode:[object objectForKey:@"qrcode"]];
                [weakSelf.rechargeArray addObject:model];
            }
            
            
           
            [weakSelf setUI];
            
            
            
        }
        else
        {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"加载失败", nil)];
    }];
}


@end
