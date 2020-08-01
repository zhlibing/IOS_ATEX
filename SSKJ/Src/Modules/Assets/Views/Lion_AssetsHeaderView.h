//
//  Lion_AssetsHeaderView.h
//  SSKJ
//
//  Created by mac on 2020/3/12.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lion_Assets_new_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface Lion_AssetsHeaderView : UIView
@property (nonatomic ,copy)void(^actionBlock)(NSInteger indexP);
@property (nonatomic ,strong) Lion_Assets_new_Model *model;
- (void) clearData;
@end

NS_ASSUME_NONNULL_END
