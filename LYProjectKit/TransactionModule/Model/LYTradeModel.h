// LYTradeModel.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/6. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYBaseModel.h"
#import "LYTradePageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LYTradeList : NSObject
/**< pagelist*/
@property(nonatomic,strong)NSArray<LYTradePageModel *> * pageList;
/**< pageNum*/
@property(nonatomic,assign)NSInteger pageNum;
/**< pagesize*/
@property(nonatomic,assign)NSInteger pageSize;
/**< pages*/
@property(nonatomic,assign)NSInteger pages;
/**< total*/
@property(nonatomic,assign)NSInteger total;
@end

@interface LYTradeModelData : NSObject
/**< 交易说明*/
@property(nonatomic,copy)NSString *  tradeDescrip;
/**< 市场参考价*/
@property(nonatomic,assign)CGFloat agcToRmb;
/**< agc数量*/
@property(nonatomic,assign)CGFloat agcAomount;
/**< 当前总AGC数量*/
@property(nonatomic,assign)CGFloat sumAmount;
/**< 今日交易量*/
@property(nonatomic,assign)CGFloat todayAmount;
/**< 增幅*/
@property(nonatomic,copy)NSString *  addPrice;
/**< 交易列表*/
@property(nonatomic,strong)LYTradeList * tradeList;
@end
@interface LYTradeModel : LYBaseModel
/**< data*/
@property(nonatomic,strong)LYTradeModelData * data;
@end



NS_ASSUME_NONNULL_END
