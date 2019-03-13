// UIViewController+AdjustScrollViewLayout.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/10. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "UIViewController+AdjustScrollViewLayout.h"

@implementation UIViewController (AdjustScrollViewLayout)
#pragma mark🐒------布局相关------🐒
- (void)configViewLayoutFromTopScrollView:(UIScrollView *)scrollView
{
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        
    }
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, tabBarHeight, 0);
    scrollView.scrollIndicatorInsets = scrollView.contentInset;
}

- (void)configViewLayoutFromStatusBarBottomScrollView:(UIScrollView *)scrollView
{
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
    }
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    scrollView.contentInset = UIEdgeInsetsMake(statusBarHeight, 0, tabBarHeight, 0);
    scrollView.scrollIndicatorInsets = scrollView.contentInset;
}
@end
