//
//  FRCameraViewController.h
//  photo
//
//  Created by Sweet on 2016/11/16.
//  Copyright © 2016年 sweet. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FRCameraViewController;

@protocol CameraAchieveToImageDelegate <NSObject>
@required
- (void)CameraAchieveToImageDelegate:(FRCameraViewController *)ViewController Withimage:(UIImage *)image;
@end

@interface FRCameraViewController : UIViewController

/** 背景图片  */
@property (nonatomic, strong) UIImage * backImage;

/** 默认摄像头  */
@property (nonatomic, assign) BOOL isShouldOpenFrontCamera;

@property (strong, nonatomic) UIButton *switchButton;
/** 代理*/
@property (nonatomic, weak) id<CameraAchieveToImageDelegate> delegate;
@end
