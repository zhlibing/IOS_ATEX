
//
//  Lion_AboutUsVC.m
//  SSKJ
//
//  Created by mac on 2020/3/13.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "Lion_AboutUsVC.h"
#import "SSKJ_Protocol_ViewController.h"
@interface Lion_AboutUsVC ()

@end

@implementation Lion_AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = SSKJLocalized(@"关于我们", nil);
    
    [self setUPUI];
}

- (void)setUPUI{
    self.view.backgroundColor = kBgColor;
    UIView *topLineView = [UIView new];
//    topLineView.backgroundColor = kLineColor;
    [self.view addSubview:topLineView];
    topLineView.frame = CGRectMake(0, Height_NavBar, ScreenWidth, ScaleW(10));
    UIView *firstView = [self creatCell:SSKJLocalized(@"隐私政策", nil)];
    UIView *secondView = [self creatCell:SSKJLocalized(@"用户协议", nil)];
    UIView *thiirdView = [self creatCell:SSKJLocalized(@"法律声明", nil)];
    [self.view addSubview:firstView];
    [self.view addSubview:secondView];
    [self.view addSubview:thiirdView];
    firstView.frame = CGRectMake(0, topLineView.bottom, ScreenWidth, ScaleW(50));
    secondView.frame = CGRectMake(0, firstView.bottom, ScreenWidth, ScaleW(50));
    thiirdView.frame = CGRectMake(0, secondView.bottom, ScreenWidth, ScaleW(50));
    
    firstView.tag = 0;
    secondView.tag = 1;
    thiirdView.tag = 2;
}



- (UIView *) creatCell:(NSString *)title{
    UIView *bgView = [UIView new];
    UILabel *titleLb = [UILabel new];
    UIImageView *rightImgV = [UIImageView new];
    UIView *lineV = [UIView new];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCell:)];
    bgView.userInteractionEnabled = YES;
    [bgView addGestureRecognizer:tap];
    
    [bgView addSubview:titleLb];
    [bgView addSubview:rightImgV];
    [bgView addSubview:lineV];
    titleLb.text = title;
    titleLb.textColor = kTitleColor;
    rightImgV.image = MyImage(@"我的-更多");
    lineV.backgroundColor = kLightLineColor;
    
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView.mas_left).offset(ScaleW(15));
        make.top.bottom.mas_equalTo(bgView);
    }];
    [rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bgView.mas_right).offset(ScaleW(-15));
        make.centerY.mas_equalTo(titleLb);
    }];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bgView);
        make.left.mas_equalTo(bgView.mas_left).offset(ScaleW(15));
        make.right.mas_equalTo(bgView.mas_right).offset(ScaleW(-15));
        make.height.mas_equalTo(1);
    }];
    
    return bgView;
    
    
}
- (void) clickCell:(UITapGestureRecognizer *)sender{
    UIView *view = sender.view;
    SSKJ_Protocol_ViewController *protocol = [[SSKJ_Protocol_ViewController alloc]init];
    if (view.tag == 0) {
        protocol.type = @"4";
    }else if (view.tag == 1){
        protocol.type = @"10";
    }else if (view.tag == 2){
        protocol.type = @"3";
    }
    
    [self.navigationController pushViewController:protocol animated:YES];
}

@end
