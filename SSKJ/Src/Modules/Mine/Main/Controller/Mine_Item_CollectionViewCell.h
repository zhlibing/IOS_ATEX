//
//  Mine_Item_CollectionViewCell.h
//  SSKJ
//
//  Created by zpz on 2019/12/7.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Mine_Item_CollectionViewCell : UICollectionViewCell

@property(nonatomic, strong)UIView *backView;

@property(nonatomic, strong)UIImageView *iconImageView;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic ,strong) UIImageView *rightimgV;
@property (nonatomic ,strong) UIView *bottomLineView;

@end

NS_ASSUME_NONNULL_END
