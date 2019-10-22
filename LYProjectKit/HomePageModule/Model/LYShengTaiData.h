// LYShengTaiData.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/22. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYBaseModel.h"
#import "LYTaskCardModel.h"
@class LYShengTaiDataModel;
NS_ASSUME_NONNULL_BEGIN

@interface LYShengTaiData : NSObject
/**< data*/
@property(nonatomic,strong)LYShengTaiDataModel * data;
@end

@interface LYShengTaiDataModel: NSObject
/**< 收益*/
@property(nonatomic,assign)long agcDayEarning;
/**< 活跃度*/
@property(nonatomic,assign)NSInteger liveness;
/**< 任务信息*/
@property(nonatomic,strong)NSArray<LYTaskCardModel *> * taskList;
@end

NS_ASSUME_NONNULL_END
