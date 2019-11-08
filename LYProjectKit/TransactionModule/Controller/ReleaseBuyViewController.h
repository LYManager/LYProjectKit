//
//  ReleaseBuyViewController.h
//  LYProjectKit
//
//  Created by 李帅 on 2019/11/5.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "LYBaseViewController.h"
#import "LYTradeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReleaseBuyViewController : LYBaseViewController

@property (nonatomic,strong)LYTradeModel *model;
@property (weak, nonatomic) IBOutlet UITextField *numberText;
@property (weak, nonatomic) IBOutlet UITextField *priceLab;

@property (weak, nonatomic) IBOutlet UILabel *balanceLab;
@property (weak, nonatomic) IBOutlet UILabel *referenceLab;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *zongjiaLab;
@end

NS_ASSUME_NONNULL_END
