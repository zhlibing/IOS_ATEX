//
//  TransferAccount_Record_Controller.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2018/8/7.
//  Copyright © 2018年 Wang. All rights reserved.
//
#import "SSKJ_BaseViewController.h"
#import "HubExchangeAssetModel.h"

@interface TransferAccount_Record_Controller : SSKJ_BaseViewController

//  0.兑换记录 1.转账记录
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) HubExchangeAssetModel *assetModel;

@end
