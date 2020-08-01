//
//  Choose_AreaCode_View.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/6/4.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Choose_AreaCode_View.h"

#import "Chooase_AreaCode_Cell.h"

@interface Choose_AreaCode_View()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSArray * dataSource;

@property (nonatomic,strong) NSArray * imgList;

@property (nonatomic,strong) NSArray * quhaoList;



@end

@implementation Choose_AreaCode_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        // 修改蒙版颜色
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        
        [self topView];
        
        [self alertView];
        
        [self tableView];
    }
    return self;
}

- (UIView *)topView
{
    if (_topView == nil) {
        _topView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - ScaleW(300)) Color:[UIColor clearColor]];
        _topView.cornerRadius = ScaleW(5);
        _topView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelbtnAction)];
        [_topView addGestureRecognizer:tap];
        [self addSubview:_topView];
    }
    return _topView;
}


- (UIView *)alertView
{
    if (_alertView == nil) {
        _alertView = [FactoryUI createViewWithFrame:CGRectMake(0, ScreenHeight - ScaleW(300), ScreenWidth, ScaleW(300)) Color:kTitleColor];
        _alertView.cornerRadius = ScaleW(5);
        [self addSubview:_alertView];
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(@0);
            make.height.equalTo(@(ScaleW(300)));
            make.width.equalTo(@(ScreenWidth));
        }];
    }
    return _alertView;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kBgColor;
        [_tableView setSeparatorColor:kSubBgColor];
        [self.alertView addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(@0);
        }];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.quhaoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Chooase_AreaCode_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"AreaCell"];
    if (cell == nil) {
        cell = [[Chooase_AreaCode_Cell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AreaCell"];
    }
    
    cell.backgroundColor = kSubBgColor;
    
    
//    cell.areaImg.image = [UIImage imageNamed:self.imgList[indexPath.row]];
    
    cell.areaName.text = self.dataSource[indexPath.row];
    
    cell.areaCode.text = [NSString stringWithFormat:@"+%@",self.quhaoList[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.SeletedAreaCodeBlock) {
        self.SeletedAreaCodeBlock(self.imgList[indexPath.row], self.dataSource[indexPath.row], self.quhaoList[indexPath.row]);
    }
    [self removeFromSuperview];
}


- (void)cancelbtnAction{
    [self removeFromSuperview];
}


#pragma mark - 弹出 -
- (void)showAlertView
{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self creatShowAnimation];
}

- (void)creatShowAnimation
{
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}

-(NSArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = @[@"China",
                        @"France",
                        @"Germany",
                        @"Hong Kong",
                        @"India",
                        @"Japan",
                        @"Malaysia",
                        @"Philippines",
                        @"Russian Federation",
                        @"Singapore",
                        @"South Korea",
                        @"Taiwan",
                        @"Thailand",
                        @"United Kingdom",
                        @"United States"];
    }
    return _dataSource;
}

-(NSArray *)quhaoList{
    if (_quhaoList == nil) {
        _quhaoList = @[@"86",
                       @"33",
                       @"49",
                       @"852",
                       @"91",
                       @"81",
                       @"60",
                       @"63",
                       @"7",
                       @"65",
                       @"82",
                       @"886",
                       @"66",
                       @"44",
                       @"1"];
    }
    return _quhaoList;
}

- (NSArray *)imgList{
    if (_imgList == nil) {
        _imgList = @[@"China",@"Hongkong",@"Macao",@"Singapore",@"Taiwan",@"Canada",@"hg",@"Japan",@"Germany",@"England"];
    }
    return _imgList;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
