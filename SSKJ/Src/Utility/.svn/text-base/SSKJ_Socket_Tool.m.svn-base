//
//  SSKJ_Socket_Tool.m
//  SSKJ
//
//  Created by zpz on 2019/10/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_Socket_Tool.h"
#import "ManagerSocket.h"
#import "AFNetworkReachabilityManager.h"

static NSString * const SocketIdentifierMarket = @"SocketIdentifierMarket";
static NSString * const SocketIdentifierDeep = @"SocketIdentifierDeep";
static NSString * const SocketIdentifierPankou = @"SocketIdentifierPankou";
static NSString * const SocketIdentifierTrade = @"SocketIdentifierTrade";

@interface SSKJ_Socket_Tool()<ManagerSocketDelegate>

@property(nonatomic)BOOL needMarket;
@property(nonatomic)BOOL needDeep;
@property(nonatomic)BOOL needPankou;
@property(nonatomic)BOOL needTrade;
@property(nonatomic)BOOL needKline;

@property(nonatomic, strong)ManagerSocket *marketSocket;
@property(nonatomic, strong)ManagerSocket *deepSocket;
@property(nonatomic, strong)ManagerSocket *pankouSocket;
@property(nonatomic, strong)ManagerSocket *tradeSocket;

@property(nonatomic, strong)id code;
@property(nonatomic, weak)id<SSKJSocketToolDelegate> delegate;


@property(nonatomic, copy)NSString *marketParam;
@property(nonatomic, copy)NSString *marketCustomParam;
@property(nonatomic, copy)NSString *marketAllParam;
@property(nonatomic, copy)NSString *pankouParam;
@property(nonatomic, copy)NSString *deepParam;
@property(nonatomic, copy)NSString *tradeParam;

@end

@implementation SSKJ_Socket_Tool

- (instancetype)initWithType:(SSKJSocketType)type module:(SSKJSocketModule)module delegate:(nonnull id)delegate{
    if (self = [super init]) {
        
        if (module == SSKJSocketModuleHeYue) {
            self.marketParam = @"goods_list_lever";
            self.marketCustomParam = @"self_select_lever";
            self.marketAllParam = @"goods_list_all_lever";
            self.deepParam = @"depth_list_lever";
            self.pankouParam = @"buy_sell_five_lever";
            self.tradeParam = @"trader_info_lever";
        }else{
            self.marketParam = @"goods_list";
            self.marketCustomParam = @"self_select";
            self.marketAllParam = @"goods_list_all";
            self.deepParam = @"depth_list";
            self.pankouParam = @"buy_sell_five";
            self.tradeParam = @"trader_info";
        }
        
        self.needMarket = type & SSKJSocketTypeMarket;
        self.needDeep = type & SSKJSocketTypeDeep;
        self.needPankou = type & SSKJSocketTypePanKou;
        self.needTrade = type & SSKJSocketTypeTrade;
        if (type & SSKJSocketTypeKLine) {
            self.needKline = YES;
            self.needMarket = YES;
        }
        
        self.delegate = delegate;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(networkDidChanged) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    }
    return self;
}


