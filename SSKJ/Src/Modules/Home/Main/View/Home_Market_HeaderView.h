//
//  Hebi_Market_HeaderView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/9.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SSKJ_Market_Index_Model.h"

#import "Home_MarketBanner_Model.h"
#import "SSKJ_ScrollNotice_View.h"
#import "Home_NoticeIndex_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface Home_Market_HeaderView : UIView
@property (nonatomic, strong) SSKJ_ScrollNotice_View *noticeView;
@property (nonatomic, copy) void (^bannerBlock)(NSInteger index);    // 点击轮播图回调
@property (nonatomic, copy) void (^noticeBlock)(NSInteger index);   // 公告轮播点击回调
@property (nonatomic, copy) void (^noticeMoreBlock)(void);    // 公告更多
@property (nonatomic, copy) void (^hotCoinBlock)(SSKJ_Market_Index_Model *coinModel);// 热门币种点击回调

@property (nonatomic, copy) void (^invicateBlock)(void);


-(void)setBannerArray:(NSArray *)bannerArray;

-(void)setNoticeArray:(NSArray *)noticeArray;

@property(nonatomic, strong)NSArray<SSKJ_Market_Index_Model *> *coinArray;


@end

NS_ASSUME_NONNULL_END
