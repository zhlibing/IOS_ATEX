//
//  BIImagePickerController.h
//  SSKJ
//
//  Created by 姚立志 on 2019/6/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BIImagePickerControllerDelegate <NSObject>

-(void)didFinishPickingImage:(UIImage *_Nullable)image editingInfo:(nullable NSDictionary<UIImagePickerControllerInfoKey, id> *)editingInfo;


@end

NS_ASSUME_NONNULL_BEGIN

@interface BIImagePickerController : UIImagePickerController


/**
 设置类型
 
 @param type 1 为拍照  2 为相册
 @return 返回对象
 */
- (instancetype)initWithType:(NSInteger)type witDelegate:(id<BIImagePickerControllerDelegate>)pickerDelegate;





@end

NS_ASSUME_NONNULL_END