- (void)openSocketWithCode:(id)sender{
    self.code = sender;
    [self openSocket];
}
- (void)openSocket{
    if (!self.code) {
        return;
    }
    [self closeSocket];
    
    if (self.needKline) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(kLineNeedRequest)]) {
            [self.delegate kLineNeedRequest];
        }
    }
    
    WS(weakSelf);
    if (self.needMarket) {
        self.marketSocket.delegate = self;
        [self.marketSocket openConnectSocketWithConnectSuccess:^{
            NSString *type;
            if ([weakSelf.code isKindOfClass:[NSArray class]]) {
                type = [weakSelf convertToJson:@{@"type":weakSelf.marketCustomParam, @"list":weakSelf.code}];
            }else{
                
                if ([weakSelf.code isKindOfClass:[NSString class]]) {
                    NSString *code = weakSelf.code;
                    if (code.length) {
                        type = [weakSelf convertToJson:@{@"type":weakSelf.marketParam, @"code":code}];
//                        type = [weakSelf convertToJson:@{@"type":@"self_select", @"list":@[code]}];
                    }else{
                        type = [weakSelf convertToJson:@{@"type":weakSelf.marketAllParam}];
                    }
                    
                }else{
                    return;
                }
    
            }

            [weakSelf.marketSocket socketSendMsg:type];
        }];
    }
    
    if (self.needDeep) {
        self.deepSocket.delegate = self;
        [self.deepSocket openConnectSocketWithConnectSuccess:^{
            NSString *type;
            if ([weakSelf.code isKindOfClass:[NSArray class]]) {
                type = [weakSelf convertToJson:@{@"type":weakSelf.deepParam, @"list":weakSelf.code}];
            }else{
                
                if ([weakSelf.code isKindOfClass:[NSString class]]) {
                    type = [weakSelf convertToJson:@{@"type":weakSelf.deepParam, @"list":@[weakSelf.code]}];
                    
                }else{
                    return;
                }
                
            }
            
            [weakSelf.deepSocket socketSendMsg:type];
        }];
    }
    
    
    if (self.needPankou) {
        self.pankouSocket.delegate = self;
        [self.pankouSocket openConnectSocketWithConnectSuccess:^{
            NSString *type;
            if ([weakSelf.code isKindOfClass:[NSArray class]]) {
                type = [weakSelf convertToJson:@{@"type":weakSelf.pankouParam, @"list":weakSelf.code}];
            }else{
                
                if ([weakSelf.code isKindOfClass:[NSString class]]) {
                    type = [weakSelf convertToJson:@{@"type":weakSelf.pankouParam, @"list":@[weakSelf.code]}];
                    
                }else{
                    return;
                }
                
            }
            
            [weakSelf.pankouSocket socketSendMsg:type];
        }];
    }
    
    if (self.needTrade) {
        self.tradeSocket.delegate = self;
        [self.tradeSocket openConnectSocketWithConnectSuccess:^{
            NSString *type;
            if ([weakSelf.code isKindOfClass:[NSArray class]]) {
                type = [weakSelf convertToJson:@{@"type":weakSelf.tradeParam, @"list":weakSelf.code}];
            }else{
                
                if ([weakSelf.code isKindOfClass:[NSString class]]) {
                    type = [weakSelf convertToJson:@{@"type":weakSelf.tradeParam, @"list":@[weakSelf.code]}];
                    
                }else{
                    return;
                }
                
            }
            
            [weakSelf.tradeSocket socketSendMsg:type];
        }];
    }
}

