//
//  My_Generalize_BottomView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Generalize_BottomView.h"

@interface My_Generalize_BottomView ()
@property (nonatomic, strong) UIButton *privacyButton;//    隐私条款
@property (nonatomic, strong) UIButton *serviceButton;  // 服务协议
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *versionLabel;    // 当前版本
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UIView *imageBackView;

@end

@implementation My_Generalize_BottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

        [self setUI];
    }
    return self;
}


#pragma mark - 用户操作
-(void)serviceEvent
{
    if (self.serviceBlock) {
        self.serviceBlock();
    }
}

-(void)privateEvent
{
    if (self.privateBlock) {
        self.privateBlock();
    }
}


-(void)btnClicked:(UITapGestureRecognizer *)tap
{
    UIView *view = tap.view;
    if (view.tag == 100) {
        if (self.faceBookBlock) {
            self.faceBookBlock();
        }
    }else if (view.tag == 101){
        if (self.tweentterBlock) {
            self.tweentterBlock();
        }
    }else if (view.tag == 102){
        if (self.gitHubBlock) {
            self.gitHubBlock();
        }
    }
    
}






#pragma mark - Getter / Setter
-(void)setUI
{
    [self addSubview:self.lineView];

    [self addSubview:self.privacyButton];
    [self addSubview:self.serviceButton];
    [self addSubview:self.versionLabel];
    [self addSubview:self.messageLabel];
    [self addButtons];
    
    self.height = self.imageBackView.bottom + ScaleW(10);
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(self.width / 2, 0, 1, ScaleW(14))];
        _lineView.backgroundColor = kSubTitleColor;
    }
    return _lineView;
}

- (UIButton *)privacyButton
{
    if (nil == _privacyButton) {
        
        NSString *title = SSKJLocalized(@"隐私条款", nil);
        CGFloat width = [WLTools getWidthWithText:title font:systemFont(ScaleW(14))];
        _privacyButton = [[UIButton alloc]initWithFrame:CGRectMake(self.lineView.x - width - ScaleW(3), 0, width, ScaleW(14))];
        [_privacyButton setTitle:title forState:UIControlStateNormal];
        
        [_privacyButton setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        _privacyButton.titleLabel.font = systemFont(ScaleW(14));
        [_privacyButton addTarget:self action:@selector(privateEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _privacyButton;
}


- (UIButton *)serviceButton
{
    if (nil == _serviceButton) {
        NSString *title = SSKJLocalized(@"服务协议", nil);
        CGFloat width = [WLTools getWidthWithText:title font:systemFont(ScaleW(14))];
        _serviceButton = [[UIButton alloc]initWithFrame:CGRectMake(self.lineView.right + ScaleW(3), 0, width, ScaleW(14))];
        [_serviceButton setTitle:title forState:UIControlStateNormal];
        [_serviceButton setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        _serviceButton.titleLabel.font = systemFont(ScaleW(14));
        [_serviceButton addTarget:self action:@selector(serviceEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _serviceButton;
}

- (UILabel *)versionLabel
{
    if (nil == _versionLabel) {
        
         NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        // app名称
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        _versionLabel = [WLTools allocLabel:[NSString stringWithFormat:@"%@V%@",SSKJLocalized(@"当前版本", nil),app_Version] font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(0, self.lineView.bottom + ScaleW(17), self.width, ScaleW(12)) textAlignment:NSTextAlignmentCenter];
    }
    return _versionLabel;
}

- (UILabel *)messageLabel
{
    if (nil == _messageLabel) {
        
        _messageLabel = [WLTools allocLabel:@"Copying © 2019 BI ECOLOGY.All rights reserved" font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(0, self.versionLabel.bottom + ScaleW(8), self.width, ScaleW(12)) textAlignment:NSTextAlignmentCenter];
    }
    return _messageLabel;
}

-(void)addButtons
{
    NSArray *imageNames = @[@"f",@"twitter",@"mm"];
    [self addSubview:self.imageBackView];
    CGFloat startX = 0;
    
    
    double tag = 100;
    for (NSString *imageName in imageNames)
    {
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(startX, 0, ScaleW(image.size.width), ScaleW(image.size.height))];
        imageView.image = image;
        [self.imageBackView addSubview:imageView];
        startX += imageView.size.width + ScaleW(10);
        imageView.tag = tag++;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClicked:)];
        [imageView addGestureRecognizer:tap];
        
    }
    UIImage *image = [UIImage imageNamed:@"twitter"];
    self.imageBackView.width = ScaleW(image.size.width)*3 + ScaleW(20);
    self.imageBackView.centerX = self.width / 2;
}

-(UIView *)imageBackView
{
    if (nil == _imageBackView) {
        _imageBackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.messageLabel.bottom +ScaleW(10), 0, ScaleW(14))];        
    }
    return _imageBackView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
