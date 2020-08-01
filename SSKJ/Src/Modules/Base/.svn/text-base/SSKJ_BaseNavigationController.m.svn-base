//
//  SSKJ_BaseNavigationController.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/12/6.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import "SSKJ_BaseNavigationController.h"
#import "LoginViewController.h"
@interface SSKJ_BaseNavigationController ()<UINavigationControllerDelegate>

@end

@implementation SSKJ_BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.translucent = YES;
    self.navigationBar.barTintColor = kWhiteColor;
//    self.navigationBar.tintColor = [UIColor whiteColor];
    
    // 去除navigationbar下面的线
//    CGRect rect = CGRectMake(0, 0, ScreenWidth, Height_NavBar);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context,[UIColor whiteColor].CGColor);
//    CGContextFillRect(context, rect);
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:kBgColor] forBarMetrics:UIBarMetricsDefault];

    
    self.delegate = self;
    
    WS(weakSelf);
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}


#pragma mark - 设置侧滑返回功能
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    
    [SSTool setIsRoot:YES];

    if (self.childViewControllers.count != 0 ) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.backBarButtonItem = nil;
    }
    [super pushViewController:viewController animated:animated];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.viewControllers.count > 1;
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    //使navigationcontroller中第一个控制器不响应右滑pop手势
    if (navigationController.viewControllers.count == 1) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
        navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
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
