//
//  WithdrawalViewController.h
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/18.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "LYBaseViewController.h"
#import "AssetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WithdrawalViewController : LYBaseViewController
@property (nonatomic,strong)AssetModel *assModel;
@property (nonatomic,strong)NSString *wicon;

@end

NS_ASSUME_NONNULL_END
