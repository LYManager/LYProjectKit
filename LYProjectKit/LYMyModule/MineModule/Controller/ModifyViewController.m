//
//  ModifyViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/19.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "ModifyViewController.h"

@interface ModifyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation ModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    self.nameText.text = self.nameStr;
    [self.submitBtn ly_gradint];
}
- (IBAction)submitAction:(id)sender {
    
    if (self.nameText.text.length == 0) {
        [self.view makeToast:@"昵称不能为空" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    
    [LYNetwork POSTWithApiPath:resetNameUrl requestParams:@{
           @"userId":[LYUserInfoManager shareInstance].userInfo.userId ?:@"",
           @"loginDTO":@{@"nickname":self.nameText.text}
       } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {

        [self.view makeToast:@"昵称修改成功" duration:1 position:CSToastPositionCenter];
        

       }];
       
}
- (void)loadRequest{
    
    NSLog(@"用户id ===  %@",[LYUserInfoManager shareInstance].userInfo.userId);
    
   
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
