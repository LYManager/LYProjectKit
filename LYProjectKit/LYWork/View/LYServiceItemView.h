// LYServiceItemView.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/14. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYServiceItemView : UIView
/**< 角标*/
@property(nonatomic,assign)NSInteger index;
- (void) configDataImageString:(NSString *)imageString title:(NSString *)title;
/**< block*/
@property(nonatomic,copy)void(^clickBack)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
