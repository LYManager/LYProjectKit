//
//  TextTableViewCell.h
//  BattleWord
//
//  Created by 李帅 on 2019/10/21.
//  Copyright © 2019 李帅. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextTableViewCell : UITableViewCell


@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *codeLab;
@property (nonatomic, strong) UILabel *phoneLab;
@property (nonatomic, strong) UILabel *idLab;


@end

NS_ASSUME_NONNULL_END
