//
//  ContactCustomerViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/18.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "ContactCustomerViewController.h"

@interface ContactCustomerViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation ContactCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"联系客服";
    [self loadRequest];
}
- (void)loadRequest{
    
    NSLog(@"用户id ===  %@",[LYUserInfoManager shareInstance].userInfo.userId);
    
    [LYNetwork POSTWithApiPath:contactUrl requestParams:@{
        @"userId":[LYUserInfoManager shareInstance].userInfo.userId ?:@""
    } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[[response objectForKey:@"data"] objectForKey:@"imgUrl"]]];
        self.titleLab.text = [NSString stringWithFormat:@"%@%@",@"客服微信号",[[response objectForKey:@"data"] objectForKey:@"phone"]];
        
    }];
    
}

- (IBAction)fuzhiAction:(id)sender {
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
