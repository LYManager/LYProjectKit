// LYShengTaiSessionHeaderView.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/19. 
// Copyright © 2019 Sunshie. All rights reserved. 
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
