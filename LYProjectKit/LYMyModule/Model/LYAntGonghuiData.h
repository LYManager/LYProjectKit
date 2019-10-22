// LYAntGonghuiData.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/22. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYBaseModel.h"
#import "LYAntCardModel.h"
@class LYAntGonghuiDataModel;
NS_ASSUME_NONNULL_BEGIN

@interface LYAntGonghuiData : LYBaseModel
/**< data*/
@property(nonatomic,strong)LYAntGonghuiDataModel * data;
@end

@interface LYAntGonghuiDataModel : NSObject
/**< 升级规则 图*/
@property(nonatomic,copy)NSString *  upgradeRules;
/**< 奖励方案 图*/
@property(nonatomic,copy)NSString *  bonusScheeme;
/**< 是否使用过实名卡认证*/
@property(nonatomic,assign)BOOL isUseNameCard;
/**< 是否使用过工会卡*/
@property(nonatomic,assign)BOOL isUseLaborCard;
/**< 直推 已激活个数*/
@property(nonatomic,assign)NSInteger childNums;
/**< 活跃度*/
@property(nonatomic,assign)NSInteger liveness;
/**< 等级*/
@property(nonatomic,copy)NSString *  levelName;
/**< 卡*/
@property(nonatomic,strong)NSArray<LYAntCardModel *> * propsCardList;
@end

NS_ASSUME_NONNULL_END
