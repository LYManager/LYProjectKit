// LYBaseViewController.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/9. 
// Copyright © 2019 赵良育. All rights reserved. 
// 
/**
    类描述
 */


#import "UIViewController+AdjustScrollViewLayout.h"

NS_ASSUME_NONNULL_BEGIN

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
@property(nonatomic,strong)NSDictionary * params;
// 跳转
- (void) pushViewControllerWithClassName:(NSString *)controllerName
                                  params:(nullable NSDictionary *)params;


/// 弹出购买弹框
- (void) popBuyController;

/// 使用道具弹框
- (void) popToolsController;

/// 赠送道具
- (void) popSendToolsController;

/// 错误弹框
- (void) popErrorController;

@end


@interface LYBaseViewController (ConfigUI)

@end

NS_ASSUME_NONNULL_END

