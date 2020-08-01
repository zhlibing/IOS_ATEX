//
//  Home_NoticeIndex_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/6/28.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Home_NoticeIndex_Model : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *title;    //标题
@property (nonatomic, copy) NSString *content;    //内容

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *updated_at;

@end

NS_ASSUME_NONNULL_END
