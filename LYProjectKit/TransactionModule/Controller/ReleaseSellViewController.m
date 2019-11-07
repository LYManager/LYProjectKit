//
//  ReleaseSellViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/11/5.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "ReleaseSellViewController.h"

@interface ReleaseSellViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *weichatImage;
@property (weak, nonatomic) IBOutlet UIButton *weichatBtn;
@property (weak, nonatomic) IBOutlet UIButton *aliBtn;
@property (weak, nonatomic) IBOutlet UIImageView *aliImage;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation ReleaseSellViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    self.title = @"出售";

}
- (IBAction)sellAction:(id)sender {
//    
//    if (self.numberText.text.length == 0) {
//           [self.view makeToast:@"交易密码不能为空" duration:1 position:CSToastPositionCenter];
//           return;
//       }
    
    [LYNetwork POSTWithApiPath:buyURL requestParams:@{
            @"tradeId":@"",
            @"mobile":@"",
            @"keyWords":@"",
            @"payType":@""
        } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
       
            [self.view makeToast:@"发布成功" duration:1 position:CSToastPositionCenter];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];

            });
        }];
       
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
