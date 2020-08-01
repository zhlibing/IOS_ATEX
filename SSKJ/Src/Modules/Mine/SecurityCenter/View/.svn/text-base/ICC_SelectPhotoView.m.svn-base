//
//  ICC_SelectPhotoView.m
//  ICC
//
//  Created by 张本超 on 2018/6/4.
//  Copyright © 2018年 WeiLv Technology. All rights reserved.
//

#import "ICC_SelectPhotoView.h"
@interface ICC_SelectPhotoView()
@property(nonatomic,strong)UIButton *takePhoto;
@property(nonatomic,strong)UIButton *selectLibry;
@property(nonatomic,strong)UIButton *cancellBtn;

@end
@implementation ICC_SelectPhotoView
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    self.frame = keyWindow.frame;
    self.backgroundColor = kBgColor;
    //
    self.takePhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    self.takePhoto.frame = CGRectMake(0, ScreenHeight - ScaleW(158), ScreenWidth, ScaleW(50));
    [self btn:_takePhoto font:15 textColor:kTitleColor text:@"拍照" image:nil];
    self.takePhoto.backgroundColor = kBgColor;
    [self.takePhoto addTarget:self action:@selector(takePhotoAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.takePhoto];
    //
    self.selectLibry = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectLibry.frame = CGRectMake(0, ScreenHeight - ScaleW(106), ScreenWidth, ScaleW(50));
    [self btn:_selectLibry font:15 textColor:kSubTitleColor text:@"选择相册" image:nil];
    _selectLibry.backgroundColor = kBgColor;
    [self addSubview:_selectLibry];
    [self.selectLibry addTarget:self action:@selector(selectLibryAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //
    self.cancellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancellBtn.frame = CGRectMake(0, ScreenHeight - ScaleW(50), ScreenWidth, ScaleW(50));
    [self btn:_cancellBtn font:15 textColor:[UIColor redColor] text:@"取消" image:nil];
    _cancellBtn.backgroundColor = [UIColor redColor];
    [_cancellBtn addTarget:self action:@selector(cancellAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_cancellBtn];
   
}
-(void)cancellAction:(UIButton *)sender
{
    !self.cancellAction?:self.cancellAction();
    [self removeFromSuperview];
}
-(void)showView
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
     [keyWindow addSubview:self];
     //[self viewConfig];
};
-(void)selectLibryAction:(UIButton *)sender
{
    !self.selectLibryAction?:self.selectLibryAction();
}
-(void)takePhotoAction:(UIButton *)sender
{
   !self.takePhotoAction?:self.takePhotoAction();
}
@end
