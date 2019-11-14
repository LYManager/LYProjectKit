// LYWorkHeaderView.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/14. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <UIKit/UIKit.h>
#import "LYMessageView.h"
NS_ASSUME_NONNULL_BEGIN

@interface LYWorkHeaderView : UIView
/**< 新建订单*/
@property(nonatomic,strong)UIButton * creagteNewOrderBtn;
/**< 合作伙伴*/
@property(nonatomic,strong)UIButton * friendBtn;
/**< messageView*/
@property(nonatomic,strong)LYMessageView * messageView;
/**< 高度*/
@property(nonatomic,assign,readonly,class)CGFloat headerViewHeight;
@end

NS_ASSUME_NONNULL_END
