//
//  BI_FeedBack_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/6/19.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "Mine_Feedback_ViewController.h"

@interface Mine_Feedback_ViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *placeHloderLabel;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIView *contractBackView;
@property (nonatomic, strong) UITextField *contractTextField;

@property (nonatomic, strong) UIButton *submitButton;
@end

@implementation Mine_Feedback_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLanguage(@"问题反馈");
    [self setUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - UI

-(void)setUI
{
    self.view.backgroundColor=kSubBgColor;
    
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.textView];
    [self.textView addSubview:self.placeHloderLabel];
    
    [self.view addSubview:self.contractBackView];
    [self.contractBackView addSubview:self.contractTextField];
    
    [self.view addSubview:self.submitButton];
}

-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15),Height_NavBar + ScaleW(30), ScreenWidth - ScaleW(30), ScaleW(150))];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = ScaleW(5.0f);
        _backView.backgroundColor = kBgColor;
    }
    return _backView;
}


-(UITextView *)textView
{
    if (nil == _textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10), self.backView.width - ScaleW(30), self.backView.height - ScaleW(20))];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textColor = kTitleColor;
        _textView.font = systemFont(ScaleW(15));
        _textView.delegate = self;
    }
    return _textView;
}

-(UILabel *)placeHloderLabel
{
    if (nil == _placeHloderLabel) {
        _placeHloderLabel = [WLTools allocLabel:SSKJLocalized(@"请写下您的宝贵建议",nil) font:systemFont(ScaleW(15)) textColor:kSubTitleColor frame:CGRectMake(0, ScaleW(5), self.textView.width, ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _placeHloderLabel;
}


-(UIView *)contractBackView
{
    if (nil == _contractBackView) {
        _contractBackView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), self.backView.bottom + ScaleW(10), ScreenWidth - ScaleW(30), ScaleW(50))];
        _contractBackView.layer.masksToBounds = YES;
        _contractBackView.layer.cornerRadius = ScaleW(5.0f);
        _contractBackView.backgroundColor = [UIColor whiteColor];
    }
    return _contractBackView;
}

-(UITextField *)contractTextField
{
    if (nil == _contractTextField) {
        _contractTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(15), 0, self.contractBackView.width - ScaleW(30), self.contractBackView.height)];
        _contractTextField.textColor = kTitleColor;
        _contractTextField.font = systemFont(ScaleW(15));
        _contractTextField.placeholder = SSKJLocalized(@"留下您的联系方式", nil);
//        [_contractTextField setValue:kSubTitleColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _contractTextField;
}

-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.contractBackView.bottom + ScaleW(40), ScreenWidth - ScaleW(30), ScaleW(45))];
        _submitButton.layer.cornerRadius = ScaleW(5);
        _submitButton.backgroundColor = kBlueColor;
        [_submitButton setTitle:SSKJLocalized(@"提交",nil) forState:UIControlStateNormal];
        [_submitButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

#pragma mark - UITextFieldDelegate

-(void)textViewDidChange:(UITextView *)textView
{
    CGFloat height = [textView.text boundingRectWithSize:CGSizeMake(self.textView.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textView.font} context:nil].size.height;
    
    if (height <= ScaleW(130)) {
        height = ScaleW(130);
    }
    
    self.textView.height = height;
    self.backView.height = self.textView.bottom + ScaleW(10);
    self.contractBackView.y = self.backView.bottom + ScaleW(10);
    self.submitButton.y = self.contractBackView.bottom + ScaleW(40);
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.placeHloderLabel.hidden = NO;
    }else{
        self.placeHloderLabel.hidden = YES;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.placeHloderLabel.hidden = YES;
}


#pragma mark - 网络请求
#pragma mark 提交意见反馈
-(void)submitEvent
{
    NSString *feedInfo = self.textView.text;
    NSString *contact = self.contractTextField.text;
    
    if (feedInfo.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请详细描述您的问题", nil)];
        return;
    }
    
    if (contact.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请留下您的联系方式", nil)];
        return;
    }
    
    NSDictionary *params = @{
                             @"id":kUserID,
                             @"content":feedInfo,
                             @"contactInformation":contact
                             };

    WS(weakSelf);
    [MBHUD showHUDAddedTo:self.view];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_FeedBack_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
        [MBHUD hideHUDForView:self.view];
        
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED)
        {
            [MBProgressHUD showSuccess:SSKJLocalized(@"提交成功", nil)];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [MBHUD showError:net_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
    {
        [MBHUD hideHUDForView:self.view];
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
