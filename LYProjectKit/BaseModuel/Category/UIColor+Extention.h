// UIColor+Extention.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/18. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 




#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extention)
+ (UIColor *) ly_colorWithHexString:(NSString *)hexString;

/// 控制器背景颜色
+ (UIColor *) ly_vc_bgColor;

/// 内容view 颜色
+ (UIColor *) ly_view_bgColor;
@end

NS_ASSUME_NONNULL_END
