//
//  BI_AssetExtractInfo_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/7/1.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Mine_AssetTiBiInfo_Model : NSObject

@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *fee;    //提币手续费
@property (nonatomic, copy) NSString *min;   //最小提币数
@property (nonatomic, copy) NSString *max;  //最大提币数
@property (nonatomic, copy) NSString *balance;    //账号余额


@end

NS_ASSUME_NONNULL_END
