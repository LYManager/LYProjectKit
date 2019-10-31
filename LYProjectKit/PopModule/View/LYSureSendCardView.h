// LYSureSendCardView.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/31. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <UIKit/UIKit.h>
@class LYAntCardModel;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,LYSureSendCardViewAction) {
    LYSureSendCardViewAction_Commit,
    LYSureSendCardViewAction_Cancel
};

@protocol LYSureSendCardViewDelegate <NSObject>

- (void) commitActionSender:(UIButton *)sender type:(LYSureSendCardViewAction)actionType;



@end

@interface LYSureSendCardView : UIView
/**< <#des#>*/
@property(nonatomic,weak)id<LYSureSendCardViewDelegate> delegate;

- (void) configDataWithCardName:(NSString *)cardName dataDict:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
