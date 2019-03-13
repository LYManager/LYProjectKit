// UITabBar+Repair_iOS_12_1_bug.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/9. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 * 只是修复bug
 * @bug ------->  iOS12.1 手势返回时候，TabBarItem中图标跳动问题
 * @reason  内部设置了错误的frame
 */
@interface UITabBar (Repair_iOS_12_1_bug)

@end

NS_ASSUME_NONNULL_END
