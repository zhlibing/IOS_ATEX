//
//  WL_Network_Model.h
//  WeiLv
//
//  Created by James on 16/6/3.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WL_BaseModel.h"
@interface WL_Network_Model<ObjectType> : WL_BaseModel

@property(nonatomic,strong)NSString *status;

@property(nonatomic,strong)NSString *code;

@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *message;

@property(nonatomic,assign)NSInteger total_list;

@property(nonatomic,strong)ObjectType data;



@end
