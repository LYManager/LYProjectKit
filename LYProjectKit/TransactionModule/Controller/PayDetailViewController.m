//
//  PayDetailViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/11/1.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "PayDetailViewController.h"

@interface PayDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *accountLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;
@property (weak, nonatomic) IBOutlet UILabel *mineyLab;
@property (weak, nonatomic) IBOutlet UIImageView *codeImage;
@property (weak, nonatomic) IBOutlet UILabel *orderId;
@property (weak, nonatomic) IBOutlet UIButton *shensuBtn;
@property (weak, nonatomic) IBOutlet UIButton *fangbiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shensuABtn;
@property (weak, nonatomic) IBOutlet UILabel *zhifuAccLab;
@property (weak, nonatomic) IBOutlet UILabel *shoukuanLab;
@property (weak, nonatomic) IBOutlet UILabel *codeLab;

#define BIG_IMG_WIDTH  325
#define BIG_IMG_HEIGHT 325
#define kScreenW [[UIScreen mainScreen] bounds].size.width
#define kScreenH [[UIScreen mainScreen] bounds].size.height

@end

@implementation PayDetailViewController{
    UIView *background;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"买单详情";
    
    [self.shensuBtn ly_gradint];
    [self.fangbiBtn ly_gradint];
    [self.shensuABtn ly_gradint];
    if (self.model.status == 1) {
        self.stateLab.text = @"待支付";
        self.shensuABtn.hidden = YES;
        NSString *timeStr = [NSString stringWithFormat:@"%ld",(long)self.model.remainTime];

        self.timeLab.text = [NSString stringWithFormat:@"%@%@%@",@"买家还有",[self ConvertStrToTime:timeStr],@"完成支付"];
        
        

    }
    else if (self.model.status == 2) {
        self.stateLab.text = @"已支付";
        self.shensuBtn.hidden = YES;
        self.fangbiBtn.hidden = YES;
        self.shensuABtn.hidden = NO;
        self.timeLab.text = @"待卖家确认放币";

    }
    else
    {
        self.stateLab.text = @"交易成功";
        self.shensuBtn.hidden = YES;
        self.fangbiBtn.hidden = YES;
        self.shensuABtn.hidden = NO;
        self.timeLab.text = @"卖家已放币";


    }
    if (self.model.payType == 2) {//支付宝
        
        self.zhifuAccLab.text = @"支付宝账号";
        self.shoukuanLab.text = @"收款人昵称";
        self.codeLab.text = @"支付宝收款码";
        self.accountLab.text = self.model.alipayAccount;
        self.nameLab.text = self.model.alipayName;
        [self.codeImage sd_setImageWithURL:[NSURL URLWithString:self.model.alipayUrl]];

    }
    else
    {
        self.zhifuAccLab.text = @"微信账号";
        self.shoukuanLab.text = @"收款人昵称";
        self.codeLab.text = @"微信收款码";
        self.accountLab.text = self.model.weichatAccount;
        self.nameLab.text = self.model.weiChatName;
        [self.codeImage sd_setImageWithURL:[NSURL URLWithString:self.model.weichatUrl]];
    }
    
    
    
    self.priceLab.text = [NSString stringWithFormat:@"%.2f%@",self.model.totalAmount,@"CNY"];
    self.numberLab.text = [NSString stringWithFormat:@"%.2f%@",self.model.quantity,@"AGC"];
    self.mineyLab.text = [NSString stringWithFormat:@"%.2f%@",self.model.unitPrice,@"CNY"];
    self.orderId.text = self.model.orderNum;

    UITapGestureRecognizer *tap1Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
       [_codeImage addGestureRecognizer:tap1Gesture];
       _codeImage.userInteractionEnabled = YES;
}
- (NSString *)ConvertStrToTime:(NSString *)timeStr{

    

    long long time=[timeStr longLongValue];
    long second = time/1000%60;
 long m = time/1000/60;
    NSString *timeString =[NSString stringWithFormat:@"%02ld:%02ld",m,second];
    return timeString;

}


- (IBAction)connectAction:(id)sender {
     NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.model.mobile]];

       UIWebView *webView = [[UIWebView alloc] init];

       [webView loadRequest:[NSURLRequest requestWithURL:url]];

       [self.view addSubview:webView];

}
- (IBAction)cancelAction:(id)sender {//取消交易
    
    [self popConfirmControllerType:ConfirmType_CancelTrade backBlock:^{
        
        [LYNetwork POSTWithApiPath:cancelOutURL requestParams:@{
             @"tradeId":@(self.model.recordId)
         } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        
             [self.view makeToast:@"取消交易" duration:1 position:CSToastPositionCenter];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.navigationController popViewControllerAnimated:YES];

             });
         }];
    }];
    
    
}
- (IBAction)payAction:(id)sender {//标记为已支付
    
    [self popConfirmControllerType:ConfirmType_Purchased backBlock:^{
        
        [LYNetwork POSTWithApiPath:concormlOutURL requestParams:@{
             @"tradeId":@(self.model.recordId)
         } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        
             [self.view makeToast:@"标记为已支付" duration:1 position:CSToastPositionCenter];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.navigationController popViewControllerAnimated:YES];

             });
         }];
    }];
}
- (IBAction)complaintAction:(id)sender {
    ContactCustomerViewController *custmVC = [[ContactCustomerViewController alloc]init];
    [self.navigationController pushViewController:custmVC animated:YES];

}


- (void)tapAction{
    //创建一个黑色背景
    //初始化一个用来当做背景的View。我这里为了省时间计算，宽高直接用的5s的尺寸
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    background = bgView;
    [bgView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:bgView];
    
    //创建显示图像的视图
    //初始化要显示的图片内容的imageView（这里位置继续偷懒...没有计算）
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, kScreenW, BIG_IMG_HEIGHT)];
    //要显示的图片，即要放大的图片
    if (self.model.payType == 2) {//支付宝
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.model.alipayUrl] placeholderImage:[UIImage imageNamed:@""]];;
    }
    {
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.model.weichatUrl] placeholderImage:[UIImage imageNamed:@""]];;
    }
    
    [bgView addSubview:imgView];
    
    imgView.userInteractionEnabled = YES;
    //添加点击手势（即点击图片后退出全屏）
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
    [imgView addGestureRecognizer:tapGesture];
    
    [self shakeToShow:bgView];//放大过程中的动画
}
-(void)closeView{
    [background removeFromSuperview];
}
//放大过程中出现的缓慢动画
- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
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
