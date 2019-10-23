//
//  MyBillableViewCell.h
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/20.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyBillableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *titShowLab;

@end

NS_ASSUME_NONNULL_END
