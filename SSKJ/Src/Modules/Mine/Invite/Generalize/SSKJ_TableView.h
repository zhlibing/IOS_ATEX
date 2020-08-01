//
//  SSKJ_TableView.h
//  SSKJ
//
//  Created by 姚立志 on 2019/10/23.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSKJ_TableView : UITableView

- (instancetype)initWitDeletage:(UIViewController*)delegate;


- (instancetype)initWithFrame:(CGRect)frame witDeletage:(UIViewController*)delegate;


-(void)endRefresh;



@end




NS_ASSUME_NONNULL_END
