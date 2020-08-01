//
//  SSKJ_TabbarController.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/12/6.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import "SSKJ_TabbarController.h"

#import "UIImage+RoundedRectImage.h"

#import "SSKJ_BaseNavigationController.h"

#import "Home_Root_ViewController.h"

#import "Mine_Root_ViewController.h"

#import "News_Root_ViewController.h"
#import "Lion_AssetsMainPageVC.h"

/*
 @"News_Root_ViewController",
 @"资讯",
 @"root_nwes",
 ,@"root_nwes_s",
 */

//#define kControllerNameArray @[@"Home_Root_ViewController",@"HEYue_ViewController",@"Lion_AssetsMainPageVC",@"Mine_Root_ViewController"]
//#define kControllerTitleArray @[@"首页",@"永续合约",@"资产",@"我的"]
//#define kImageNameArray @[@"首页-nor",@"合约-未选择",@"资产-未选择",@"我的-未选择"]
//#define kSelectedImageNameArray @[@"首页-pre",@"合约-选择",@"资产-选择",@"我的-已选择"]


#define kControllerNameArray @[@"Home_Root_ViewController",@"News_Root_ViewController",@"HEYue_ViewController",@"Lion_AssetsMainPageVC",@"Mine_Root_ViewController"]
#define kControllerTitleArray @[@"首页",@"资讯",@"合约",@"资产",@"我的"]
#define kImageNameArray @[@"首页-nor",@"资讯-未选择",@"合约-未选择",@"资产-未选择",@"我的-未选择"]
#define kSelectedImageNameArray @[@"首页-pre",@"资讯-选择",@"合约-选择",@"资产-选择",@"我的-已选择"]



//test
//#define kControllerNameArray @[@"Lion_AssetsMainPageVC",@"Mine_Root_ViewController"]
//
//#define kControllerTitleArray @[@"资产",@"我的"]
//#define kImageNameArray @[@"资产-未选择",@"我的-未选择"]
//#define kSelectedImageNameArray @[@"资产-选择",@"我的-已选择"]




@interface SSKJ_TabbarController ()<UITabBarControllerDelegate>
@end

@implementation SSKJ_TabbarController
/**
 *  当第一次使用这个类或者子类的时候调用，作用：初始化
 */
#pragma mark - 改变 tabbar 选中状态下的文字颜色
+ (void)initialize
{
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kSubTitleColor, NSForegroundColorAttributeName, systemFont(11), NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kBlueColor, NSForegroundColorAttributeName, systemFont(11), NSFontAttributeName,nil] forState:UIControlStateSelected];
    
    UITabBar *tabBar = [UITabBar appearance];
    
    [tabBar setBarTintColor:kBgColor];
    
    tabBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    // 添加所有子控制器
    [self addAllChildViewController];
}

#pragma mark - 加载所有的子控制器
- (void)addAllChildViewController
{
    for (int i = 0; i < kControllerNameArray.count; i++)
    {
        NSString *controllerStr = kControllerNameArray[i];
        NSString *title = SSKJLocalized(kControllerTitleArray[i],nil);
        NSString *image = kImageNameArray[i];
        NSString *selectedImage = kSelectedImageNameArray[i];
        id controller = [[NSClassFromString(controllerStr) alloc] init] ;
        [self addChildVC:controller title:title image:image selectedImage:selectedImage];
    }
    
}

/**
 *  添加子控制器
 *
 *  @param childVC      子控制器
 *  @param title        标题
 *  @param image        正常状态图片
 *  @param seletedImage 选中时的图片
 */
- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)seletedImage
{
    SSKJ_BaseNavigationController *naviVC = [[SSKJ_BaseNavigationController alloc] initWithRootViewController:childVC];
    
    childVC.tabBarItem.image = [UIImage imageWithOriginalName:image];
    
    childVC.tabBarItem.selectedImage = [UIImage imageWithOriginalName:seletedImage];
    
    naviVC.tabBarItem.title = title;
    
    [self addChildViewController:naviVC];
    
}



#pragma mark - UITabBarControllerDelegate

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    [SSTool setIsRoot:YES];
    return YES;
}

@end
