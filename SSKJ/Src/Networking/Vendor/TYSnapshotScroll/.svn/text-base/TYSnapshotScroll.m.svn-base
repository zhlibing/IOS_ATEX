//
//  TYSnapshotScroll.m
//  TYSnapshotScroll
//
//  Created by apple on 16/12/28.
//  Copyright © 2016年 TonyReet. All rights reserved.
//

#import "TYSnapshotScroll.h"
#import "WKWebView+TYSnapshot.h"
#import "UIScrollView+TYSnapshot.h"

@implementation TYSnapshotScroll

+ (void )screenSnapshot:(UIView *)snapshotView finishBlock:(void(^)(UIImage *snapShotImage))finishBlock{
    if([snapshotView isKindOfClass:[WKWebView class]]){
        //WKWebView
        WKWebView *wkWebView = (WKWebView *)snapshotView;
        [wkWebView screenSnapshot:^(UIImage *snapShotImage) {
            if (snapShotImage != nil && finishBlock) {
                finishBlock(snapShotImage);
            }
        }];
    }else if([snapshotView isKindOfClass:[UIWebView class]]){
        
        //UIWebView
        UIWebView *webView = (UIWebView *)snapshotView;
        
        [webView.scrollView screenSnapshot:^(UIImage *snapShotImage) {
            if (snapShotImage != nil && finishBlock) {
                finishBlock(snapShotImage);
            }
        }];
    }else if([snapshotView isKindOfClass:[UIScrollView class]] ||
            [snapshotView isKindOfClass:[UITableView class]] ||
            [snapshotView isKindOfClass:[UICollectionView class]]
             ){
        //ScrollView
        UIScrollView *scrollView = (UIScrollView *)snapshotView;
        
        [scrollView screenSnapshot:^(UIImage *snapShotImage) {
            if (snapShotImage != nil && finishBlock) {
                finishBlock(snapShotImage);
            }
        }];
    }else{
        NSLog(@"不支持的类型");
    }
}

/**
 *  截取当前屏幕
 *
 *  @return NSData *
 */
- (NSData *)dataWithScreenshotInPNGFormat
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}

/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */
- (UIImage *)imageWithScreenshot
{
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}

@end
