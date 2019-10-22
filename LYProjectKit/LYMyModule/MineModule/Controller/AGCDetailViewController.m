//
//  AGCDetailViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/19.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "AGCDetailViewController.h"
#import "AGCDetailHeadView.h"
#import "AGCDetailTableViewCell.h"
#import "TopUpViewController.h"
#import "WithdrawalViewController.h"
#import "AcceptanceViewController.h"
@interface AGCDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)UIButton *withdrwBtn;
@property (nonatomic,strong)UIButton *topBtn;

@end
static NSString * const kAGCCellIdentifier = @"AGCDetailTableViewCell";

@implementation AGCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTableView];
    
    self.navigationItem.title = @"AGC详情";
    [self setUI];
    UIBarButtonItem *rigButton = [[UIBarButtonItem alloc] initWithTitle:@"承兑商" style:UIBarButtonItemStylePlain target:self action:@selector(exitBtnAction)];
    [rigButton setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItem = rigButton;
   
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void) configTableView{
    self.tableView.rowHeight = 60;
    [self configTableViewHeaderFooterView];
    [self.tableView registerNib:[UINib nibWithNibName:kAGCCellIdentifier bundle:NSBundle.mainBundle] forCellReuseIdentifier:kAGCCellIdentifier];
}

- (void) configTableViewHeaderFooterView{
     AGCDetailHeadView *headerView = [[NSBundle mainBundle]loadNibNamed:@"AGCDetailHeadView" owner:self options:nil][0];
    CGFloat width = UIScreen.mainScreen.bounds.size.width - 28.f;
    
    headerView.frame = CGRectMake(0, 0, width, 144);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tableView.tableHeaderView = headerView;
    });
    
    self.tableView.tableFooterView = [UIView new];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AGCDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kAGCCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view= [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:14/255.0 green:16/255.0 blue:24/255.0 alpha:1.0];
    return view;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    if (indexPath.section == 0) {
        
    }
    
}


-(void)setUI
{
    self.withdrwBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.withdrwBtn.frame = CGRectMake(14, UIScreen.mainScreen.bounds.size.height-84-60, 134, 40);
    [self.withdrwBtn setTitle:@"充值" forState:UIControlStateNormal];
    self.withdrwBtn.layer.cornerRadius = 20;
    [self.withdrwBtn addTarget:self action:@selector(withdrwBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.withdrwBtn ly_gradint];
    [self.view addSubview:self.withdrwBtn];
    
    
    self.topBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.topBtn.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width-148, UIScreen.mainScreen.bounds.size.height-84-60, 134, 40);
    [self.topBtn setTitle:@"提币" forState:UIControlStateNormal];
    self.topBtn.layer.cornerRadius = 20;
    [self.topBtn addTarget:self action:@selector(topBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topBtn ly_gradint];
    
    
    [self.view addSubview:self.topBtn];
}
-(void)withdrwBtnAction
{
    WithdrawalViewController *withVC = [[WithdrawalViewController alloc]init];
    [self.navigationController pushViewController:withVC animated:YES];
}
-(void)topBtnAction
{
    TopUpViewController *topVC = [[TopUpViewController alloc]init];
      
    [self.navigationController pushViewController:topVC animated:YES];
}
-(void)exitBtnAction
{
    AcceptanceViewController *accVC = [[AcceptanceViewController alloc]init];
    [self.navigationController pushViewController:accVC animated:YES];
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
