// LYTableViewController.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/9. 
// Copyright © 2019 赵良育. All rights reserved. 
// 
/**
    类描述
 */


#import "LYBaseViewController.h"

@protocol LYCellModelProtocol;

NS_ASSUME_NONNULL_BEGIN
/// 简单不分组TableView，有其他需求，重写TbaleView代理方法
@interface LYTableViewController : LYBaseViewController
<
    UITableViewDelegate,UITableViewDataSource
>

@property(nonatomic,strong,readonly)UITableView * tableView;                /**< */

/**< 数据源（不分组）*/
@property(nonatomic,strong)NSArray<id<LYCellModelProtocol>> * dataArray;

/**
 注册cell

 @param identifiers 重用标识数组
 */
- (void) registerCellWithIdentifiers:(NSArray *)identifiers;


/**
 添加刷新
 */
- (void) addRefresh;
/**
 头部刷新完成
 */
- (void) headerRefreshFinish;

/**
 上拉刷新完成
 */
- (void) footerRefreshFinish;

@end

NS_ASSUME_NONNULL_END
