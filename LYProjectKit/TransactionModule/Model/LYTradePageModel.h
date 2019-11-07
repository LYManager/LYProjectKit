// LYTradePageModel.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/6. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYTradePageModel : NSObject
/**< id*/
@property(nonatomic,assign)NSInteger tradeId;
/**< 头像*/
@property(nonatomic,copy)NSString *  actor;
/**< 昵称*/
@property(nonatomic,copy)NSString *  nickName;
/**< 订单编号*/
@property(nonatomic,copy)NSString *  orderNum;
/**< 交易数量*/
@property(nonatomic,assign)CGFloat quantity;
/**< 单价*/
@property(nonatomic,assign)CGFloat unitPrice;
/**< 买单总价*/
@property(nonatomic,assign)CGFloat totalAmount;
/**< mobile*/
@property(nonatomic,copy)NSString *  mobile;
/**< paytype 1支付宝 2微信*/
@property(nonatomic,assign)NSInteger payType;
/**< 过期时间戳*/
@property(nonatomic,assign)NSInteger remainTime;
@end

NS_ASSUME_NONNULL_END
