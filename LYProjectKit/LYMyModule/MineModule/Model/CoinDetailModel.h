//
//  CoinDetailModel.h
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/22.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "LYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoinDetailModel : LYBaseModel

@property(nonatomic,copy)NSString *  tradeTime;//交易时间
/**<    币种类型 ：1 是KCP 3 USDT*/
@property(nonatomic,copy)NSString *  cointype;
/**<    币值变化*/
@property(nonatomic,copy)NSString *  amount;

@property(nonatomic,copy)NSString * content;
@end

NS_ASSUME_NONNULL_END
