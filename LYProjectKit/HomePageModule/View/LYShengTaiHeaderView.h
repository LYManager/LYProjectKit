// LYShengTaiHeaderView.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/19. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYShengTaiHeaderView : UIView

/// p
/// @param earn 今日收益
/// @param huoyue 活跃度
- (void) configDataWithEarn:(long)earn huoyue:(NSInteger)huoyue;
@end

NS_ASSUME_NONNULL_END
