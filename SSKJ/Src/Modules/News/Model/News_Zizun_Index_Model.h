//
//  BI_Zizun_Index_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/7/1.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface News_Zizun_Index_Model : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *created_at;   //发布日期
@property (nonatomic, copy) NSString *title;  //标题
@property (nonatomic, copy) NSString *pic_addr;  //图片url地址
@property (nonatomic, copy) NSString *abstracts;    //摘要
@property (nonatomic, copy) NSString *content;    //详情内容
@property (nonatomic, copy) NSString *updated_at;   //


//@property(nonatomic, strong)NSAttributedString *attributeContent;
@end

NS_ASSUME_NONNULL_END
