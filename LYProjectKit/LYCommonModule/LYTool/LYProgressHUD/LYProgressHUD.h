// LYProgressHUD.h 
// CloudBuy 
// 
// Created by 赵良育 on 2018/11/29. 
// Copyright © 2018 赵良育. All rights reserved. 
// 
/**
    类描述
 */


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYProgressHUD : NSObject
+ (void) startDefaultConfig;
/**
 转菊花
 */
+ (void) ly_showHUD;
+ (void) ly_showHUDWithStatus:(NSString *)status;

/**
 消失菊花
 */
+ (void) ly_dismissHUD;

/**
 展示错误信息

 @param messageTip 错误信息 （默认时长2秒）
 */
+ (void) ly_showErrorWithMessageTip:(NSString *)messageTip;

/**
 展示错误信息

 @param messageTip 错误信息
 @param timeInterval 时长
 */
+ (void) ly_showErrorWithMessageTip:(NSString *)messageTip timeInterval:(NSTimeInterval)timeInterval;

/**
 成功提示

 @param messageTip 成功信息
 */
+ (void) ly_showSuccessWithMessageTip:(NSString *)messageTip;

/**
 成功提示

 @param messageTip 成功信息
 @param timeInterval 时长
 */
+ (void) ly_showSuccessWithMessageTip:(NSString *)messageTip timeInterval:(NSTimeInterval)timeInterval;
@end

NS_ASSUME_NONNULL_END
