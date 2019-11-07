// LYPopConfirmViewController.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/7. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYPopConfirmViewController.h"

@interface LYPopConfirmViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UIButton *comfirmBtn;
/**< <#des#>*/
@property(nonatomic,copy)BackBlock  backBlock;
/**< type*/
@property(nonatomic,assign)ConfirmType type;
@end

@implementation LYPopConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self configUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)configDataWithType:(ConfirmType)type callBack:(BackBlock)backBlock{
    self.backBlock = backBlock;
    self.type = type;
}

- (void) configUI{
    NSString * title;
   NSString * desc;
   NSString * btnTitle;
   switch (self.type) {
       case ConfirmType_FB:
           {
               title = @"确认放币？";
               desc = @"确定您已收到了买家支付的款项?\n确定后AGC将转入卖家账户";
               btnTitle = @"确定";
           }
           break;
       case ConfirmType_CancelTrade:
           {
               title = @"取消交易？";
               desc = @"确定取消交易\n取消后交易自动关闭";
                btnTitle = @"是，取消交易";
           }
           break;
       case ConfirmType_Purchased:
           {
               title = @"标记为已支付？";
               desc = @"确定您已支付款项至卖家账户？";
                btnTitle = @"确定";
           }
           break;
        case ConfirmType_SoldOut:
        {
            title = @"下架";
            desc = @"确定下架该单？";
             btnTitle = @"确定";
        }
        break;
   }
   self.titleLabel.text = title;
   self.desLabel.text = desc;
   [self.comfirmBtn setTitle:btnTitle forState:UIControlStateNormal];
}

- (IBAction)cancelBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)confirmBtnAction:(id)sender {
    !self.backBlock ? : self.backBlock();
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
     [self.comfirmBtn ly_gradint];
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
