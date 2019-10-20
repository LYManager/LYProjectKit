// LYMayiGongHuiHeaderView.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/19. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,CardType) {
    CardType_RealCard,
    CardType_MayiCard
};

@protocol LYMayiGongHuiHeaderViewDelegate <NSObject>

- (void) useCardWithType:(CardType)cardType;

- (void) sendCaardWithType:(CardType)cardType;

@end

@interface LYMayiGongHuiHeaderView : UIView
/**< */
@property(nonatomic,weak)id<LYMayiGongHuiHeaderViewDelegate> delegate;
- (void) configUI;
@end

NS_ASSUME_NONNULL_END
