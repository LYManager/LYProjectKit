// LYHomeViewController.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/21. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYHomeViewController.h"
#import "LYMineViewController.h"
#import "LYShengTaiViewController.h"
#import "LYHomeCycleItemView.h"
//数据
#import "LYHomeData.h"
#import "LYHomeCycleBgView.h"
@interface LYHomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *agcLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *earthImageView;
@property (weak, nonatomic) IBOutlet LYHomeCycleBgView *homeCycleBgView;


/**< itemViewArray*/
@property(nonatomic,strong)NSMutableArray<LYHomeCycleItemView *> * itemArr;
/**< data*/
@property(nonatomic,strong)LYHomeData * data;
@end
static NSInteger local = 0;
@implementation LYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadRequest];
    self.itemArr = [NSMutableArray array];
    
    
    CABasicAnimation *layer = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    layer.toValue = @(2*M_PI);
    layer.duration = 40;
    layer.removedOnCompletion = false;
    layer.repeatCount = MAXFLOAT;
    [self.bgImageView.layer addAnimation:layer forKey:nil];

   
    
    CABasicAnimation *layer1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    layer1.toValue = @(-2*M_PI);
    layer1.duration = 80;
    layer1.removedOnCompletion = false;
    layer1.repeatCount = MAXFLOAT;
    [self.earthImageView.layer addAnimation:layer1 forKey:nil];
   
    
    for (int i = 0; i < 6;  i ++ ) {
        LYHomeCycleItemView * redView = [[LYHomeCycleItemView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];;
        redView.backgroundColor = [UIColor redColor];
       redView.frame = CGRectMake(0, 0, 40, 40);
        [self.itemArr addObject:redView];
        CABasicAnimation *layer2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        layer2.toValue = @(-2*M_PI);
       layer2.duration = 40;
       layer2.removedOnCompletion = false;
       layer2.repeatCount = MAXFLOAT;
       [redView.layer addAnimation:layer2 forKey:nil];
       [self.bgImageView addSubview:redView];
        [self.homeCycleBgView sendSubviewToBack:redView];
    }
    
   
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


- (void) startTimer{
//      self.timer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
//      [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)timerRun {
    NSInteger index = local % 6;
    LYRubbishModel * model = self.data.data.rubbishList[index];
    [self.earthImageView sd_setImageWithURL:[NSURL URLWithString:model.rubbishUrl]];
    local += 1;
    NSLog(@"%s", __func__);
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
    @try {
        for (int i = 0; i < 6; i ++) {
            LYHomeCycleItemView * item = self.itemArr[i];
            [item configDataWithModel:model.rubbishList[i]];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self configItems];
}

- (void) configItems{
    if (self.itemArr.count == 0) {
        return;
    }
    CGFloat lineH = self.bgImageView.frame.size.height / 2;
    
    UIView *item1 = self.itemArr[0];
    item1.center = CGPointMake(lineH, 0);
    
    UIView *item2 = self.itemArr[1];
    item2.center = CGPointMake(lineH * (1 + cos(M_PI_2 / 3)), lineH / 2);
    
    UIView *item3 = self.itemArr[2];
    item3.center = CGPointMake(item1.center.x + cos(M_PI_2 / 3) * lineH, lineH * 3 / 2);
    
    UIView *item4 = self.itemArr[3];
    item4.center = CGPointMake(item1.center.x,  lineH * 2);
    
    UIView *item5 = self.itemArr[4];
    item5.center = CGPointMake(item3.center.x - 2 * cos(M_PI_2 / 3) * lineH, item3.center.y);
    
    UIView *item6 = self.itemArr[5];
    item6.center = CGPointMake(item5.center.x , item2.center.y);
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
