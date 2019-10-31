//
//  MembersTableViewCell.h
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/31.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MembersTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLab;
@property (weak, nonatomic) IBOutlet UILabel *iDLab;
@property (weak, nonatomic) IBOutlet UILabel *levelLab;
@property (weak, nonatomic) IBOutlet UILabel *huoyueLab;
@property (weak, nonatomic) IBOutlet UILabel *teamLab;
@property (weak, nonatomic) IBOutlet UILabel *teamAllLab;

@end

NS_ASSUME_NONNULL_END
