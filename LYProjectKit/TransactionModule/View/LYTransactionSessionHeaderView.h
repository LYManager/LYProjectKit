// LYTransactionSessionHeaderView.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/29. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,LYTransactionSessionHeaderViewClickType) {
    LYTransactionSessionHeaderViewClickType_Sale,
    LYTransactionSessionHeaderViewClickType_Buy,
    LYTransactionSessionHeaderViewClickType_Record
};

@protocol LYTransactionSessionHeaderViewDelegate <NSObject>

- (void) clickActionWithType:(LYTransactionSessionHeaderViewClickType)clickType;

@end

@interface LYTransactionSessionHeaderView : UIView
/**< des*/
@property(nonatomic,weak)id<LYTransactionSessionHeaderViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
