// LYPayPwdViewManager.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/21. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <Foundation/Foundation.h>
#import "SWOAuthCodeView.h"
NS_ASSUME_NONNULL_BEGIN

@interface LYPayPwdViewManager : NSObject
+ (SWOAuthCodeView *) p_getAuthCodeViewTarget:(id<SWOAuthCodeViewDelegate>)target
                                    beginEdit:(BOOL)isBeginEdit;
@end

NS_ASSUME_NONNULL_END
