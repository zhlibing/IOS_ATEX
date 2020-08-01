//
//  BI_BusinessApply_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/6/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "BI_BusinessApply_ViewController.h"

@interface BI_BusinessApply_ViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *boxButton;
@property (nonatomic, strong) UILabel *warningLabel;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *contentArray;

@property (nonatomic, assign) CGFloat startY;

@property (nonatomic, strong) NSString *baozhengjin;

@end

@implementation BI_BusinessApply_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self changeTitle:SSKJLocalized(@"申请商家", nil)];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestBaozhengjin];
}

-(void)setUI
{
    self.view.backgroundColor = kSubBgColor;
    self.titleArray = @[
                        SSKJLocalized(@"步骤一：提交申请",nil),
                        SSKJLocalized(@"步骤二：资料审核",nil)
                        ];
    self.contentArray = @[
                          [NSString stringWithFormat:SSKJLocalized(@"买卖商户必须为平台认证商户，并在本页面点击“确认申请”按钮，提交申请，并同意冻结%@USDT作为商家保证金", nil),self.baozhengjin],
                          SSKJLocalized(@"我们平台会在72小时内进行审核商家申请资料及匹配以往交易，确认符合商家申请条件，您可以在法币交易区发布广告。如申请条件未符合，我们将12小时内联系您，请保持通讯畅通",nil),
                          ];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.titleLabel];
    [self addContents];
    [self.scrollView addSubview:self.confirmButton];
    [self.scrollView addSubview:self.boxButton];
    [self.scrollView addSubview:self.warningLabel];
}


-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScreenHeight - Height_NavBar)];
        _scrollView.backgroundColor = kSubBgColor;
        _scrollView.contentInset = UIEdgeInsetsMake(ScaleW(10), 0, 0, 0);
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _scrollView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"如何申请成为商家", nil) font:systemFont(ScaleW(17)) textColor:kTitleColor frame:CGRectMake(15, ScaleW(35), ScreenWidth - ScaleW(30), ScaleW(18)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(void)addContents
{
    CGFloat startY = self.titleLabel.bottom + ScaleW(31);
    
    for (int i = 0; i < self.titleArray.count; i++) {
        NSString *title = self.titleArray[i];
        NSString *content = self.contentArray[i];
        
        UILabel *titleLabel = [WLTools allocLabel:title font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), startY, ScreenWidth - ScaleW(30), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
        [self.scrollView addSubview:titleLabel];
        
        CGFloat height = [content boundingRectWithSize:CGSizeMake(titleLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:systemFont(ScaleW(13))} context:nil].size.height;
        UILabel *contentLabel = [WLTools allocLabel:content font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(24), titleLabel.bottom + ScaleW(21), titleLabel.width, height) textAlignment:NSTextAlignmentLeft];
        contentLabel.numberOfLines = 0;
        contentLabel.adjustsFontSizeToFitWidth = YES;
        [self.scrollView addSubview:contentLabel];
        startY = contentLabel.bottom + ScaleW(26);
        self.startY = startY;
    }
    
    
}


-(UIButton *)boxButton
{
    if (nil == _boxButton) {
        _boxButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(20), self.confirmButton.y - ScaleW(30), ScaleW(30), ScaleW(20))];
        [_boxButton setImage:[UIImage imageNamed:@"fb_unSelect"] forState:UIControlStateNormal];
        [_boxButton setImage:[UIImage imageNamed:@"fb_select"] forState:UIControlStateSelected];
        [_boxButton addTarget:self action:@selector(boxEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _boxButton;
}

-(UILabel *)warningLabel
{
    if (nil == _warningLabel) {
        _warningLabel = [WLTools allocLabel:[NSString stringWithFormat:SSKJLocalized(@"同意冻结%@USDT作为商家保证金。",nil),self.baozhengjin] font:systemFont(ScaleW(11)) textColor:kSubTitleColor frame:CGRectMake(self.boxButton.right, 0, self.scrollView.width - self.boxButton.right, ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        _warningLabel.centerY = self.boxButton.centerY;
    }
    return _warningLabel;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(25), self.scrollView.height - ScaleW(65) - HOMEINDICATOR_HEIGHT, ScreenWidth - ScaleW(50), ScaleW(45))];
        _confirmButton.backgroundColor = kBlueColor;
        _confirmButton.layer.cornerRadius = ScaleW(5);
        [_confirmButton setTitle:SSKJLocalized(@"申请成为商家", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemFont(ScaleW(15));
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


#pragma mark - 用户操作


-(void)boxEvent
{
    self.boxButton.selected = !self.boxButton.selected;
}

// 获取保证金

-(void)requestBaozhengjin
{
    
    WS(weakSelf);
    [MBHUD showHUDAddedTo:self.view];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_ApplyShopBaozhengjin_URL RequestType:RequestTypePost Parameters:nil Success:^(NSInteger statusCode, id responseObject)
     {
         [MBHUD hideHUDForView:weakSelf.view];
         WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         if (netWorkModel.status.integerValue == SUCCESSED )
         {
             weakSelf.baozhengjin = netWorkModel.data[@"value"];
             [weakSelf setUI];
         }
         else
         {
             [MBHUD showError:netWorkModel.msg];
         }
         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
         [MBHUD hideHUDForView:weakSelf.view];
         [MBHUD showError:SSKJLocalized(@"网络异常", nil)];
     }];
}


// 申请
-(void)confirmEvent
{
    if (!self.boxButton.selected) {
        [MBProgressHUD showError:[NSString stringWithFormat:SSKJLocalized(@"请同意冻结%@USDT作为商家保证金。", nil) ,self.baozhengjin]];
        return;
    }
    
    
    NSDictionary *dict = @{@"id":kUserID};
    
    
    WS(weakSelf);
    [MBHUD showHUDAddedTo:self.view];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_ApplyShop_URL RequestType:RequestTypePost Parameters:dict Success:^(NSInteger statusCode, id responseObject)
     {
         [MBHUD hideHUDForView:self.view];
         WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         if (netWorkModel.status.integerValue == SUCCESSED )
         {
             [MBHUD showError:netWorkModel.msg];

             [[SSKJ_User_Tool sharedUserTool].userInfoModel setShopAuthenticationStatus:@"2"];
             
             [weakSelf.navigationController popViewControllerAnimated:YES];

         }
         else
         {
             [MBHUD showError:netWorkModel.msg];
         }
         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
         
         [MBHUD showError:SSKJLocalized(@"网络异常", nil)];
         
     }];
    
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
