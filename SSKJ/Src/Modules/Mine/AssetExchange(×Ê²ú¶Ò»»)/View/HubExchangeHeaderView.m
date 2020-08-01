//
//  HubExchangeHeaderView.m
//  ZYW_MIT
//
//  Created by 晶雪之恋 on 2018/9/17.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "HubExchangeHeaderView.h"
#import "HubChangeListCell.h"


@interface HubExchangeHeaderView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (weak, nonatomic)  UIView *backView;

@property (weak, nonatomic)  UIView *rightView;

//详细介绍
@property (weak, nonatomic)  UILabel *detailLabel;
@property (weak, nonatomic)  UILabel *warnLabel;
// 资产类型
@property (weak, nonatomic)  UIView *assetBackView;
@property (weak, nonatomic)  UIView *ImageBackView;
@property (weak, nonatomic)  UIView *exchangaBackView;
@property (weak, nonatomic)  UILabel *assetTypeLabel;
@property (weak, nonatomic)  UIView *assetAmountBackView;
@property (weak, nonatomic)  UIView *pwdBackView;
// 兑换资产类型
@property (weak, nonatomic)  UIView *amountBackView;
@property (weak, nonatomic)  UILabel *changeTypeLabel;
// 兑换数量
@property (weak, nonatomic)  UILabel *duihCountLabel;
// 兑换类型
@property (weak, nonatomic)  UILabel *duihTypeLabel;
// 资产数量
@property (weak, nonatomic)  UILabel *assetAmountLabel;
// 资产类型
@property (weak, nonatomic)  UILabel *typeLabel;
//资金密码
@property (weak, nonatomic)  UITextField *pwdTextField;
//兑换数量
@property (weak, nonatomic)  UITextField *amountTextField;



//持有资产title
@property (weak, nonatomic)  UILabel *zhiyouTitle;
//兑换资产title
@property (weak, nonatomic)  UILabel *duihuanTitle;
//兑换数量title
@property (weak, nonatomic)  UILabel *duihuannumTitle;
//资产数量title
@property (weak, nonatomic)  UILabel *zichanNumTitle;
//资金密码title
@property (weak, nonatomic)  UILabel *payPwdTitle;
//兑换按钮
@property (weak, nonatomic)  UIButton *duihuanBtn;



@property (nonatomic, copy) NSArray * dataArray;

@property (nonatomic, copy) NSArray * rightDataArray;
//0持有资产    1兑换资产
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) BOOL openBool;

@property (nonatomic, strong) HubExchangeAssetModel *leftModel;

@property (nonatomic, strong) HubExchangeRithtModel *rightModel;

@property(nonatomic,assign)BOOL isHaveDian;

@end

@implementation HubExchangeHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = kBgColor;
    self.assetBackView.backgroundColor = kBgColor;
    self.ImageBackView.backgroundColor = kBgColor;
    self.exchangaBackView.backgroundColor = kBgColor;
    self.amountBackView.backgroundColor = kBgColor;
    self.assetAmountBackView.backgroundColor = kBgColor;
    self.pwdBackView.backgroundColor = kBgColor;
    self.duihuanBtn.backgroundColor = kBlueColor;
    self.warnLabel.textColor = kSubTitleColor;
    self.assetAmountLabel.textColor = kTitleColor;
    self.amountTextField.delegate = self;
    self.amountTextField.textColor = kTitleColor;
    //中英切换
    self.zhiyouTitle.text = SSKJLocalized(@"持有资产", nil);
    self.duihuanTitle.text = SSKJLocalized(@"兑换资产", nil);
    self.duihuannumTitle.text = SSKJLocalized(@"兑换数量", nil);
    self.duihuannumTitle.adjustsFontSizeToFitWidth = YES;
    self.zichanNumTitle.text = SSKJLocalized(@"资产数量", nil);
    self.zichanNumTitle.adjustsFontSizeToFitWidth = YES;
    self.payPwdTitle.text = SSKJLocalized(@"资金密码", nil);
    self.payPwdTitle.adjustsFontSizeToFitWidth = YES;
    self.detailLabel.text = SSKJLocalized(@"详细介绍", nil);
    self.amountTextField.placeholder = SSKJLocalized(@"请输入兑换数量", nil);
    self.pwdTextField.placeholder = SSKJLocalized(@"请输入资金密码", nil);
    [self.duihuanBtn setTitle:SSKJLocalized(@"兑换", nil) forState:0];
    self.pwdTextField.textColor = kTitleColor;
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseButtonAction)];
    [self.backView addGestureRecognizer:tapGest];
    
    UITapGestureRecognizer *tapGest1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(duihuanButtonAction)];
    [self.rightView addGestureRecognizer:tapGest1];
    
    [self.pwdTextField setValue:kSubTitleColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.amountTextField setValue:kSubTitleColor forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.amountTextField addTarget:self action:@selector(textFieldChange) forControlEvents:UIControlEventEditingChanged];
    
    self.pwdTextField.secureTextEntry = YES;
    self.amountTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.detailLabel.adjustsFontSizeToFitWidth = YES;
    self.openBool = NO;
    for (HubExchangeAssetModel *model in self.dataArray)
    {
        if ([@"KT" isEqualToString:self.changeTypeLabel.text])
        {

            if (self.delegate && [self.delegate respondsToSelector:@selector(getExchangeModel:)])
            {
                [self.delegate getExchangeModel:model];
            }
        }
    }
    [self requestList];
