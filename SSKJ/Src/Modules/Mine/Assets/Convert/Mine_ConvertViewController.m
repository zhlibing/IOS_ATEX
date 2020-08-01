//
//  Mine_ConvertViewController.m
//  SSKJ
//
//  Created by zpz on 2019/12/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Mine_ConvertViewController.h"
#import "Mine_Asset_ConvertView.h"
#import "Mine_ConvertRecordViewController.h"
#import "Mine_AssetsInfo_Model.h"
#import "SSKJ_Socket_Tool.h"

#import "SSKJ_Market_Index_Model.h"

@interface Mine_ConvertViewController ()<SSKJSocketToolDelegate>


@property(nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic, strong)UIView *contentView;

@property(nonatomic, strong)UIView *topView;
@property(nonatomic, strong)Mine_Asset_ConvertView *leftView;
@property(nonatomic, strong)Mine_Asset_ConvertView *rightView;
@property(nonatomic, strong)UIButton *convertBtn;

@property(nonatomic, strong)SSKJ_TextFieldView *numView;
@property(nonatomic, strong)SSKJ_TextFieldView *toNumView;
@property(nonatomic, strong)SSKJ_TextFieldView *pwdView;
@property(nonatomic, strong)UIButton *commiteBtn;

@property(nonatomic, strong)NSArray *coinArray;

@property (nonatomic, strong)SSKJ_Socket_Tool *socketTool;

@property(nonatomic, strong)UILabel *usableLabel;
@property(nonatomic, strong)UIButton *allBtn;
@end

@implementation Mine_ConvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = SSKJLanguage(@"兑换");
    
    [self scrollView];
    
    [self contentView];
    
    [self setupUI];
    
    self.coinArray = @[@"USDT", @"BTC", @"ETH"];
    
    self.leftView.coin = @"USDT";
//    self.rightView.coin = @"USDT";

    self.socketTool = [[SSKJ_Socket_Tool alloc] initWithType:SSKJSocketTypeMarket module:SSKJSocketModuleHeYue delegate:self];

    
    [self addRightNavgationItemWithImage:UIImageNamed(@"mine_tibi_record")];
    
    [self updateUsable];

}

#pragma mark - 页面即将显示
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self openSocket];

}

#pragma mark - 页面即将消失
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self closeSocket];
}

#pragma mark - WebSocket
-(void)openSocket
{
    [self.socketTool openSocketWithCode:@[@"BTC/USDT", @"ETH/USDT"]];
}

-(void)closeSocket
{
    [self.socketTool closeSocket];
}


- (void)marketSocketDidUpdate:(NSDictionary *)dic{
    SSKJ_Market_Index_Model *model = [SSKJ_Market_Index_Model mj_objectWithKeyValues:dic];
    
    NSString *s = [model.code uppercaseString];
    NSArray *codeA = [s componentsSeparatedByString:@"/"];
    
    if ([codeA.firstObject isEqualToString:self.leftView.coin]) {
        self.leftView.model = model;
        [self updateInfo];
    }else if ([codeA.firstObject isEqualToString:self.rightView.coin]){
        self.rightView.model = model;
        [self updateInfo];
    }
}

- (void)rigthBtnAction:(id)sender{
    Mine_ConvertRecordViewController *vc = [Mine_ConvertRecordViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)updateInfo{
    
    self.toNumView.field.text = @"";
    
    if (!self.numView.valueString.length) {
        return;
    }
    
    if (!self.leftView.coin.length || !self.rightView.coin.length) {
        return;
    }
    
    if ([self.rightView.coin isEqualToString:@"USDT"]) {
        
        if (!self.leftView.model) {
            return;
        }
        
        double num = self.numView.valueString.doubleValue * self.leftView.model.price.doubleValue;
        self.toNumView.field.text = [SSTool disposePname:@"8" price:@(num)];
        
    }
    
    else if ([self.leftView.coin isEqualToString:@"USDT"]) {
        
        if (!self.rightView.model) {
            return;
        }
        
        double num = self.numView.valueString.doubleValue / self.rightView.model.price.doubleValue;
        self.toNumView.field.text = [SSTool disposePname:@"8" price:@(num)];
        
    }
    
    
//    else{
//
//        if (!self.leftView.model || !self.rightView.model) {
//            return;
//        }
//
//        double num = self.numView.valueString.doubleValue * (self.leftView.model.price.doubleValue / self.rightView.model.price.doubleValue);
//        self.toNumView.field.text = [SSTool disposePname:@"8" price:@(num)];
//
//    }
    
}

- (void)textChange:(UITextField *)field{
    [self updateInfo];
}

- (void)convertBtnClick{
    
}

- (void)commitClick{
 
    if (!self.numView.valueString.length) {
        [SSTool error:SSKJLanguage(@"请输入兑换数量")];
        return;
    }
    
    if (!self.pwdView.valueString.length) {
        [SSTool error:SSKJLanguage(@"请输入资金密码")];
        return;
    }
    [self commitInfo];
}

- (void)commitInfo{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    NSDictionary *params = @{
                             @"id":kUserID,
                             @"fromCode":self.leftView.coin,
                             @"toCode":self.rightView.coin,
                             @"fromNum":self.numView.valueString,
                             @"tradePwd":Encrypt(self.pwdView.valueString)
                             };
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:URL_Mine_Convert RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if ([responseObject[@"code"] integerValue] == 200) {
            [MBProgressHUD showError:responseObject[@"msg"]];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"加载失败", nil)];
    }];
}

