//
//  My_Protocol_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/1.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Protocol_ViewController.h"



@interface My_Protocol_ViewController () <UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;

@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation My_Protocol_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.view.backgroundColor = kBgColor;
    
    [self setupUI];
    [self requestProtocolContent];
    
    switch (self.protocolType)
    {
        case PROTOCOLTYPEPRIVATE:
        {
            self.title = SSKJLocalized(@"隐私条款", nil);
        }
            break;
        case PROTOCOLTYPESERVICE:
        {
            
            self.title = SSKJLocalized(@"服务协议", nil);
        }
            break;
    }
}

- (void)setupUI {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScreenHeight - Height_NavBar)];
    webView.backgroundColor = kSubBgColor;
    webView.scrollView.backgroundColor = kSubBgColor;
    webView.delegate = self;
    [self.view addSubview:webView];
    _webView = webView;
    if (@available(iOS 11.0, *)) {
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void)requestProtocolContent {
    

    
    WS(weakSelf);
    
    [MBHUD showHUDAddedTo:self.view];
    
    
    NSString *url = @"";
    switch (self.protocolType)
    {
        #pragma mark  服务协议
        case PROTOCOLTYPESERVICE:
        {
            url = BI_Service_URL;
        }
            break;
         #pragma mark  隐私条款
        case PROTOCOLTYPEPRIVATE:
        {
            url = BI_Privacy_URL;
        }
            break;
    }
    
    
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:url RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject)
     {
         [MBHUD hideHUDForView:self.view];
         
         WL_Network_Model *netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         if (netWorkModel.status.integerValue == SUCCESSED )
         {
             [weakSelf loadHtmlObject:netWorkModel.data];
         }
         else
         {
             [MBHUD showError:netWorkModel.msg];
         }
         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBHUD hideHUDForView:self.view];
         [MBHUD showError:SSKJLocalized(@"网错出错", nil)];
     }];
    
}



#pragma mark 根据语言转换文档信息
-(void)loadHtmlObject:(NSDictionary*)object
{
    
    if (kIsCN) {
        NSString *content = [object objectForKey:@"content"];
        [self.webView loadHTMLString:content baseURL:nil];
    }else{
        NSString *content = [object objectForKey:@"contentUs"];
        [self.webView loadHTMLString:content baseURL:nil];
    }
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{

//
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#121212'"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#f7f7fa'"];

}

@end
