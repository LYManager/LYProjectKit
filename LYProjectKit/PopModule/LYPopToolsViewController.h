// LYPopToolsViewController.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/21. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYPopToolsViewController : LYBaseViewController
/**< */
@property(nonatomic,strong)LYAntCardModel * cardModel;

/**< <#des#>*/
@property(nonatomic,copy)void(^callBack)(NSString *pwd);
@end

NS_ASSUME_NONNULL_END
