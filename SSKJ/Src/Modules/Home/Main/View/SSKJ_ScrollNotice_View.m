//
//  VPay_Shop_Notice_View.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/8/23.
//  Copyright © 2018年 James. All rights reserved.
//

#import "SSKJ_ScrollNotice_View.h"
#import "XBTextLoopView.h"
#define kTimeInterval 3

@interface SSKJ_ScrollNotice_View()
{
    NSInteger _currentNoticeIndex;
    dispatch_source_t _dispath_timer;
}
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSMutableArray *noticeArray;
@property (nonatomic, strong) NSMutableArray *noticeLabelArray;
@property (nonatomic, strong) XBTextLoopView *textLoopView;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, assign) BOOL reStart;

@end

@implementation SSKJ_ScrollNotice_View

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = YES;
        [self addSubview:self.imageView];
        [self addSubview:self.moreButton];
        [self addSubview:self.lineView];
        [self setNoticeArray:@[@"",@""]];
    }
    return self;
}

- (void)configureModels:(NSArray *)models
{
    [self.textLoopView removeFromSuperview];
    NSMutableArray *contentsArray = [[NSMutableArray alloc]init];
    for (NSString *notice in models)
    {
        
        [contentsArray addObject:notice];
    }
    WS(weakSelf);
    self.textLoopView = [XBTextLoopView textLoopViewWith:contentsArray loopInterval:2 initWithFrame:CGRectMake(self.imageView.right+ScaleW(15), ScaleW(3), (ScreenWidth-self.imageView.right-ScaleW(15) - self.moreButton.width -ScaleW(15) ), ScaleW(40)) selectBlock:^(NSString *selectString, NSInteger index) {
        if (weakSelf.clickBlock) {
            weakSelf.clickBlock(index);
        }
    }];
    self.textLoopView.centerY = self.height * 0.5;
    self.textLoopView.contentColor = kTitleColor;
    self.textLoopView.backgroundColor = [UIColor clearColor];

    [self addSubview:self.textLoopView];
    [self setNoticeArray:contentsArray];
}

-(NSMutableArray *)noticeLabelArray
{
    if (nil == _noticeLabelArray) {
        _noticeLabelArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _noticeLabelArray;
}

-(UIImageView *)imageView
{
    if (nil == _imageView)
    {
        UIImage *image = [UIImage imageNamed:@"home_notice"];
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(15), ScaleW(image.size.width), ScaleW(image.size.height))];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
        [_imageView setImage:image];
        _imageView.centerY = self.height / 2;
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreEvent)];
        [_imageView addGestureRecognizer:tap];
    }
    return _imageView;
}

-(UIView *)lineView
{
    if (nil == _lineView)
    {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), self.height - 0.5, ScreenWidth - ScaleW(30), 0.5)];
        _lineView.backgroundColor = kSubBgColor;
//        _lineView.backgroundColor = KRedColor;
        _lineView.centerY = self.imageView.centerY + ScaleW(18);
    }
    return _lineView;
}





-(UIButton *)moreButton
{
    if (nil == _moreButton) {
        _moreButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - ScaleW(15) - ScaleW(45), 0, ScaleW(45), self.height)];
        _moreButton.centerY = self.height / 2;
        _moreButton.titleLabel.font = systemFont(ScaleW(13));
        [_moreButton setTitle:SSKJLanguage(@"更多") forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:@"home_more"] forState:UIControlStateNormal];
        [_moreButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreEvent) forControlEvents:UIControlEventTouchUpInside];
        
        [_moreButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - _moreButton.imageView.image.size.width - ScaleW(4), 0, _moreButton.imageView.image.size.width + ScaleW(4))];
        [_moreButton setImageEdgeInsets:UIEdgeInsetsMake(0, _moreButton.titleLabel.bounds.size.width, 0, -_moreButton.titleLabel.bounds.size.width)];
    }
    return _moreButton;
}

