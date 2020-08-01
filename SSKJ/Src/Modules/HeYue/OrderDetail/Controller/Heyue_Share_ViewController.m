//
//  Heyue_Share_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/17.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "Heyue_Share_ViewController.h"
#import "TYSnapshotScroll.h"
@interface Heyue_Share_ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation Heyue_Share_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = SSKJLocalized(@"分享", nil);
    [self.view addSubview:self.imageView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestShareInfo];
}

-(void)rigthBtnAction:(id)sender
{
    [self saveImage];
}

-(UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }
    return _imageView;
}


-(void)requestShareInfo
{
    
    NSString *language = [SSKJLocalized sharedInstance].currentLanguage;
    NSString *lanType = @"1";
    if ([language isEqualToString:@"en"]) {
        lanType = @"2";
    }
    NSDictionary *params = @{
                                @"order_id":self.chengjiaoModel.ID,
                                @"type":lanType
                            };
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:HEYUE_Share_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == SUCCESSED) {
            NSString *imageURL = netModel.data;
            
            [weakSelf.imageView sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:imageURL]]];
            [weakSelf addRightNavItemWithTitle:SSKJLocalized(@"保存", nil) color:kTitleColor font:systemFont(ScaleW(14))];

            
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
                
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

    }];
}


- (void)saveImage{
    WS(weakSelf);
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, weakSelf, @selector(image:didFinishSavingWithError:contextInfo:),nil);
}
// 需要实现下面的方法,或者传入三个参数即可
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [MBProgressHUD showError:SSKJLocalized(@"保存失败", nil)];
    } else {
        [MBProgressHUD showError:SSKJLocalized(@"保存成功", nil)];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
