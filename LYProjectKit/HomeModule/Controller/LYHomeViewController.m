// LYHomeViewController.m 
// LYProjectKit 
// 

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

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *rubbishBtnArray;

/**< itemViewArray*/
@property(nonatomic,strong)NSMutableArray<LYHomeCycleItemView *> * itemArr;
/**< 记录view*/
@property(nonatomic,strong)LYHomeCycleItemView * currentItemView;
/**< 拖拽的view*/
@property(nonatomic,strong)LYHomeCycleItemView * drugItemView;
/**< data*/
@property(nonatomic,strong)LYHomeData * data;

/**< lightImageView 闪光*/
@property(nonatomic,strong)UIImageView * lightImageView;
@end
static NSInteger local = 0;
@implementation LYHomeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[LYUserInfoManager shareInstance].userInfo.actor]placeholderImage:[UIImage imageNamed:@"head_icon"]];
    
}

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
//    [self.earthImageView.layer addAnimation:layer1 forKey:nil];
   
    
    for (int i = 0; i < 6;  i ++ ) {
        LYHomeCycleItemView * redView = [[LYHomeCycleItemView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [self.itemArr addObject:redView];
        
    
        [self.view addSubview:redView];
        [self.homeCycleBgView sendSubviewToBack:redView];
        
          CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
           animation.keyPath = @"position";
           animation.duration = 40;
           animation.removedOnCompletion = NO;
           animation.fillMode = kCAFillModeForwards;
           animation.repeatCount = MAXFLOAT;
//         CGFloat x =  self.view.frame.size.width / 2;
//        CGFloat y =  self.view.frame.size.height / 2 - 50;
        dispatch_async(dispatch_get_main_queue(), ^{
            CGPoint center = self.homeCycleBgView.center;
               UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(center.x, center.y) radius:120 startAngle:M_PI / 3 * i + M_PI / 6 endAngle:M_PI * 2 + M_PI / 3 * i + M_PI / 6 clockwise:true];
               animation.path = circlePath.CGPath;
            [redView.layer addAnimation:animation forKey:nil];
        });
        
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
        [self.itemArr setValue:@(NO) forKey:@"hidden"];
    }];
}

- (void) recoveryRubbish:(NSInteger)rubbishId rubbishType:(NSInteger)type button:(UIButton *)button{
    [LYNetwork POSTWithApiPath:rubbishURL requestParams:@{
        @"rubbishDetailDto":@{
                @"id":@(rubbishId),
                @"index":@(self.data.data.index),
                @"type":@(type)
        }
    } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            [self showLightByButton:button];
        }
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
    [self pushViewControllerWithClassName:@"LYMayiGongHuiViewController" params:nil];
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
- (IBAction)zhaomuAction:(UIButton *)sender {
    [self pushViewControllerWithClassName:@"InvitFriendViewController" params:nil];
}

- (IBAction)gonglueAction:(UIButton *)sender {
    [self pushViewControllerWithClassName:@"" params:nil];
}


/// 展示网络数据
/// @param model 数据模型
- (void) configUIWithData:(LYHomeDataModel *)model{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.actor]placeholderImage:[UIImage imageNamed:@"head_icon"]];
    [LYUserInfoManager shareInstance].userInfo.actor = model.actor;

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     CGPoint point = [[touches anyObject] locationInView:self.view];
    for (LYHomeCycleItemView * itemView in self.itemArr) {
         if ([itemView.layer.presentationLayer hitTest:point]) {
             self.currentItemView = itemView;
             break;
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    self.drugItemView.hidden = YES;
    BOOL isBtnTop = NO;
    for (UIButton * button in self.rubbishBtnArray) {
         CALayer *layer = [button.layer hitTest:point];
        if (layer) {
            isBtnTop = YES;
            button.backgroundColor = [UIColor clearColor];
            NSInteger index = [self.rubbishBtnArray indexOfObject:button] + 1;
            if (index == self.drugItemView.model.rubbishType) {
//                [self showLightByButton:button];
                [self recoveryRubbish:self.currentItemView.model.rubbishId rubbishType:index button:button];
            }else{
                NSInteger index = [self.rubbishBtnArray indexOfObject:button] + 1;
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"btn_%ld",index]] forState:UIControlStateNormal];
            }
        }
    }
    if (!isBtnTop) {
        self.currentItemView = nil;
    }
//
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     CGPoint point = [[touches anyObject] locationInView:self.view];
     self.drugItemView.center = point;
    [self.drugItemView configDataWithModel:self.currentItemView.model];
    self.drugItemView.hidden = self.currentItemView == nil;
    if (self.drugItemView.hidden) {
        return;
    }
    for (UIButton * button in self.rubbishBtnArray) {
         CALayer *layer = [button.layer hitTest:point];
        if (layer) {
           NSInteger index = [self.rubbishBtnArray indexOfObject:button] + 1;
           if (index == self.drugItemView.model.rubbishType) {
               [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"btn_highlight_%ld",index]] forState:UIControlStateNormal];
           }else{
               [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"btn_error_%ld",index]] forState:UIControlStateNormal];
           }
//            button.backgroundColor = [UIColor redColor];
        }else{
             NSInteger index = [self.rubbishBtnArray indexOfObject:button] + 1;
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"btn_%ld",index]] forState:UIControlStateNormal];
//            button.backgroundColor = [UIColor clearColor];
        }
    }
   
}


- (void) showLightByButton:(UIButton *)button{
    self.currentItemView.hidden = YES;
    NSInteger index = [self.rubbishBtnArray indexOfObject:button] + 1;
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"btn_%ld",index]] forState:UIControlStateNormal];
    [self.view makeToast:@"回收成功" duration:1 position:CSToastPositionCenter];
    self.lightImageView.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y - 40, button.frame.size.width, 50);
    self.lightImageView.hidden = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.lightImageView.hidden = YES;
    });
    self.currentItemView = nil;
    
    BOOL complete = YES;
    for (LYHomeCycleItemView * itemView in self.itemArr) {
        if (!itemView.hidden) {
            complete = NO;
        }
    }
    if (complete) {
        [self loadRequest];
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
    CGPoint np = [self.homeCycleBgView convertPoint:self.bgImageView.frame.origin toView:self.view];
    CGFloat originY = np.y;
    CGFloat originX = np.x;
    UIView *item1 = self.itemArr[0];
    item1.center = CGPointMake(lineH + originX, originY);
    
    UIView *item2 = self.itemArr[1];
    item2.center = CGPointMake(lineH *  cos(M_PI_2 / 6) + item1.center.x - 12, item1.center.y + lineH / 2);

    UIView *item3 = self.itemArr[2];
    item3.center = CGPointMake(item2.center.x, item2.center.y + lineH);

    UIView *item4 = self.itemArr[3];
    item4.center = CGPointMake(item1.center.x, item1.center.y + lineH * 2);

    UIView *item5 = self.itemArr[4];
    item5.center = CGPointMake(item3.center.x - 2 * cos(M_PI_2 / 3) * lineH, item3.center.y);

    UIView *item6 = self.itemArr[5];
    item6.center = CGPointMake(item5.center.x , item2.center.y);
}

- (LYHomeCycleItemView *)drugItemView{
    if (!_drugItemView) {
          _drugItemView = [[LYHomeCycleItemView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        _drugItemView.hidden = YES;
        [self.view addSubview:_drugItemView];
    }
    return _drugItemView;
}

- (UIImageView *)lightImageView{
    if (!_lightImageView) {
        _lightImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"g"]];
        [self.view addSubview:_lightImageView];
        _lightImageView.hidden = YES;
    }
    return _lightImageView;
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
