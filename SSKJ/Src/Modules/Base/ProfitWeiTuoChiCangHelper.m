//
//  ProfitWeiTuoChiCangHelper.m
//  SSKJ
//
//  Created by 姚立志 on 2020/9/10.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "ProfitWeiTuoChiCangHelper.h"
#import "Heyue_OrderDdetail_Model.h" //!< 委托
#import "LJWeakProxy.h"


@interface ProfitWeiTuoChiCangHelper ()


@property (nonatomic, strong) NSTimer *timer;




@end


@implementation ProfitWeiTuoChiCangHelper

static ProfitWeiTuoChiCangHelper *shareHelper = nil;

+(ProfitWeiTuoChiCangHelper *)shareHelper
{
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken,
        ^{
            shareHelper = [[self alloc] init];
        });
  
    return shareHelper;
}




#pragma mark 开启定时器
-(void)startRuntimer
{
    if (kLogin)
    {
        [self stopRuntimer];
        // 这里的target又发生了变化
        self.timer = [NSTimer timerWithTimeInterval:3.0 target:[LJWeakProxy proxyWithTarget:self] selector:@selector(getProfitWeiTuoChiCang) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        [self.timer fire];
    }
}


#pragma mark 关闭定时器
-(void)stopRuntimer
{
    [self.timer invalidate];
    self.timer = nil;
}










-(void)getProfitWeiTuoChiCang
{
    NSLog(@"获取盈亏/委托/持仓");
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_Userdatas_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject)
    {
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200)
        {
            #pragma mark 盈亏数据
            Heyue_OrderInfo_Model *model = [Heyue_OrderInfo_Model mj_objectWithKeyValues:[netModel.data objectForKey:@"statistics"]];

            #pragma mark 委托数据
            NSArray *weituoArray = [Heyue_OrderDdetail_Model mj_objectArrayWithKeyValuesArray:netModel.data[@"weituo"]];
            
            #pragma mark 持仓数据
            NSMutableArray *chicangArray = [Heyue_OrderDdetail_Model mj_objectArrayWithKeyValuesArray:netModel.data[@"cicang"]];
            if (shareHelper.getProfitWeiTuoChiCangBlock)
            {
                shareHelper.getProfitWeiTuoChiCangBlock(model, weituoArray, chicangArray);
            }
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        
    }];
}






@end
