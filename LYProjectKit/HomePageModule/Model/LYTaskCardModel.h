// LYTaskCardModel.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/22. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYTaskCardModel : NSObject
/**< 用户任务卡id*/
@property(nonatomic,assign)NSInteger userTaskCardId;
/**< 商城任务卡id*/
@property(nonatomic,assign)NSInteger taskId;
/**< 任务名称*/
@property(nonatomic,copy)NSString * taskName;
/**< 价格*/
@property(nonatomic,assign)long amount;
/**< 图标*/
@property(nonatomic,copy)NSString *  taskUrl;
/**< 任务 需要完成垃圾分类的次数*/
@property(nonatomic,assign)NSInteger taskRequires;
/**< 总奖励*/
@property(nonatomic,assign)long totalEarning;
/**< 累计收益*/
@property(nonatomic,assign)long nowEarning;
/**< 收益时长*/
@property(nonatomic,assign)NSInteger cycleDays;
/**< 购买时间*/
@property(nonatomic,copy)NSString * createTime;
/**< 过期时间*/
@property(nonatomic,copy)NSString *  endTime;
/**< 任务剩余天数*/
@property(nonatomic,assign)NSInteger remainDays;
@end

NS_ASSUME_NONNULL_END
