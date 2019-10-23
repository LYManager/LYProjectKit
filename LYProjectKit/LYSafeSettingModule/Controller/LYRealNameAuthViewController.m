// LYRealNameAuthViewController.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/19. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYRealNameAuthViewController.h"

@interface LYRealNameAuthViewController ()
@property (weak, nonatomic) IBOutlet UITextField *realNameTF;
@property (weak, nonatomic) IBOutlet UITextField *cardTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation LYRealNameAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTextFieldPlaceholder];
    
    [self.commitBtn ly_gradint];
    
    self.navigationItem.title = @"实名认证";
    
    // Do any additional setup after loading the view from its nib.
}

- (void) configTextFieldPlaceholder{
    self.realNameTF.attributedPlaceholder = [self.realNameTF.placeholder ly_attributePlaceholder];
    self.cardTF.attributedPlaceholder = [self.cardTF.placeholder ly_attributePlaceholder];
    self.phoneNumberTF.attributedPlaceholder = [self.phoneNumberTF.placeholder ly_attributePlaceholder];
}

#pragma mark🐒------提交------🐒
- (IBAction)commitAction:(UIButton *)sender {
    
//    提交参数
    LYAntCardModel * model = self.params[@"realNameCardModel"];
    [self popToolsController:model callBack:^(NSString * _Nonnull pwd) {
//        提交认证
        [self loadRequestWithPwd:pwd];
    }];
}
//提交数据
- (void) loadRequestWithPwd:(NSString *)pwd{
    [LYNetwork POSTWithApiPath:idCardValiURL requestParams:@{
        @"keyWords":pwd,
        @"userCardDto":@{
                @"mobile":self.phoneNumberTF.text ?:@"",
                @"userCardNum":self.cardTF.text ?:@"",
                @"userName":self.realNameTF.text ?:@""
        }
    } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        [self.view makeToast:@"认证成功" duration:1 position:CSToastPositionCenter];
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
