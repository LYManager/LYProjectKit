// LYHomeData.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/22. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYBaseModel.h"
#import "LYRubbishModel.h"
@class LYHomeDataModel;
NS_ASSUME_NONNULL_BEGIN

@interface LYHomeData : LYBaseModel
/**< data*/
@property(nonatomic,strong)LYHomeDataModel * data;
@end

@interface LYHomeDataModel : NSObject
/**< 今日任务*/
@property(nonatomic,copy)NSString *  todayTask;
/**< 头像*/
@property(nonatomic,copy)NSString *  actor;
/**< agc数量*/
@property(nonatomic,assign)CGFloat agcAmount;
/**< 用户垃圾标识（垃圾分类接口用到）*/
@property(nonatomic,assign)NSInteger index;
/**< 是否加入蚂蚁工会*/
@property(nonatomic,assign)BOOL isActive;
/**< 垃圾列表*/
@property(nonatomic,strong)NSArray<LYRubbishModel *> * rubbishList;
/**< userID*/
@property(nonatomic,copy)NSString *  userId;
/**< userName*/
@property(nonatomic,copy)NSString *  userName;
@end

NS_ASSUME_NONNULL_END
