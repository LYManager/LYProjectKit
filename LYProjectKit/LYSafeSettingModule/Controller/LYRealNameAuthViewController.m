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
