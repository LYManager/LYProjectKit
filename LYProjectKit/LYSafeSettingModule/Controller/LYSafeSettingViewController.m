// LYSafeSettingViewController.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/19. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYSafeSettingViewController.h"
#import "LYSafeSettingTableViewCell.h"
#import "LYLoginPwdViewController.h"
typedef NSString * ControllerName;
@interface LYSafeSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**< data*/
@property(nonatomic,strong)NSArray<NSString *> * titleArray;
/**< push vc names*/
@property(nonatomic,strong)NSArray<ControllerName> * controllerNames;
@end
static NSString * const kSettingCellIdentifier = @"LYSafeSettingTableViewCell";
@implementation LYSafeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTable];
    
    self.navigationItem.title = @"安全设置";
    // Do any additional setup after loading the view from its nib.
}

- (void) configTable {
    [self.tableView registerNib:[UINib nibWithNibName:kSettingCellIdentifier bundle:NSBundle.mainBundle] forCellReuseIdentifier:kSettingCellIdentifier];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = (UIScreen.mainScreen.bounds.size.width - 30) * 53 / 333;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYSafeSettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kSettingCellIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = self.titleArray[indexPath.section];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    LYLoginPwdViewController * vc = [[LYLoginPwdViewController alloc]initWithNibName:@"LYLoginPwdViewController" bundle:NSBundle.mainBundle];
//    [self.navigationController pushViewController:vc animated:YES];
    
    if (indexPath.section == 0) {
        LYLoginPwdViewController *logVC = [[LYLoginPwdViewController alloc]init];
        logVC.myTag =  @"登录密码";
        [self.navigationController pushViewController:logVC animated:YES];
    }
    else if (indexPath.section == 1)
    {
        LYLoginPwdViewController *logVC = [[LYLoginPwdViewController alloc]init];
        logVC.myTag =  @"交易密码";
        [self.navigationController pushViewController:logVC animated:YES];
    }
    else
    {
        NSInteger nums = [self.params[@"cardNums"]integerValue];
        if (nums > 0) {
            LYAntCardModel * cardModel = [[LYAntCardModel alloc]init];
            cardModel.cardId = 1;
            [self pushViewControllerWithClassName:self.controllerNames[indexPath.section] params:@{@"realNameCardModel":cardModel}];
        }else{
            [self popErrorControllerIsSend:NO isRealNameCard:YES];
        }
    }
    
}

- (NSArray<NSString *> *)titleArray{
    if (_titleArray == nil) {
        _titleArray = @[
            @"登录密码",
            @"交易密码",
            @"身份认证",
            @"绑定支付宝",
            @"绑定微信"
        ];
    }
    return _titleArray;
}

- (NSArray<ControllerName> *)controllerNames{
    if (!_controllerNames) {
        _controllerNames = @[
            @"LYLoginPwdViewController",
            @"",
            @"LYRealNameAuthViewController",
            @"",
            @"",
            @""
        ];
    }
    return _controllerNames;
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
