//
//  SKCertificationStateViewController.m
//  SSKJ
//
//  Created by 孙 on 2019/7/23.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SKCertificationStateViewController.h"
#import "My_PrimaryCertificate_ViewController.h"
#import "My_AdvancedCertificate_ViewController.h"



@interface SKCertificationStateViewController ()

@end

@implementation SKCertificationStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBgColor;
    [self initView];
}

-(void)initView
{
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScaleW(10))];
    line.backgroundColor = kSubBgColor;
    [self.view addSubview:line];
    
    UIImageView * stateImageView =[[UIImageView alloc] init];
    stateImageView.frame = CGRectMake(0, Height_NavBar + ScaleW(80), ScaleW(105), ScaleW(105));
    stateImageView.centerX = ScreenWidth * 0.5;
    [self.view addSubview:stateImageView];
    
    UIButton * stateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    stateButton.frame = CGRectMake(ScaleW(15), stateImageView.bottom + ScaleW(30), ScreenWidth - ScaleW(30), ScaleW(20));
    
    [stateButton addTarget:self action:@selector(stateEvent:) forControlEvents:UIControlEventTouchUpInside];
    stateButton.backgroundColor = [UIColor clearColor];
    
    
    stateButton.titleLabel.font = kFont(15);
    [stateButton setTitleColor:kTitleColor forState:UIControlStateNormal];
    
    [self.view addSubview:stateButton];
    
    
    UILabel * yuanYinLab =[[UILabel alloc] initWithFrame:CGRectMake(ScaleW(15), stateButton.bottom + ScaleW(16),ScreenWidth - ScaleW(30), ScaleW(20))];
    yuanYinLab.textColor = kSubTitleColor;
    yuanYinLab.font =  kFont(12);
    yuanYinLab.textAlignment = NSTextAlignmentCenter;
    yuanYinLab.backgroundColor =[UIColor clearColor];
    yuanYinLab.numberOfLines = 0;
    [self.view addSubview:yuanYinLab];
    switch (self.state) {
        case CertificationOngoing:
        {
            self.title = SSKJLanguage(@"认证中");
            [stateButton setTitle:SSKJLanguage(@"认证中") forState:UIControlStateNormal];
            yuanYinLab.text = SSKJLanguage(@"请耐心等待...");
            stateImageView.image= [UIImage imageNamed:@"mine_auth_s"];
            
        }
            break;
        case CertificationSuccess:
        {
            self.title = SSKJLanguage(@"认证成功");
            [stateButton setTitle:SSKJLanguage(@"恭喜您认证成功!") forState:UIControlStateNormal];
            yuanYinLab.text = @"";
            stateImageView.image= [UIImage imageNamed:@"mine_auth_s"];

        }
            break;
        case CertificationFailure:
        {
            self.title = SSKJLanguage(@"认证失败");
            stateImageView.image= [UIImage imageNamed:@"mine_auth_f"];

            NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:SSKJLanguage(@"认证失败,请") attributes:@{NSForegroundColorAttributeName:kTitleColor,NSFontAttributeName:kFont(15)}];
            
            NSAttributedString *sub = [[NSAttributedString alloc] initWithString:SSKJLanguage(@"重新认证") attributes:@{NSForegroundColorAttributeName:kBlueColor,NSFontAttributeName:kFont(15)}];
            
            [attString appendAttributedString:sub];
            
            [stateButton setAttributedTitle:attString forState:UIControlStateNormal];
            
            stateButton.titleLabel.textAlignment = NSTextAlignmentLeft;
            stateButton.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
            
            stateButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            if (self.type == 1) {
                yuanYinLab.text = @"";
            }
            else
            {
                
                yuanYinLab.text = [NSString stringWithFormat:@"%@%@", SSKJLanguage(@"失败原因:"), [SSKJ_User_Tool sharedUserTool].userInfoModel.reason];

            }
        }
            break;
            
        default:
            break;
    }
    
    
}
-(void)stateEvent:(UIButton *)sender
{
    if (self.state != CertificationFailure) {
        return;
    }
    
    switch (self.type) {
        case 1:
        {
            My_PrimaryCertificate_ViewController *vc = [[My_PrimaryCertificate_ViewController alloc]init];
            vc.successBlock = ^(NSString * _Nonnull name, NSString * _Nonnull idCard)
            {
               
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            My_AdvancedCertificate_ViewController *vc = [[My_AdvancedCertificate_ViewController alloc]init];
            vc.successBlock = ^{
                
                
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}


@end
