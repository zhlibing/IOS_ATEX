//
//  BIExchangeAlertTableView.h
//  SSKJ
//
//  Created by 姚立志 on 2019/6/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BIExchangeAlertTableViewCell.h"

@protocol BIExchangeAlertTableViewDelegate <NSObject>


-(void)didSelectRowAtIndexPathObject:(BIExchangeModel*)object;

@end


NS_ASSUME_NONNULL_BEGIN

@interface BIExchangeAlertTableView : UITableView <UITableViewDelegate,UITableViewDataSource>


- (instancetype)initWithDelegate:(id <BIExchangeAlertTableViewDelegate>)deletage;


-(void)setItemObjectArray:(NSMutableArray *)itemArray;


@end

NS_ASSUME_NONNULL_END
