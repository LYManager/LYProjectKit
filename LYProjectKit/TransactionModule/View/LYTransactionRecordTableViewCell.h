// LYTransactionRecordTableViewCell.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/1. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,CellType) {
    CellType_Waitpay,
    CellType_Paied,
    CellType_TradeSuccess,
    CellType_WaitMoney,
    CellType_WaitSendAGC,
    CellType_GetAGC
};
@interface LYTransactionRecordTableViewCell : UITableViewCell
- (void)configUIWithStatus:(CellType)type;
/**< test*/
@property(nonatomic,assign)NSInteger time;
@end

NS_ASSUME_NONNULL_END
