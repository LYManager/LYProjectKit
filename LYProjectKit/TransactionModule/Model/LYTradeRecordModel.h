// LYTradeRecordModel.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/6. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYBaseModel.h"
#import "LYTradeRecordPageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LYTradeRecordModelData : NSObject
/**< pagenum*/
@property(nonatomic,assign)NSInteger pageNum;
/**< pageSize*/
@property(nonatomic,assign)NSInteger pageSize;
/**< total*/
@property(nonatomic,assign)NSInteger total;
/**< pages*/
@property(nonatomic,assign)NSInteger pages;
/**< array*/
@property(nonatomic,strong)NSArray<LYTradeRecordPageModel *> * pageList;
@end

@interface LYTradeRecordModel : LYBaseModel
/**< data*/
@property(nonatomic,strong)LYTradeRecordModelData * data;
@end



NS_ASSUME_NONNULL_END
