// LYShengTaiSessionHeaderView.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/19. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import <UIKit/UIKit.h>
#import "LYShengTaiCardType.h"
NS_ASSUME_NONNULL_BEGIN

@protocol LYShengTaiSessionHeaderViewDelegate <NSObject>
- (void) selectCardType:(LYShengTaiShopCardType)cardType;
@end

@interface LYShengTaiSessionHeaderView : UIView
/**< */
@property(nonatomic,weak)id<LYShengTaiSessionHeaderViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
