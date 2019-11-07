// LYTradeRecordPageModel.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/6. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYTradeRecordPageModel : NSObject
/**< id*/
@property(nonatomic,assign)NSInteger recordId;
/**< 支付宝名称*/
@property(nonatomic,copy)NSString *  alipayName;
/**< 微信名字*/
@property(nonatomic,copy)NSString *  weiChatName;
/**< w支付宝账号*/
@property(nonatomic,copy)NSString *  alipayAccount;
/**< 微信账号*/
@property(nonatomic,copy)NSString *  weichatAccount;
/**< 支付宝 url*/
@property(nonatomic,copy)NSString *  alipayUrl;
/**< 微信 url*/
@property(nonatomic,copy)NSString *  weichatUrl;
/**< 数量*/
@property(nonatomic,assign)CGFloat quantity;
/**< 单价*/
@property(nonatomic,assign)CGFloat unitPrice;
/**< 总数量*/
@property(nonatomic,assign)CGFloat totalAmount;
/**< 创建时间戳*/
@property(nonatomic,assign)NSInteger createDate;
/**< pay type*/
@property(nonatomic,assign)NSInteger payType;
/**< trade type*/
@property(nonatomic,assign)NSInteger tradeType;
/**< status*/
@property(nonatomic,assign)NSInteger status;
/**< w剩余时间*/
@property(nonatomic,assign)NSInteger remainTime;
/**< 订单编号*/
@property(nonatomic,copy)NSString *  orderNum;
@end

NS_ASSUME_NONNULL_END
