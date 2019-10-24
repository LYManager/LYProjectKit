// LYMayiGongHuiHeaderView.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/19. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <UIKit/UIKit.h>
@class LYAntGonghuiDataModel;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,CardType) {
    CardType_RealCard = 1,
    CardType_MayiCard
};

@protocol LYMayiGongHuiHeaderViewDelegate <NSObject>

- (void) useCardWithType:(CardType)cardType;

- (void) sendCaardWithType:(CardType)cardType;

- (void) headerContackKefu;

@end

@interface LYMayiGongHuiHeaderView : UIView
/**< */
@property(nonatomic,weak)id<LYMayiGongHuiHeaderViewDelegate> delegate;

- (void) configDataWithModel:(LYAntGonghuiDataModel *)model;
@end

NS_ASSUME_NONNULL_END
