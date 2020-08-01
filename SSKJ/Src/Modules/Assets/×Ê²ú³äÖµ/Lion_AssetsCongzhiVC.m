//
//  Lion_AssetsCongzhiVC.m
//  SSKJ
//
//  Created by mac on 2020/4/3.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "Lion_AssetsCongzhiVC.h"
#import "Lion_bit-Swift.h"
@interface Lion_AssetsCongzhiVC ()

@end

@implementation Lion_AssetsCongzhiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = SSKJLocalized(@"充值", nil);
    
    
    UIButton *ocBtn = [UIButton new];
    [ocBtn setTitle:@"toSwift" forState:UIControlStateNormal];
    [ocBtn addTarget:self action:@selector(goSwift) forControlEvents:UIControlEventTouchUpInside];
    ocBtn.frame = CGRectMake(0, 0, 200, ScaleW(40));
    ocBtn.center  = self.view.center;
    [self.view addSubview:ocBtn];
    ocBtn.backgroundColor = [UIColor greenColor];
    NSLog(@"------------%f", ScaleW(40));
    if (@available(iOS 11.0, *)) {
        NSLog(@"安全区域   %lf", [UIApplication sharedApplication].keyWindow.safeAreaInsets.top);
    } else {
        // Fallback on earlier versions
    }
    
}

- (void) goSwift{
    Lion_AssetsCZ_VC *vc = [Lion_AssetsCZ_VC new];
    vc.btnClickCallback = ^(NSInteger index) {
        NSLog(@"swift 返回的数据 %ld", index);
    };
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


@end
