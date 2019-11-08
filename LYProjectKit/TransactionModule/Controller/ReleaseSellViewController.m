//
//  ReleaseSellViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/11/5.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "ReleaseSellViewController.h"

@interface ReleaseSellViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userLab;
@property (weak, nonatomic) IBOutlet UILabel *unitPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *allNimberLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *sellLab;
@property (weak, nonatomic) IBOutlet UILabel *otherLab;
@property (weak, nonatomic) IBOutlet UILabel *shouruLab;
@property (weak, nonatomic) IBOutlet UILabel *tishiLab;

@property (weak, nonatomic) IBOutlet UILabel *shuomingLab;


@property (weak, nonatomic) IBOutlet UIImageView *weichatImage;
@property (weak, nonatomic) IBOutlet UIButton *weichatBtn;
@property (weak, nonatomic) IBOutlet UIButton *aliBtn;
@property (weak, nonatomic) IBOutlet UIImageView *aliImage;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (nonatomic,strong)NSString *payType;
@end

@implementation ReleaseSellViewController

- (void)viewDidLoad {

    self.payType = @"1";
    
    [super viewDidLoad];
    [self.submitBtn ly_gradint];

    self.title = @"出售";
    self.userLab.text = [NSString stringWithFormat:@"%@  %@",self.model.nickName,self.model.mobile];
    self.unitPriceLab.text = [NSString stringWithFormat:@"%@%.2fCNY",@"单价",self.model.unitPrice];
    self.allNimberLab.text = [NSString stringWithFormat:@"%@%.0fAGC",@"卖单总数:",self.model.quantity];
    self.moneyLab.text = [NSString stringWithFormat:@"%.2fCNY",self.model.totalAmount];
    self.sellLab.text = [NSString stringWithFormat:@"%.2f",self.model.payAmount];
    self.otherLab.text = [NSString stringWithFormat:@"%@%.2f",@"其中包含手续费:",self.model.charge];

    self.shouruLab.text = [NSString stringWithFormat:@"%.2f",self.model.totalAmount];
    self.tishiLab.text = [NSString stringWithFormat:@"%@%ld",@"其中包含手续费:",(long)self.model.charge];
    self.tishiLab.text = [NSString stringWithFormat:@"%@%.2f%@",@"市场参考价1AGC≈",self.tradmodel.data.agcToRmb,@"CNY"];
    
    NSString *str = [self.tradmodel.data.tradeDescrip stringByReplacingOccurrencesOfString:@"\\n\n" withString:@"\n"];
    self.shuomingLab.text = str;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)];
    [_weichatImage addGestureRecognizer:tapGesture];
    _weichatImage.userInteractionEnabled = YES;

    UITapGestureRecognizer *tap1Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click1Image)];
    [_aliImage addGestureRecognizer:tap1Gesture];
    _aliImage.userInteractionEnabled = YES;
    
    
    

}
-(void)clickImage
{
    self.payType = @"1";
    self.weichatImage.image = [UIImage imageNamed:@"椭圆1拷贝2"];
    self.aliImage.image = [UIImage imageNamed:@"椭圆1"];

}
-(void)click1Image
{
    self.payType = @"2";
    self.weichatImage.image = [UIImage imageNamed:@"椭圆1"];
    self.aliImage.image = [UIImage imageNamed:@"椭圆1拷贝2"];
}
- (IBAction)sellAction:(id)sender {

    
    NSString *agcStr = [NSString stringWithFormat:@"%.2f",self.model.quantity];
    NSString *cnyStr = [NSString stringWithFormat:@"%.2f",self.model.totalAmount];

    [self popTradePwdControllerType:TradePopType_Sale AGC:agcStr CNY:cnyStr backBlock:^(NSString * _Nonnull pwd) {
        [LYNetwork POSTWithApiPath:buyURL requestParams:@{
         @"tradeId":[NSString stringWithFormat:@"%ld",(long)self.model.tradeId],
             @"mobile":[NSString stringWithFormat:@"%ld",(long)self.model.mobile],
         @"keyWords":pwd?:@"",
             @"payType":self.payType
         } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        
             [self.view makeToast:@"发布成功" duration:1 position:CSToastPositionCenter];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.navigationController popViewControllerAnimated:YES];

             });
         }];
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
