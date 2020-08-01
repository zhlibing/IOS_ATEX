//
//  ATEX_AssetRecord_ViewController.h
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/16.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

typedef NS_ENUM(NSUInteger, AssetType) {
    AssetTypeCharge,
    AssetTypeExtract,
    AssetTypeOther,
};

NS_ASSUME_NONNULL_BEGIN

@interface ATEX_AssetRecord_ViewController : SSKJ_BaseViewController

@property (nonatomic, assign) AssetType assetType;

@end

NS_ASSUME_NONNULL_END
