//
//  AssetModel.h
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/22.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "LYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AssetModel : LYBaseModel



/**<           可用AGC*/
@property(nonatomic,copy)NSString *   agcAmount;
/**< 价值多少RMB*/
@property(nonatomic,copy)NSString *  agcToRmb;
/**<      币种*/
@property(nonatomic,copy)NSString *  name;
/**<      币种类型*/
@property(nonatomic,copy)NSString *  coinType;
/**<    用户钱包地址*/
@property(nonatomic,copy)NSString *  userAddress;
/**<    币种链接*/
@property(nonatomic,copy)NSString *  iconUrl;

@end

NS_ASSUME_NONNULL_END
