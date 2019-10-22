// LYMineViewController.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/18. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYMineViewController.h"
#import "LYMineHeaderView.h"
#import "LYMineTableViewCell.h"

#import "InvitationViewController.h"
#import "ContactCustomerViewController.h"
#import "SystemSettingViewController.h"
#import "AGCDetailViewController.h"
#import "LYSafeSettingViewController.h"
#import "MyBillViewController.h"
#import "LYMayiGongHuiViewController.h"
#import "NodeArchitectureViewController.h"
@interface LYMineViewController ()<UITableViewDelegate,UITableViewDataSource,LYMineHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**< icons*/
@property(nonatomic,strong)NSArray<NSString *> * iconsArr;
/**< titleArray*/
@property(nonatomic,strong)NSArray<NSString *> * titlesArr;
@end
static NSString * const kMineTableViewCellIdentifier = @"LYMineTableViewCell";
@implementation LYMineViewController
////vccccceshi

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTableView];
    
    self.navigationItem.title = @"我的";

}
#pragma mark🐒------LYMineHeaderViewDelegate------🐒

/// AGC余额
- (void)clickAGCBalance {
    AGCDetailViewController *AGCVC = [[AGCDetailViewController alloc]init];
    [self.navigationController pushViewController:AGCVC animated:YES];
        
}

/// 邀请好友
- (void)clickInviteFriend {
    InvitationViewController *invitVC = [[InvitationViewController alloc]init];
    [self.navigationController pushViewController:invitVC animated:YES];
}

/// 我的账单
- (void)clickMyBill {
    MyBillViewController *billVC = [[MyBillViewController alloc]init];
    [self.navigationController pushViewController:billVC animated:YES];
    
}

/// 我的等级
- (void)clickMyLevel {
     [self pushViewControllerWithClassName:@"" params:nil];
}

/// t我的团队
- (void)clickMyTeam {
     [self pushViewControllerWithClassName:@"NodeArchitectureViewController" params:nil];
}
// 蚂蚁工会
- (void)clickMayiGonghui{
    [self pushViewControllerWithClassName:@"LYMayiGongHuiViewController" params:nil];
}
#pragma mark🐒------end------🐒

- (void) configTableView{
    self.tableView.rowHeight = UIScreen.mainScreen.bounds.size.width * 53 / 333;
    [self configTableViewHeaderFooterView];
    [self.tableView registerNib:[UINib nibWithNibName:kMineTableViewCellIdentifier bundle:NSBundle.mainBundle] forCellReuseIdentifier:kMineTableViewCellIdentifier];
}

- (void) configTableViewHeaderFooterView{
     LYMineHeaderView *headerView = [[NSBundle mainBundle]loadNibNamed:@"LYMineHeaderView" owner:self options:nil][0];
    CGFloat width = UIScreen.mainScreen.bounds.size.width - 30.f;
    
    headerView.frame = CGRectMake(0, 0, width, width * 322  / 375);
//  UIView * headerView =    [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 200)];
    self.tableView.tableHeaderView = headerView;
    headerView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYMineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMineTableViewCellIdentifier forIndexPath:indexPath];
    [cell configIcon:self.iconsArr[indexPath.section] title:self.titlesArr[indexPath.section]];
    return cell;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 6;
    }
    return 2.f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    if (indexPath.section == 0) {
        LYSafeSettingViewController *safeVC = [[LYSafeSettingViewController alloc]init];
        [self.navigationController pushViewController:safeVC animated:YES];
    }
    if (indexPath.section == 1) {
        SystemSettingViewController *systemVC = [[SystemSettingViewController alloc]init];
        [self.navigationController pushViewController:systemVC animated:YES];
    }
    if (indexPath.section == 2) {
        
    }
    if (indexPath.section == 3) {
        ContactCustomerViewController *custmVC = [[ContactCustomerViewController alloc]init];
        [self.navigationController pushViewController:custmVC animated:YES];
    }
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return [UIView new];
//}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

#pragma mark🐒------lazy------🐒
- (NSArray<NSString *> *)iconsArr{
    if (_iconsArr == nil) {
        _iconsArr = @[@"suoding"
                      ,@"system_setting_icon",
                      @"wenhao",
                      @"banbengengxin"];
    }
    return _iconsArr;
}

- (NSArray<NSString *> *)titlesArr{
    if (_titlesArr == nil) {
        _titlesArr = @[@"安全设置",
                       @"系统设置",
                       @"关于我们",
                       @"联系客服"];
    }
    return _titlesArr;
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
