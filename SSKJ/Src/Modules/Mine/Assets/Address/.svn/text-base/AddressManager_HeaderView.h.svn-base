//
//  AddressManager_HeaderView.h
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/15.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WalletType) {
    WalletTypeOMNI,
    WalletTypeERC20,
};

NS_ASSUME_NONNULL_BEGIN

@interface AddressManager_HeaderView : UIView
@property (nonatomic, assign) WalletType walletType;

@property (nonatomic, copy) void (^changeWalletTypeBlock)(WalletType walletType);
@end

NS_ASSUME_NONNULL_END
