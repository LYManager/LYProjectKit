// LYPopSendToolsViewController.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/21. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYPopSendToolsViewController : LYBaseViewController
/**< backBlock*/
@property(nonatomic,copy)void(^backBlock) (void);
/**< model*/
@property(nonatomic,strong)LYAntCardModel * cardModel;
@end

NS_ASSUME_NONNULL_END
