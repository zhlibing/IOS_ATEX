//
//  NI_NoticeDetailsViewController.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/28.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "NI_NoticeDetailsViewController.h"

#import <WebKit/WebKit.h>

@interface NI_NoticeDetailsViewController ()<WKUIDelegate,WKNavigationDelegate,NSURLSessionDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *titleBackView;

@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)UILabel *dataLabel;

@property (nonatomic, strong) UIView *lineView;


//@property (nonatomic, strong)UIWebView *webViewContent;

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation NI_NoticeDetailsViewController

#pragma mark - 初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kBgColor;
    self.title= SSKJLocalized(@"公告详情", nil);
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


#pragma mark - 页面即将显示
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self setObjectid:self.model.ID];
    [self.titleLabel setText:self.model.title];
}

#pragma  mark - 创建UI
- (void)createUI
{
    [self titleBackView];
    [self titleLabel ];
    [self dataLabel];
    [self lineView];
    [self webView];
    
    
}


-(UIView *)titleBackView
{
    if (nil == _titleBackView) {
        _titleBackView = [[UIView alloc]init];
        _titleBackView.backgroundColor = kBgColor;
        [self.view addSubview:_titleBackView];
        [_titleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(ScaleW(10)));
            make.width.equalTo(@(ScreenWidth));
            make.left.equalTo(@(0));
        }];
    }
    return _titleBackView;
}

#pragma mark - 标题
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel=[[UILabel alloc]init];
        
        _titleLabel.font=[UIFont systemFontOfSize:ScaleW(15)];
        _titleLabel.numberOfLines = 0;
        
        _titleLabel.textColor=kTitleColor;

        
        [self.titleBackView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@(ScaleW(15)));
            
            make.left.equalTo(@(ScaleW(15)));
            
            make.right.equalTo(self.titleBackView.mas_right).offset(ScaleW(-15));
            
        }];
        
    }
    return _titleLabel;
}

#pragma mark - 时间
- (UILabel *)dataLabel
{
    if (!_dataLabel)
    {
        _dataLabel=[[UILabel alloc]init];
        
        _dataLabel.font=[UIFont systemFontOfSize:ScaleW(12)];
        
        _dataLabel.textColor=kBlueColor;
        
        _dataLabel.text=[WLTools convertTimestamp:self.model.createTime.doubleValue andFormat:@"yyyy-MM-dd HH:mm"];
        
        
        [self.titleBackView addSubview:_dataLabel];
        
        [_dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            
            make.right.equalTo(@(ScaleW(-15)));
            
            make.bottom.equalTo(self.titleBackView.mas_bottom).offset(ScaleW(-10));
            
        }];
        
    }
    return _dataLabel;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectZero];
        _lineView.backgroundColor = kSubTitleColor;
        
        [self.titleBackView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(15)));
            make.right.equalTo(@(ScaleW(-15)));
            make.bottom.equalTo(@(ScaleW(0)));
            make.height.equalTo(@(ScaleW(1)));
        }];
    }
    return _lineView;
}

-(WKWebView *)webView
{
    if (nil == _webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectZero];
        
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [_webView setOpaque:FALSE];
        _webView.backgroundColor=[UIColor clearColor];
        
        if (@available(iOS 11.0, *))
        {
            
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            
            _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
            _webView.scrollView.scrollIndicatorInsets = _webView.scrollView.contentInset;
            
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets=NO;
        }
        
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.titleBackView.mas_bottom).offset(ScaleW(10));
            
            make.left.equalTo(@(ScaleW(15)));
            
            make.right.equalTo(@(ScaleW(-15)));
            
            make.width.equalTo(@(ScreenWidth));
            //            make.height.equalTo(@(0.1));
            
            make.bottom.equalTo(self.view.mas_bottom);
            
        }];
    }
    return _webView;
}


-(void)htmlStringWithString:(NSString *)htmlString
{
    NSString *newHtmlString = [NSString stringWithFormat:@"<html> \n"
                               "<head> \n"
                               "<style type=\"text/css\"> \n"
                               "body {font-size:15px;}\n"
                               "</style> \n"
                               "</head> \n"
                               "<body>"
                               "<script type='text/javascript'>"
                               "window.onload = function(){\n"
                               "var $img = document.getElementsByTagName('img');\n"
                               "for(var p in  $img){\n"
                               " $img[p].style.width = '100%%';\n"
                               "$img[p].style.height ='auto'\n"
                               "}\n"
                               "}"
                               "</script>%@"
                               "</body>"
                               "</html>",htmlString];
    
    // webView直接加载HTMLString
    //    [self.webViewContent loadHTMLString:newHtmlString baseURL:[NSURL URLWithString:nil]];
    
    [self.webView loadHTMLString:newHtmlString baseURL:[NSURL URLWithString:ProductBaseServer]];
    
}


//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//
//    [_webViewContent mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(self.titleBackView.mas_bottom).offset(ScaleW(10));
//
//        make.left.equalTo(@0);
//
//        make.right.equalTo(@0);
//
//        make.width.equalTo(@(ScreenWidth));
//
//        make.bottom.equalTo(self.view.mas_bottom);
//
//    }];
//    ///250是字体的大小,根据自己的需求修改
//    NSString* fontSize = [NSString stringWithFormat:@"%d",160];
//
//    fontSize = [fontSize stringByAppendingFormat:@"%@",@"%"];;
//
//    NSString* str = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%@'",fontSize];
////
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#ffffff'"];
////
////
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#2d3033'"];
////
//    [self.webViewContent stringByEvaluatingJavaScriptFromString:str];
//
//}


// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'"completionHandler:nil];
    
    //修改字体颜色  #9098b8
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#878ff5'"completionHandler:nil];
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSString *string = [NSString stringWithFormat:@"var script = document.createElement('script');"
                        "script.type = 'text/javascript';"
                        "script.text = \"function ResizeImages() { "
                        "var myimg,oldwidth;"
                        "var maxwidth = 1000.0;" // WKWebView中显示的图片宽度
                        "for(i=0;i <document.images.length;i++){"
                        "myimg = document.images[i];"
                        "oldwidth = myimg.width;"
                        "myimg.width = maxwidth;"
                        "}"
                        "}\";"
                        "document.getElementsByTagName('head')[0].appendChild(script);ResizeImages();"];
    
    [webView evaluateJavaScript:string completionHandler:nil];
    
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [MBProgressHUD showError:@"加载失败"];
}



#pragma mark -- 获取公告详情
- (void)setObjectid:(NSString *)objectid
{
    
    NSDictionary *params = @{@"id":objectid};
    WS(weakSelf);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_NoticeDetail_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netWorkModel.status.integerValue == SUCCESSED ) {
            
            Home_NoticeIndex_Model *model = [Home_NoticeIndex_Model mj_objectWithKeyValues:netWorkModel.data];
            //创建UI
            [weakSelf createUI];
            
            [weakSelf htmlStringWithString:model.details];
            
        }
        else
        {
            [MBProgressHUD showError:netWorkModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
    
    
}

@end
