//
//  BLUserProtocolViewController.m
//  ZYW_MIT
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "SSKJ_UserProtocolViewController.h"


@interface SSKJ_UserProtocolViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation SSKJ_UserProtocolViewController

#pragma mark - LifeCycle Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self webView];
    
    self.title = SSKJLocalized(@"关于我们", nil);
    
    self.view.backgroundColor= kSubBgColor;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark 根据语言转换文档信息
-(void)loadHtmlObject:(NSDictionary*)object
{
    
    if(kIsCN)
    {
        
        NSString *content = [object objectForKey:@"content"];
        [self.webView loadHTMLString:content baseURL:nil];
        
        
    }else
    {
        NSString *content = [object objectForKey:@"contentUs"];
        [self.webView loadHTMLString:content baseURL:nil];
    }
}

- (void)requestURL
{
    NSString *url;
    switch (self.type)
    {
        case 2:
        {
            url = BI_FeeInfo_URL;
        }
            break;
        case 3:
        {
            url = BI_Ours_URL;
        }
            break;
    }
    

    #pragma mark 获取数据
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:url RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject)
     {
         WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
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
        [MBHUD hideHUDForView:weakSelf.view];
        [MBHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //改变背景颜色
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.backgroundColor = '#ffffff'"];
    //改变字体颜色
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#8e94a3'"];
    
    NSString *js = @"function imgAutoFit() { var imgs = document.getElementsByTagName('img');for (var i = 0; i < imgs.length; i++) {var img = imgs[i];img.style.width = %f;}}";
    
    js = [NSString stringWithFormat:js, ScreenWidth - 20];
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];

}








#pragma mark - Getter / Setter
-(UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [[UIWebView alloc]init];
        [_webView setBackgroundColor:kBgColor];
        [self.view addSubview:_webView];
        _webView.delegate = self;
//        [_webView stringByEvaluatingJavaScriptFromString:@"document.body.style.backgroundColor = '#1c1f22'"];
        
//        _webView.scrollView.contentInset = UIEdgeInsetsMake(ScaleW(10), 0, 0, 0);
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.bottom.equalTo(self.view);
            
            make.top.equalTo(@(Height_NavBar + ScaleW(10)));
            
        }];
        
        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }

    }
    return _webView;
}
@end
