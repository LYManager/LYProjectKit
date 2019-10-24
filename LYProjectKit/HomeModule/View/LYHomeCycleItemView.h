// LYHomeCycleItemView.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/23. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <UIKit/UIKit.h>
#import "LYRubbishModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LYHomeCycleItemView : UIView
/**< imageView*/
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)LYRubbishModel * model;
- (void) configDataWithModel:(LYRubbishModel *)rubbishModel;
@end

NS_ASSUME_NONNULL_END
