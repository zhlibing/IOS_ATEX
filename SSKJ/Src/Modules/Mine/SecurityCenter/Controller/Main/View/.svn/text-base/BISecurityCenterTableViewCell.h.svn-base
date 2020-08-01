//
//  BISecurityCenterTableViewCell.h
//  SSKJ
//
//  Created by 姚立志 on 2019/6/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BISecuritySwitchControl.h"



@protocol BISecurityCenterTableViewCellDelegate <NSObject>

-(void)switchControlAction:(BISecuritySwitchControl *_Nullable)sender;

-(void)editBtnAction:(BISecuritySwitchControl *_Nullable)sender;

@end



NS_ASSUME_NONNULL_BEGIN

@interface BISecurityCenterTableViewCell : UITableViewCell


@property (nonatomic,strong) BISecurityCenterModel *model; //!< 设置数据模型




-(void)setDelegate:(id<BISecurityCenterTableViewCellDelegate>)delegate withIndexPath:(NSInteger)indexPath;





@end

NS_ASSUME_NONNULL_END
