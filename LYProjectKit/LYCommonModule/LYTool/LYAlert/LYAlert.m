// LYAlert.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/9. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYAlert.h"
#import <Toast.h>
@implementation LYAlert

+ (void)alertMessage:(NSString *)message
            duration:(NSTimeInterval)duration
              onView:(UIView *)view
{
    [(view ? view : [UIApplication sharedApplication].keyWindow) makeToast:message duration:duration position:CSToastPositionCenter];
}

+ (void)alertTestWithMessage:(NSString *)testMessage
{
    [self alertSystemWithTitle:@"测试" message:testMessage preferredType:UIAlertControllerStyleAlert actionTitles:nil actionBlocks:nil];
}

+ (void)alertSystemWithTitle:(NSString *)title
                     message:(NSString *)message
               preferredType:(UIAlertControllerStyle)style
                actionTitles:(NSArray *)actionTitles
                actionBlocks:(NSArray<void (^)(UIAlertAction * _Nonnull)> *)actionBlocks
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    if (actionTitles) {
        [actionTitles enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIAlertAction * action = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:actionBlocks[idx]];
            [alertController addAction:action];
        }];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:action];
    }else // 测试分支
    {
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:action];
    }
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}
@end
