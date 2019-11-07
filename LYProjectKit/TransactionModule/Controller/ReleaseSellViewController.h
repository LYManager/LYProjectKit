//
//  ReleaseSellViewController.h
//  LYProjectKit
//
//  Created by 李帅 on 2019/11/5.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "LYBaseViewController.h"
#import "LYTradePageModel.h"
#import "LYTradeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReleaseSellViewController : LYBaseViewController
@property (nonatomic,strong)LYTradePageModel *model;
@property (nonatomic,strong)LYTradeModel *tradmodel;

@end

NS_ASSUME_NONNULL_END
