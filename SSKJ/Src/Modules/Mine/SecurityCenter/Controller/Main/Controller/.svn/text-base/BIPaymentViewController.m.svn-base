//
//  BIPaymentViewController.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BIPaymentViewController.h"

@interface BIPaymentViewController () <BIPaymentBoardViewDelegate>

@property (nonatomic,strong) BIPaymentBoardView *boardView; //!< 承载视图


@end

@implementation BIPaymentViewController



#pragma mark - LifeCycle Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:kBgColor];
    [self.view addSubview:self.boardView];
}


/**
 设置操作类型
 
 @param type PayMentAddEditType
 */
-(void)setaddEditType:(PayMentAddEditType)type
{
    [self.boardView setAddEditType:type];
}


/**
 设置操作类型
 
 @param model BISecurityCenterModel 数据模型
 */
-(void)setModel:(BISecurityCenterModel*)model
{
    [self.boardView setModel:model];
}


#pragma mark - Deletage Method
-(void)paymentBoardAction:(NSInteger)sender
{
   [self dismissViewControllerAnimated:YES completion:^{}];
}





#pragma mark - Getter / Setter
-(BIPaymentBoardView*)boardView
{
    if (!_boardView)
    {
        _boardView = [[BIPaymentBoardView alloc]initWithFrame:CGRectMake(ScaleW(10),ScaleW(60), ScreenWidth-ScaleW(20), ScreenHeight-ScaleW(100))];
        [_boardView setDelegate:self];
    }
    return _boardView;
}






@end
