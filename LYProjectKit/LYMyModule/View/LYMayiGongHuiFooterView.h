// LYMayiGongHuiFooterView.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/19. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <UIKit/UIKit.h>
@class LYAntGonghuiDataModel;
NS_ASSUME_NONNULL_BEGIN

@protocol LYMayiGongHuiFooterViewDelegate <NSObject>

- (void)contactKefu;

@end

@interface LYMayiGongHuiFooterView : UIView
@property(nonatomic,weak)id<LYMayiGongHuiFooterViewDelegate>delegate;
- (void) configDataWithModel:(LYAntGonghuiDataModel *)model;
@end

NS_ASSUME_NONNULL_END