//-(UILabel *)newsLabel
//{
//    if (nil == _newsLabel) {
//        _newsLabel = [WLTools allocLabel:@"最新" font:systemFont(ScaleW(10)) textColor:OrangeColor frame:CGRectMake(self.imageView.right + ScaleW(10), 0, ScaleW(30), ScaleW(15)) textAlignment:NSTextAlignmentCenter];
//        _newsLabel.layer.borderColor = OrangeColor.CGColor;
//        _newsLabel.layer.borderWidth = 1;
//        _newsLabel.centerY = self.imageView.centerY;
//    }
//    return _newsLabel;
//}
//
//-(void)setNoticeArray:(NSArray *)noticeArray
//{
//    _noticeArray = [NSMutableArray arrayWithArray:noticeArray];
//    if (_dispath_timer)
//    {
//        dispatch_source_cancel(_dispath_timer);
//    }
//    [self addNoticeLabel];
//}
//
//-(void)addNoticeLabel
//{
//    [_timer invalidate];
//    _timer = nil;
//
//    for (UILabel *label in self.noticeLabelArray) {
//        [label removeFromSuperview];
//    }
//
//    [self.noticeLabelArray removeAllObjects];
//
//
//    UILabel *firstLabel = [WLTools allocLabel:nil font:systemFont(ScaleW(13)) textColor:UIColorFromRGB(0x757c8d) frame:CGRectMake(self.lineView.right + ScaleW(12), 0, ScreenWidth - self.lineView.right - ScaleW(22), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
//    firstLabel.adjustsFontSizeToFitWidth = YES;
//    firstLabel.centerY = self.height / 2;
//    [self addSubview:firstLabel];
//    [self.noticeLabelArray addObject:firstLabel];
//
//    UILabel *secondLabel = [WLTools allocLabel:nil font:systemFont(ScaleW(13)) textColor:UIColorFromRGB(0x757c8d) frame:CGRectMake(self.lineView.right + ScaleW(12), self.height, ScreenWidth - self.lineView.right - ScaleW(22), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
//    secondLabel.adjustsFontSizeToFitWidth = YES;
//    [self addSubview:secondLabel];
//    [self.noticeLabelArray addObject:secondLabel];
//
//    [self startMove];
//
//}
//
//-(void)startMove
//{
//    [_timer invalidate];
//    _timer = nil;
//    if (self.noticeArray.count == 0) {
//        return;
//    }
//    if (self.noticeArray.count == 1) {
//        UILabel *label = self.noticeLabelArray.firstObject;
//        label.text = self.noticeArray.firstObject;
//        return;
//    }else{
//        UILabel *firstLabel = self.noticeLabelArray.firstObject;
//        firstLabel.text = self.noticeArray.firstObject;
//
//        UILabel *secondLabel = self.noticeLabelArray[1];
//        secondLabel.text = self.noticeArray[1];
//        _currentNoticeIndex = 1;
//    }
//
////    if (_timer == nil) {
////        _timer = [NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(moveNotice) userInfo:nil repeats:YES];
////    }
//
//
//    [self performSelector:@selector(countDown) withObject:nil afterDelay:kTimeInterval];
//    _reStart = YES;
//
//}
//
//-(void)moveNotice
//{
////    if (!_timer) {
////        return;
////    }
//    if (_reStart) {
//        _reStart = NO;
//        return;
//    }
//    UILabel *firstLabel = self.noticeLabelArray.firstObject;
//    UILabel *secondLabel = self.noticeLabelArray[1];
//
//    secondLabel.text = self.noticeArray[_currentNoticeIndex];
//    WS(weakSelf);
//    [UIView animateWithDuration:0.5 animations:^{
//        firstLabel.centerY = -(firstLabel.height / 2);
//        secondLabel.centerY = self.height / 2;
//    } completion:^(BOOL finished) {
//        [weakSelf.noticeLabelArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
////        UILabel *secondLabel = weakSelf.noticeLabelArray[1];
//        if (_currentNoticeIndex == self.noticeArray.count - 1) {
//            _currentNoticeIndex = 0;
//        }else{
//            _currentNoticeIndex ++;
//        }
//        firstLabel.y = self.height;
//        firstLabel.text = weakSelf.noticeArray[_currentNoticeIndex];
//    }];
//
//}
//
//
//
//-(void)countDown
//{
////    __block int timeout=60; //倒计时时间
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//    _dispath_timer = timer;
//
//    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),3*NSEC_PER_SEC, 0); //每秒执行
//    WS(weakSelf);
//    dispatch_source_set_event_handler(timer, ^{
//
////        if(weakSelf.reStart){ //倒计时结束，关闭
////
////
////
////        }else{
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                [weakSelf moveNotice];
//
//                //标记第一次点击的时候，当在此启用倒计时的时候 可点击
//
//                // sender.userInteractionEnabled =!_isGetPawd;
//
//            });
////        }
//    });
//    _reStart = NO;
//    dispatch_resume(timer);
//}
//
-(void)moreEvent
{
    if (self.moreBlock) {
        self.moreBlock();
    }
}
//
//-(void)clickEvent
//{
//    if (self.clickBlock) {
//
//        NSInteger index = _currentNoticeIndex - 1;
//        if (index < 0) {
//            index = self.noticeArray.count - 1;
//        }
//
//        self.clickBlock(index);
//    }
//}

-(void)setIsMainPage
{
    UIImage *image = [UIImage imageNamed:@"home_notice"];
    self.imageView.image = image;
//    self.lineView.hidden = YES;
    self.imageView.width = ScaleW(19);
    self.imageView.height = ScaleW(16);
    self.imageView.centerY = self.height / 2;
    
//    self.lineView.x = self.imageView.right + ScaleW(5);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
