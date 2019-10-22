// LYMineTableViewCell.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/18. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYMineTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;



- (void) configIcon:(NSString *)icon title:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
