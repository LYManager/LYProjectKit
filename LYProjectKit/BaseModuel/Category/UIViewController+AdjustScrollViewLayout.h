// UIViewController+AdjustScrollViewLayout.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/10. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (AdjustScrollViewLayout)
/**
 设置view布局从状态栏底部开始
 
 @param scrollView 适配iOS11 需要配置
 */
- (void) configViewLayoutFromStatusBarBottomScrollView:(UIScrollView *)scrollView;

/**
 调整布局屏幕顶部开始
 
 @param scrollView 适配iOS11 需要配置
 */
- (void)configViewLayoutFromTopScrollView:(UIScrollView *)scrollView;
@end

NS_ASSUME_NONNULL_END