//    self.backgroundColor = LineColor;
}




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}






- (void)refreshHeaderViewWithParam:(id)param
{
    self.dataArray = param;
    
    [self.tableView reloadData];
}

// 选择持有
- (void)chooseButtonAction
{
    self.type = 0;
    self.amountTextField.text = @"";
    self.assetAmountLabel.text = @"";
    if (_tableView == nil)
    {
        self.tableView.x = 20;
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.height = 120;
        } completion:^(BOOL finished) {
            self.tableView.height = 120;
        }];
    }
    else
    {
        [self.tableView removeFromSuperview];
        self.tableView = nil;
        if (self.type == 1)
        {
            self.type = 0;
            self.tableView.x = 20;
            [UIView animateWithDuration:0.5 animations:^{
                self.tableView.height = 120;
            } completion:^(BOOL finished) {
                self.tableView.height = 120;
            }];
        }
        
    }
}

// 选择兑换
- (void)duihuanButtonAction
{
    self.type = 1;
    self.amountTextField.text = @"";
    self.assetAmountLabel.text = @"";
    if (self.openBool)
    {
        [self.tableView removeFromSuperview];
        self.tableView = nil;
        self.openBool = NO;
    }
    else
    {
        [self requestExchangeListWithCoin:self.leftModel.code];
    }
}

- (void)textFieldChange
{
    
    NSString *amount = [NSString stringWithFormat:@"%.4f", [self.rightModel.ex_rate doubleValue] *[self.amountTextField.text doubleValue]];
    self.assetAmountLabel.text = amount;
    
}

//"兑换"点击
- (IBAction)sureButtonAction:(UIButton *)sender
{
    if (self.amountTextField.text.length <= 0)
    {
        NSString * errorMsg = SSKJLocalized(@"兑换数量不能为空", nil);
        [MBProgressHUD showError:errorMsg];
        return;
    }
    
    //交易密码隐藏了
    if (self.pwdTextField.text.length == 0)
    {
        NSString * errorMsg = SSKJLocalized(@"请输入正确的资金密码", nil);
        [MBProgressHUD showError:errorMsg];
        return;
    }
    
    NSDictionary *param = @{
                            @"coin":self.leftModel.code,
                            @"ex_coin":self.rightModel.ex_coin,
                            @"num":self.amountTextField.text,
                            @"tpwd":self.pwdTextField.text
                            };
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(getExchangeInfoWithParam:pwd:)])
    {
        self.pwdTextField.text = @"";
        [self.delegate getExchangeInfoWithParam:param pwd:self.pwdTextField.text];
    }
}



- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [UITableView new];
        
        _tableView.frame = CGRectMake(20, self.backView.height + self.backView.top, 90, 0);
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:@"HubChangeListCell" bundle:nil] forCellReuseIdentifier:@"HubChangeListCell"];
        
        [self addSubview:_tableView];
       
    }
    return _tableView;
}

// 持有的币种列表
- (void)requestList
{
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_CaptialFund_URL RequestType:RequestTypeGet Parameters:@{@"id":kUserID} Success:^(NSInteger statusCode, id responseObject)
     {
         WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         if (netWorkModel.status.integerValue == SUCCESSED )
         {
             NSArray *array = [HubExchangeAssetModel mj_objectArrayWithKeyValuesArray:netWorkModel.data];
             
             weakSelf.dataArray = [NSMutableArray arrayWithArray:array];
             
             [weakSelf.tableView reloadData];
             
             HubExchangeAssetModel *model = weakSelf.dataArray.firstObject;
             
             self.assetTypeLabel.text = model.pname;
             
             self.duihTypeLabel.text = model.pname;
             
             self.leftModel = model;
             
             [self requestExchangeListWithCoin:model.code];
             
             for (HubExchangeAssetModel *model in weakSelf.dataArray)
             {
                 
                 if ([model.pname isEqualToString:@"KT"])
                 {
                     
                     HubExchangeAssetModel *model = weakSelf.dataArray[1];
                     
                     self.assetTypeLabel.text = model.pname;
                     
                     self.duihTypeLabel.text = model.pname;
                     
                     self.leftModel = model;
                     
                     [self requestExchangeListWithCoin:model.code];
                 }
             }
         }
         else
         {
             [MBHUD showError:netWorkModel.msg];
         }
         
         
         
         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBHUD hideHUDForView:self];
         [MBHUD showError:SSKJLocalized(@"服务器请求异常", nil)];
     }];
}

