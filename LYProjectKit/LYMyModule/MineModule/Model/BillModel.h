//
//  BillModel.h
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/22.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "LYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BillModel : LYBaseModel
/**<      数量*/
@property(nonatomic,copy)NSString *   coinAmount;
/**< 币种类型，1:AGC 2:贡献值 3: USDT 4:活跃度*/
@property(nonatomic,copy)NSString *  coinType;
/**<      账单时间*/
@property(nonatomic,copy)NSString *  createDate;
/**<      账单描述*/
@property(nonatomic,copy)NSString *  content;
@end

NS_ASSUME_NONNULL_END
