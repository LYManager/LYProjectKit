//
//  SystemSettingViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/19.
//  Copyright © 2019 赵良育. All rights reserved.
//

#import "SystemSettingViewController.h"
#import "ModifyViewController.h"
@interface SystemSettingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@end

@implementation SystemSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"系统设置";
    self.headImage.layer.cornerRadius = 20;
}
- (IBAction)resetAction:(id)sender {
    NSLog(@"修改图像");
}
- (IBAction)modifyAction:(id)sender {
    ModifyViewController *modVC = [[ModifyViewController alloc]init];
    [self.navigationController pushViewController:modVC animated:YES];
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
