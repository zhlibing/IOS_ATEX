//
//  MyCollectionHeaderViewRV.h
//  ZYW_MIT
//
//  Created by 赵亚明 on 2018/11/15.
//  Copyright © 2018 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineMarkControl.h"
#import "SSKJ_ScrollNotice_View.h"
#import "SSKJ_UserInfo_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyCollectionHeaderViewRV : UICollectionReusableView

@property (nonatomic,strong) UIImageView *backGroundImgeView; //!< 整个背景图标
@property (nonatomic, strong) UIImageView *assetImageView; //!< 信封背景图片
@property (nonatomic,strong) UIImageView *accountImgView; //!< 用户头像图标
@property (nonatomic,strong) UIButton * accountBtn; //!< 用户账号按钮
@property (nonatomic,strong) UIImageView * vipImageView; //!< vip小标签
@property (nonatomic,strong) UILabel * uidLabel; //!< 显示用户UID的标签
@property (nonatomic,strong) UILabel * zhzclabel; //!< 账户总资产
@property (nonatomic,strong) UILabel * pricelabel; //!< 价格
@property (nonatomic, strong) UILabel *cnyLabel; //!< 转换价格
@property (nonatomic,strong) UILabel * USDTlabel; //!< USDT标签
@property (nonatomic,strong) MineMarkControl * markControl; //!< 签到
@property (nonatomic,strong) UIView * lineView; //!< 分割线
@property (nonatomic, strong) SSKJ_ScrollNotice_View *noticeView; //!< 通知视图


@property (nonatomic,strong) SSKJ_UserInfo_Model *userModel;

@property (nonatomic,copy) void (^userBtnBlock)(void);

@property (nonatomic,copy) void (^qiandaoBtnBlock)(void);

@property (nonatomic,copy) void (^headerBlock)(void);


-(void)logout;


@end

NS_ASSUME_NONNULL_END