- (void)setupUI{
    
    [self setupTopView];
    
    self.numView = [[SSKJ_TextFieldView alloc] initWithTitle:SSKJLanguage(@"兑换数量") placeholder:SSKJLanguage(@"请输入兑换数量") rightBtn:NO];
    self.numView.field.keyboardType = UIKeyboardTypeDecimalPad;
    [self.numView.field addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:self.numView];
    [self.numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(ScaleW(20));
        make.left.equalTo(@0);
        make.right.equalTo(@(ScaleW(-80)));
        make.height.equalTo(@(ScaleW(70)));
    }];
    
    self.allBtn = [UIButton createWithTitle:SSKJLanguage(@"全部") titleColor:kBlueColor font:kFont(15) target:self action:@selector(allClick)];
    [self.contentView addSubview:self.allBtn];
    [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.width.equalTo(@(ScaleW(80)));
        make.centerY.equalTo(self.numView.field);
    }];

    UILabel *usable = [UILabel createWithText:SSKJLanguage(@"可用:") textColor:kSubTitleColor font:kFont(13)];
    [self.contentView addSubview:usable];
    [usable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScaleW(15)));
        make.top.equalTo(self.numView.mas_bottom).offset(ScaleW(5));
    }];
    
    self.usableLabel = [UILabel createWithText:@"" textColor:kSubTitleColor font:kFont(13)];
    [self.contentView addSubview:self.usableLabel];
    [self.usableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(usable.mas_right).offset(ScaleW(2));
        make.top.equalTo(self.numView.mas_bottom).offset(ScaleW(5));
    }];
    
    
    _toNumView = [[SSKJ_TextFieldView alloc] initWithTitle:SSKJLanguage(@"到账数量") placeholder:@"" rightBtn:NO];
    _toNumView.field.userInteractionEnabled = NO;
    [self.contentView addSubview:_toNumView];
    [_toNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usableLabel.mas_bottom).offset(ScaleW(20));
        make.left.right.equalTo(@0);
        make.height.equalTo(@(ScaleW(70)));
    }];
    UILabel *la = [UILabel createWithText:SSKJLanguage(@"账户中持有资产可按比例兑换为其他资产，兑换比例以行情为准") textColor:kSubTitleColor font:kFont(12)];
    [self.contentView addSubview:la];
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScaleW(15)));
        make.right.equalTo(@(ScaleW(-15)));
        make.top.equalTo(self.toNumView.mas_bottom).offset(ScaleW(5));
    }];
    la.numberOfLines = 0;

    
    _pwdView = [[SSKJ_TextFieldView alloc] initWithTitle:SSKJLanguage(@"资金密码") placeholder:SSKJLanguage(@"请输入资金密码") rightBtn:YES];
    [self.contentView addSubview:_pwdView];
    [_pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(la.mas_bottom).offset(ScaleW(20));
        make.left.right.equalTo(@0);
        make.height.equalTo(@(ScaleW(70)));
    }];
    
    
    self.commiteBtn = [UIButton createWithTitle:SSKJLanguage(@"兑换") titleColor:kWhiteColor font:kFont(17) target:self action:@selector(commitClick)];
    self.commiteBtn.backgroundColor = kBlueColor;
    self.commiteBtn.layer.masksToBounds = YES;
    self.commiteBtn.layer.cornerRadius = ScaleW(5);
    [self.contentView addSubview:self.commiteBtn];
    [self.commiteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdView.mas_bottom).offset(ScaleW(80));
        make.left.equalTo(@(ScaleW(15)));
        make.right.equalTo(@(ScaleW(-15)));
        make.height.equalTo(@(ScaleW(46)));
        make.bottom.equalTo(@(ScaleW(-15)));
    }];
}

