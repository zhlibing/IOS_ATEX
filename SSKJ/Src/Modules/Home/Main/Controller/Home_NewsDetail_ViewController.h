//
//  My_NewsDetail_ViewController.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/2.
//  Copyright © 2019年 Wang. All rights reserved.
//
#import "SSKJ_BaseViewController.h"
#import "Home_NoticeIndex_Model.h"
#import "News_SystemConsult_Model.h"
#import "News_Zizun_Index_Model.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DetailType) {
    DetailTypeDealGuide,// 交易指南
    DetailTypeNews,     // 资讯
    DetailTypeNotice,    //  平台公告
    
    DetailTypeBB,    // 币币
    DetailTypeFB,    // 法币
    DetailTypeHelperCenter,    // 帮助中心
    
};

@interface Home_NewsDetail_ViewController : SSKJ_BaseViewController

@property (nonatomic, assign) DetailType detailType;

@property (nonatomic, copy) NSString *newsID;

@property (nonatomic,assign) NSInteger fromVC;

@property (nonatomic, strong)Home_NoticeIndex_Model *model;

@property (nonatomic, strong) News_SystemConsult_Model *systemModel;

@property (nonatomic, strong) News_Zizun_Index_Model *newsModel;
@end

NS_ASSUME_NONNULL_END