- (NSString *)convertToJson:(NSDictionary *)theData{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:kNilOptions error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

- (void)closeSocket{
    if (self.needMarket) {
        if (self.marketSocket.socketIsConnected) {
            self.marketSocket.delegate = nil;
            [self.marketSocket closeConnectSocket];
        }
    }
    
    if (self.needDeep) {
        if (self.deepSocket.socketIsConnected) {
            self.deepSocket.delegate = nil;
            [self.deepSocket closeConnectSocket];
        }
    }
    
    if (self.needPankou) {
        if (self.pankouSocket.socketIsConnected) {
            self.pankouSocket.delegate = nil;
            [self.pankouSocket closeConnectSocket];
        }
    }
    
    if (self.needTrade) {
        if (self.tradeSocket.socketIsConnected) {
            self.tradeSocket.delegate = nil;
            [self.tradeSocket closeConnectSocket];
        }
    }

}


#pragma mark - 收到推送
/*
 
 SocketIdentifierTrade
 {
 "code":"BTC/USDT",
 "name":"BTC/USDT",
 "timestamp":1571895166003,
 "data":[
     {
         "dt":1571895165936,
         "dc":"sell",
         "amount":0.084008,
         "price":7421.42
     },
     {
         "dt":1571895165863,
         "dc":"sell",
         "amount":0.00022,
         "price":7421.43
     }]
 }
 
 
 SocketIdentifierPankou
 {
     "code":"BTC/USDT",
     "name":"BTC/USDT",
     "timestamp":1571895166249,
     "asks":[
     {
         "totalSize":1.1,
         "price":7421.77
     },
     {
         "totalSize":0.5,
         "price":7421.8
     }],
     "bids":[
     {
         "totalSize":1.1,
         "price":7421.77
     },
     {
         "totalSize":0.5,
         "price":7421.8
     }]
 }
 
 SocketIdentifierDeep
 {
     "code":"BTC/USDT",
     "name":"BTC/USDT",
     "timestamp":1571895166249,
     "asks":[
     {
         "totalSize":1.1,
         "price":7421.77
     },
     {
         "totalSize":0.5,
         "price":7421.8
     }],
     "bids":[
     {
         "totalSize":1.1,
         "price":7421.77
     },
     {
         "totalSize":0.5,
         "price":7421.8
     }]
 }
 
 SocketIdentifierMarket
 {
     "code":"BTC/USDT",
     "name":"BTC/USDT",
     "date":"2019-10-24",
     "time":"13:46:42",
     "timestamp":1571896002994,
     "price":7415.69,
     "cnyPrice":51909.829999999994,
     "open":7430.01,
     "high":7533.73,
     "low":7300,
     "close":7415.69,
     "volume":134397752.88108405,
     "change":-14.320000000000618,
     "changeRate":"-0.19%",
     "buy":7415.7,
     "sell":7415.77
 }
 */
-(void)socketDidReciveData:(id)data identifier:(NSString *)identifier
{
    if (!data) {
        return;
    }
    
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error:&error];
    if (error) {
        return;
    }
    
    if ([identifier isEqualToString:SocketIdentifierMarket]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(marketSocketDidUpdate:)]) {
            [self.delegate marketSocketDidUpdate:dic];
        }
    }
    
    if ([identifier isEqualToString:SocketIdentifierDeep]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(deepSocketDidUpdate:)]) {
            [self.delegate deepSocketDidUpdate:dic];
        }
    }
    
    if ([identifier isEqualToString:SocketIdentifierPankou]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(pankouSocketDidUpdate:)]) {
            [self.delegate pankouSocketDidUpdate:dic];
        }
    }
    
    if ([identifier isEqualToString:SocketIdentifierTrade]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(tradeSocketDidUpdate:)]) {
            [self.delegate tradeSocketDidUpdate:dic];
        }
    }
}

#pragma mark - 页面状态改变
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)networkDidChanged
{
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    if (status > 1) {
        [self openSocket];
    }else{
    }
}

-(void)applicationDidBecomeActive
{
    [self openSocket];
}

-(void)applicationDidEnterBackground
{
    [self closeSocket];
}

#pragma mark - 懒加载
-(ManagerSocket *)marketSocket
{
    if (nil == _marketSocket) {
        _marketSocket = [[ManagerSocket alloc]initWithUrl:MarketSocketUrl identifier:SocketIdentifierMarket];
    }
    return _marketSocket;
}

- (ManagerSocket *)deepSocket{
    if (nil == _deepSocket) {
        _deepSocket = [[ManagerSocket alloc]initWithUrl:MarketSocketUrl identifier:SocketIdentifierDeep];
    }
    return _deepSocket;
}

- (ManagerSocket *)pankouSocket{
    if (nil == _pankouSocket) {
        _pankouSocket = [[ManagerSocket alloc]initWithUrl:MarketSocketUrl identifier:SocketIdentifierPankou];
    }
    return _pankouSocket;
}

- (ManagerSocket *)tradeSocket{
    if (nil == _tradeSocket) {
        _tradeSocket = [[ManagerSocket alloc]initWithUrl:MarketSocketUrl identifier:SocketIdentifierTrade];
    }
    return _tradeSocket;
}

@end
