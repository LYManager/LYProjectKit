// LYHomeViewController.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/21. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYHomeViewController.h"
#import "LYMineViewController.h"
#import "LYShengTaiViewController.h"
//数据
#import "LYHomeData.h"
@interface LYHomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *agcLabel;


/**< data*/
@property(nonatomic,strong)LYHomeData * data;
@end

@implementation LYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadRequest];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadRequest{
    
    NSLog(@"用户id ===  %@",[LYUserInfoManager shareInstance].userInfo.userId);
    
    [LYNetwork POSTWithApiPath:homeURL requestParams:@{
        @"userId":[LYUserInfoManager shareInstance].userInfo.userId ?:@""
    } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        self.data = [LYHomeData modelWithDictionary:response];
        [self configUIWithData:self.data.data];
    }];
    
}



/// 生态
/// @param sender s
- (IBAction)shengTaiAction:(UIButton *)sender {
    [self pushViewControllerWithClassName:@"LYShengTaiViewController" params:nil];
    NSLog(@"生态");
}

/// 资讯
/// @param sender sender
- (IBAction)zixunAction:(UIButton *)sender {
    [self pushViewControllerWithClassName:@"" params:nil];
}

/// 交易
/// @param sender sender
- (IBAction)jiaoyiAction:(UIButton *)sender {
    [self pushViewControllerWithClassName:@"" params:nil];
}

/// 我的
/// @param sender sender
- (IBAction)mineAction:(UIButton *)sender {
    [self pushViewControllerWithClassName:@"LYMineViewController" params:nil];
}

/// 展示网络数据
/// @param model 数据模型
- (void) configUIWithData:(LYHomeDataModel *)model{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.actor]];
    self.agcLabel.text = [NSString stringWithFormat:@"%.2f",model.agcAmount];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