- (void)updateUsable{
    
    if (!self.coinInfoArray.count) {
        return;
    }
    if ([self.leftView.coin isEqualToString:@"USDT"]) {
        
        Mine_AssetsInfo_Model *coin = self.coinInfoArray.firstObject;
        self.usableLabel.text = [SSTool disposePname:@"8" price:coin.usableFund];

    }else if ([self.leftView.coin isEqualToString:@"BTC"]){

        Mine_AssetsInfo_Model *coin = self.coinInfoArray[1];
               self.usableLabel.text = [SSTool disposePname:@"8" price:coin.usableFund];
        
    }else if ([self.leftView.coin isEqualToString:@"ETH"]){
        
        Mine_AssetsInfo_Model *coin = self.coinInfoArray.lastObject;
               self.usableLabel.text = [SSTool disposePname:@"8" price:coin.usableFund];
        
    }else{
        self.usableLabel.text = @"";
    }
}

- (void)allClick{
    
    self.numView.field.text = self.usableLabel.text;
    
//    [self updateInfo];
}

- (void)setupTopView{
    self.topView = [UIView new];
    [self.contentView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@(ScaleW(95)));
        make.top.equalTo(@(Height_NavBar));
    }];
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = kSubBgColor;
    [self.topView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.equalTo(@(ScaleW(5)));
    }];
    
    UILabel *title = [UILabel createWithText:SSKJLanguage(@"兑换资产") textColor:kTitleColor font:kFont(13)];
    [self.topView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScaleW(15)));
        make.top.equalTo(@(ScaleW(20)));
    }];
    
    self.leftView = [Mine_Asset_ConvertView new];
    [self.topView addSubview:self.leftView];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScaleW(15)));
        make.bottom.equalTo(@(ScaleW(-15)));
        make.height.equalTo(@(ScaleW(28)));
    }];
    
    self.rightView = [Mine_Asset_ConvertView new];
    [self.topView addSubview:self.rightView];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftView.mas_right).offset(ScaleW(40));
        make.height.width.bottom.equalTo(self.leftView);
        make.right.equalTo(@(ScaleW(-15)));
    }];
    
    WS(weakSelf);
    self.leftView.clickBlock = ^{
        NSArray *array = [weakSelf getCoinArrayIsLeft:YES];
        [SSKJ_Default_ActionsheetView showWithItems:array title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
            weakSelf.leftView.coin = array[selectIndex];
            weakSelf.rightView.coin = @"";
            weakSelf.numView.field.text = @"";
            [weakSelf updateUsable];
        } cancleBlock:^{
            
        }];
    };
    
    self.rightView.clickBlock = ^{
        
        NSArray *array = [weakSelf getCoinArrayIsLeft:NO];
        [SSKJ_Default_ActionsheetView showWithItems:array title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
            weakSelf.rightView.coin = array[selectIndex];
            [weakSelf updateInfo];
        } cancleBlock:^{
            
        }];
    };
    
    
    UIButton *convert = [UIButton buttonWithType:UIButtonTypeCustom];
    [convert setImage:UIImageNamed(@"mine_change") forState:(UIControlStateNormal)];
    [convert addTarget:self action:@selector(convertBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.topView addSubview:convert];
    [convert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftView.mas_right);
        make.right.equalTo(self.rightView.mas_left);
        make.centerY.equalTo(self.leftView);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = kLineColor;
    [self.topView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(@0);
        make.height.equalTo(@(ScaleW(0.5)));
    }];
}


- (NSArray *)getCoinArrayIsLeft:(BOOL)isLeft{
//    NSMutableArray *arr = [NSMutableArray array];
//    NSString *coin = !isLeft ? self.leftView.coin : self.rightView.coin;
//    for (NSString *str in self.coinArray) {
//        if (![str isEqualToString:coin]) {
//            [arr addObject:str];
//        }
//    }
//    return [arr copy];
    
    if (isLeft) {
        return self.coinArray;
    }else{
        if ([self.leftView.coin isEqualToString:@"USDT"]) {
            NSMutableArray *arr = [NSMutableArray array];
            NSString *coin = !isLeft ? self.leftView.coin : self.rightView.coin;
            for (NSString *str in self.coinArray) {
                if (![str isEqualToString:coin]) {
                    [arr addObject:str];
                }
            }
            return [arr copy];
        }else{
            return @[@"USDT"];
        }
    }
}



- (UIScrollView *)scrollView{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
        if (@available(iOS 11.0, *)){
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.left.bottom.equalTo(@0);
        }];
    }
    return _scrollView;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [UIView new];
        [_scrollView addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.left.bottom.equalTo(@0);
            make.centerX.equalTo(self.scrollView);
            make.width.equalTo(@(ScreenWidth));
        }];
    }
    return _contentView;
}

@end
