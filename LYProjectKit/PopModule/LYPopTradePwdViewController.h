// LYPopTradePwdViewController.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/7. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYPopTradePwdViewController : LYBaseViewController
- (void) configDataWithType:(TradePopType)type
                        AGC:(NSString *)agcAmount
                        CNY:(NSString *)cnyAmount
                   callBack:(TradeCallBack)tradeCallBack;
@end

NS_ASSUME_NONNULL_END
