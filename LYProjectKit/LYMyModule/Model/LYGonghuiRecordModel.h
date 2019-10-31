// LYGonghuiRecordModel.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/31. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN



@interface LYGonghuiRecordModel : LYBaseModel
/**< <#des#>*/
@property(nonatomic,copy)NSString *  cardName;
/**< <#des#>*/
@property(nonatomic,copy)NSString * createDate;
/**< <#des#>*/
@property(nonatomic,assign)NSInteger type;
/**< <#des#>*/
@property(nonatomic,assign)NSInteger cardCount;
/**< des*/
@property(nonatomic,copy)NSString *  userId;
/**< des*/
@property(nonatomic,copy)NSString *  toUserId;

@end

@interface LYGOnghuiRecordData : NSObject
/**< data*/
@property(nonatomic,strong)NSArray<LYGonghuiRecordModel *> * data;
@end
NS_ASSUME_NONNULL_END
