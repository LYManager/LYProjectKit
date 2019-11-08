// LYTransactionRecordTableViewCell.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/1. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <UIKit/UIKit.h>
#import "LYTradeRecordPageModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,CellType) {
    CellType_Waitpay,
    CellType_Paied,
    CellType_TradeSuccess,
    CellType_WaitMoney,
    CellType_WaitSendAGC,
    CellType_GetAGC
};

@protocol LYTransactionRecordTableViewCellDelegate <NSObject>

- (void) confirmSendAGC:(LYTradeRecordPageModel *)model;

- (void) cancelTrade:(LYTradeRecordPageModel *)model;

- (void) shenshu:(LYTradeRecordPageModel *)model;

- (void) payAtOnce:(LYTradeRecordPageModel *)model;

@end

@interface LYTransactionRecordTableViewCell : UITableViewCell
- (void)configUIWithStatus:(CellType)type;

- (void)configWithModel:(LYTradeRecordPageModel *)model;
/**< test*/
@property(nonatomic,assign)NSInteger time;
/**< <#des#>*/
@property(nonatomic,weak)id<LYTransactionRecordTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
