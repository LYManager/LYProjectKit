// LYBaseViewController.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/3/9. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 
/**
    类描述
 */


#import "UIViewController+AdjustScrollViewLayout.h"
#import "LYTaskCardModel.h"
#import "LYAntCardModel.h"
@class LYPopConfirmViewController;
NS_ASSUME_NONNULL_BEGIN
typedef void(^BackBlock)(void);
typedef NS_ENUM(NSUInteger,ConfirmType) {
    ConfirmType_FB,  // 放币
    ConfirmType_CancelTrade,  // 取消交易
    ConfirmType_Purchased, // 标记为已支付
    ConfirmType_SoldOut   // 下架
};

typedef void(^TradeCallBack)(NSString * pwd);
typedef NS_ENUM(NSUInteger,TradePopType) {
    TradePopType_Buy,  // 发布买单
    TradePopType_Sale, // 卖单
    TradePopType_Bind  // 绑定
};

@interface LYBaseViewController : UIViewController
/** 状态栏字体风格*/
@property(nonatomic,assign)UIStatusBarStyle statusBarStyle;
/**< 状态栏背景色 --- 一般不用*/
@property(nonatomic,strong)UIColor * statusBarBackgroundColor;
/**< 隐藏状态栏 --- 一般不用*/
@property(nonatomic,assign,getter=isHideStatus)BOOL hideStatusBar;

/** 是否隐藏导航栏(初始化控制器时候 赋值)*/
@property(nonatomic,assign,getter=isHideNavigationBar)BOOL hideNavigationBar;
/**< 禁止配置背景色 (蚂蚁项目)使用*/
@property(nonatomic,assign,getter=isForbidConfigBgColor)BOOL forbidConfigBgColor;
/**< 传参*/
@property(nonatomic,strong,nullable)NSDictionary * params;
// 跳转
- (void) pushViewControllerWithClassName:(NSString *)controllerName
                                  params:(nullable NSDictionary *)params;

- (void) loadRequest;


/// 弹出购买弹框
- (void) popBuyController:(nullable LYTaskCardModel *)cardModel;

/// 使用道具弹框
- (void) popToolsController:(LYAntCardModel *)antTaskModel callBack:(nullable void(^)(NSString *))callBack;
- (void) popToolsController:(LYAntCardModel *)antTaskModel isRealCheck:(BOOL)isRealCheck callBack:(nullable void(^)(NSString *))callBack;

/// 赠送道具
- (void) popSendToolsController:(LYAntCardModel *)antTaskModel backBlock:(void(^)(void))backBlock;


/// 错误弹框
- (void)popErrorControllerIsSend:(BOOL)isSend isRealNameCard:(BOOL)isRealNameCard;

// 确认弹框
- (void) popConfirmControllerType:(ConfirmType)type backBlock:(BackBlock)backBlock;

//交易密码弹框
- (void) popTradePwdControllerType:(TradePopType)type AGC:(NSString *)agc CNY:(NSString *)cny backBlock:(TradeCallBack)backBlock;

@end


@interface LYBaseViewController (ConfigUI)

@end

NS_ASSUME_NONNULL_END