// 要兑换币种列表
- (void)requestExchangeListWithCoin:(NSString *)coin
{
    
}
//{
//    if ([kLogined integerValue] != 1)
//    {
//        return;
//    }
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
//
//    NSDictionary *param = @{
//                            @"coin":coin
//                            };
//    WS(weakSelf);
//    [hud hideAnimated:YES afterDelay:5.f];
//    [HttpTool postWithURL:Duihuan_ThisCoinList_URL params:param success:^(id json) {
//        NSString *status = json[@"status"];
//        [hud hideAnimated:YES];
//        if (status.integerValue == SUCCESSED)
//        {
//            NSArray *array = [HubExchangeRithtModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
//            weakSelf.rightDataArray = [NSMutableArray arrayWithArray:array];
//            [weakSelf.tableView reloadData];
//            // UI 修改
//            if (self.type == 1)
//            {
//                self.tableView.x = ScreenWidth - self.tableView.width;
//                [UIView animateWithDuration:0.5 animations:^{
//
//                    if (weakSelf.rightDataArray.count < 7)
//                    {
//                        self.tableView.height = weakSelf.rightDataArray.count * 30;
//                    }
//                    else
//                    {
//                        self.tableView.height = 200;
//                    }
//
//                } completion:^(BOOL finished)
//                 {
//                     if (weakSelf.rightDataArray.count < 7)
//                     {
//                         self.tableView.height = weakSelf.rightDataArray.count * 30;
//                     }
//                     else
//                     {
//                         self.tableView.height = 200;
//                     }
//                     self.openBool = YES;
//                 }];
//            }
//            else
//            {
//                HubExchangeRithtModel *rightModel;
//
//                if (self.rightDataArray.count > 0)
//                {
//                    rightModel = self.rightDataArray[0];
//
//                    self.rightModel = rightModel;
//                }
//
//                self.changeTypeLabel.text = rightModel.ex_name;
//
//                self.typeLabel.text = rightModel.ex_name;
//            }
//
//        }
//        else
//        {
//            [MBProgressHUD showError:json[@"msg"]];
//        }
//    } failure:^(NSError *error) {
//
//        [hud hideAnimated:YES];
//        //weakSelf.headerView.assetsHidden = YES;
//        [MBProgressHUD showError:SSKJLocalized(@"服务器请求异常", nil)];
//        LSLog(@"error : %@",error);
//    }];
//}


#pragma mark - UITableViewDelegate && UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.type == 1)
    {
        return self.rightDataArray.count;
    }
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HubChangeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HubChangeListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count > indexPath.row)
    {
        if (self.type == 0)
        {
            HubExchangeAssetModel *model = self.dataArray[indexPath.row];
            cell.content = model.pname;
        }
        else
        {
            HubExchangeRithtModel *model = self.rightDataArray[indexPath.row];
            cell.content = model.ex_name;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView removeFromSuperview];
    self.tableView = nil;
    if (self.type == 0)
    {
        // 持有
        HubExchangeAssetModel *model;
        
        if (self.dataArray.count > indexPath.row)
        {
            model = self.dataArray[indexPath.row];
        }
        
        self.assetTypeLabel.text = model.pname;
        
        self.duihTypeLabel.text = model.pname;
        
        self.leftModel = model;
        
        // 选中第一个
        [self requestExchangeListWithCoin:model.code];
        
    }
    else
    {
        HubExchangeRithtModel *model;
        if (self.rightDataArray.count > indexPath.row)
        {
            model = self.rightDataArray[indexPath.row];
            self.rightModel = model;
        }
        
        self.changeTypeLabel.text = model.ex_name;
        self.typeLabel.text = model.ex_name;
    }
    
    if (self.type == 1)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(getExchangeModel:)])
        {
//            [self.delegate getExchangeModel:model];
        }
    }
}

// 设置分区头背景透明
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([view isMemberOfClass:[UITableViewHeaderFooterView class]]) {
        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = [UIColor clearColor];
    }
}

// 设置分区尾背景透明
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    if ([view isMemberOfClass:[UITableViewHeaderFooterView class]]) {
        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = [UIColor clearColor];
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0)
    {
        return YES;
    }
    
    if ([textField.text rangeOfString:@"."].location == NSNotFound){
        _isHaveDian = NO;
    }
    if ([string length] > 0) {
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.'){
            //输入的字符是否是小数点
            if (single == '.'){
                if(!_isHaveDian)//text中还没有小数点
                {
                    _isHaveDian = YES;
                    
                    return YES;
                }else{
                    [MBProgressHUD showError:SSKJLocalized(@"您已经输入过小数点了", nil)];
                    
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                if (_isHaveDian)
                {    //存在小数点
                    if (textField==self.amountTextField )
                    {
                        //判断小数点的位数
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 4){
                            return YES;
                        }else{
                            [MBProgressHUD showError:SSKJLocalized(@"您最多输入四位小数", nil)];
                            return NO;
                        }
                        
                    }
                }
                else
                {
                    return YES;
                }
            }
        }
        else
        {    //输入的数据格式不正确
            
            [MBProgressHUD showError:SSKJLocalized(@"您输入的格式不正确", nil)];
            
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            
            return NO;
        }
    }
    else
    {
        return YES;
    }
    return YES;
}
-(void)clearView
{
    self.amountTextField.text = nil;
    self.assetAmountLabel.text = nil;
    self.pwdTextField.text = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
