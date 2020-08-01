//
//  Home_Coin_View.m
//  SSKJ
//
//  Created by zpz on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Home_Coin_View.h"
#import "Home_Coin_CollectionViewCell.h"
@interface Home_Coin_View()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic)NSInteger totalNum;


@end

@implementation Home_Coin_View

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kSubBgColor;
        self.totalNum = 3;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    CGFloat left = ScaleW(5);
    CGFloat space = ScaleW(5);
    NSInteger row = 3;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((self.width - left * 2 - space * (row - 1))/row, self.height);
    layout.minimumLineSpacing = space;
    layout.minimumInteritemSpacing = space;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[Home_Coin_CollectionViewCell class] forCellWithReuseIdentifier:@"Home_Coin_CollectionViewCell"];
    _collectionView.contentInset = UIEdgeInsetsMake(0, left, 0, left);
    _collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = kBgColor;
    [self addSubview:_collectionView];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return MIN(self.array.count, self.totalNum);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Home_Coin_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Home_Coin_CollectionViewCell" forIndexPath:indexPath];
    cell.model = self.array[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectBlock) {
        self.selectBlock(indexPath.row);
    }
}


- (void)setArray:(NSArray *)array{
    _array = array;
    [self.collectionView reloadData];
}
@end
