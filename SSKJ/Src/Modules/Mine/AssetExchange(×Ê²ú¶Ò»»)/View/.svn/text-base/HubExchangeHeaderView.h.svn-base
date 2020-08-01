//
//  HubExchangeHeaderView.h
//  ZYW_MIT
//
//  Created by 晶雪之恋 on 2018/9/17.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HubExchangeAssetModel.h"

@protocol HubExchangeHeaderViewDelegate <NSObject>

- (void)getExchangeInfoWithParam:(NSDictionary *)param pwd:(NSString *)pwdStr;

- (void)getExchangeModel:(HubExchangeAssetModel *)model;

@end

@interface HubExchangeHeaderView : UIView

@property (nonatomic) id <HubExchangeHeaderViewDelegate> delegate;

-(void)clearView;

- (void)refreshHeaderViewLeftWithParam:(id)param;
- (void)refreshHeaderViewRightWithParam:(id)param;

@end
