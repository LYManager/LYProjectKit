//
//  TeamModel.h
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/22.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "LYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TeamModel : LYBaseModel


/**< 贡献值*/
@property(nonatomic,assign)NSInteger   contAmount;
/**< 贡献值规则*/
@property(nonatomic,copy)NSString *  contCoinRule;
/**< 团队总人数*/
@property(nonatomic,assign)NSInteger teamNums;
/**<     直推已激活*/
@property(nonatomic,assign)NSInteger activedNums;
/**< 直推未激活*/
@property(nonatomic,assign)NSInteger notActiveNums;
/**< 直推未加入会员*/
@property(nonatomic,strong)NSArray *notActiveChilds;
/**< 直推已加入会员*/
@property(nonatomic,strong)NSArray *childsList;
@property(nonatomic,copy)NSString *  groupAmount;


@end

NS_ASSUME_NONNULL_END
