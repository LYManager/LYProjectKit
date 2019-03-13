// LYAlert.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/9. 
// Copyright © 2019 赵良育. All rights reserved. 
// 
/**
    类描述
 */


#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LYAlert : NSObject
/**
 信息展示

 @param message 展示的信息
 @param duration 时长
 @param view 展示所在的view
 */
+ (void) alertMessage:(NSString *)message
             duration:(NSTimeInterval)duration
               onView:(nullable UIView *)view;

/**
 仅供测试使用(系统弹框)

 @param testMessage 测试数据
 */
+ (void)alertTestWithMessage:(NSString *)testMessage;

/**
 弹出系统alert

 @param title 标题
 @param message 信息
 @param style 风格
 @param actionTitles 标题数组
 @param actionBlocks action回调数组
 */
+ (void)alertSystemWithTitle:(NSString *)title
                     message:(NSString *)message
               preferredType:(UIAlertControllerStyle)style
                actionTitles:(nullable NSArray *)actionTitles
                actionBlocks:(nullable NSArray<void(^)(UIAlertAction *)>*)actionBlocks;
@end

NS_ASSUME_NONNULL_END
