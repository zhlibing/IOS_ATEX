//
//  BIImagePickerController.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BIImagePickerController.h"

@interface BIImagePickerController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>


@property (nonatomic,weak) id <BIImagePickerControllerDelegate> pickerDeletage;



@end

@implementation BIImagePickerController





/**
 设置类型

 @param type 1 为拍照  2 为相册
 @return 返回对象
 */

- (instancetype)initWithType:(NSInteger)type witDelegate:(id<BIImagePickerControllerDelegate>)pickerDelegate
{
    self = [super init];
    
    if (self)
    {
        [self setDelegate:self];
        self.allowsEditing = YES;
        [self setPickerDeletage:pickerDelegate];
        
        switch (type)
        {
            case 1:
            {
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                {
                    [self setSourceType:UIImagePickerControllerSourceTypeCamera];
                    
                }
                else
                {
                    [self setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                }
            }
                break;
            case 2:
            {
                [self setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            }
                break;
        }
    }
    return self;
   
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma mark - Deletage Method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info;
{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if ([self.pickerDeletage respondsToSelector:@selector(didFinishPickingImage:editingInfo:)])
    {
        [self.pickerDeletage didFinishPickingImage:image editingInfo:info];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
}



@end
