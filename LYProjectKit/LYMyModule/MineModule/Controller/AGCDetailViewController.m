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
#import "AssetModel.h"
#import "CoinDetailModel.h"
@interface AGCDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)UIButton *withdrwBtn;
@property (nonatomic,strong)UIButton *topBtn;
@property (nonatomic,strong)AssetModel *model;
@property (nonatomic,strong)CoinDetailModel *coinmodel;
@property (nonatomic,strong)NSMutableArray *coinArr;

@property (nonatomic,strong)NSString *chongtzhiStr;
@property (nonatomic,strong)NSString *tiStr;

@property (nonatomic,assign)NSInteger currage;


@end
static NSString * const kAGCCellIdentifier = @"AGCDetailTableViewCell";

@implementation AGCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coinArr = [NSMutableArray  array];
    [self configTableView];
    
    self.navigationItem.title = @"AGC详情";
    [self setUI];
    UIBarButtonItem *rigButton = [[UIBarButtonItem alloc] initWithTitle:@"承兑商" style:UIBarButtonItemStylePlain target:self action:@selector(exitBtnAction)];
    [rigButton setTintColor:[UIColor whiteColor]];
    
//    self.navigationItem.rightBarButtonItem = rigButton;//暂时隐藏
        [self addRefresh];
        
        
        // Do any additional setup after loading the view from its nib.
   
}
- (void)addRefresh
{
      
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadRequest:NO];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       [self loadRequest:YES];
    }];
    

}
- (void)loadRequest:(BOOL)more{

    if (!more) {
           [self.coinArr removeAllObjects];
       }
       if (more) {
           _currage++;
       }else{
           _currage =1;
       }
    [LYNetwork POSTWithApiPath:assetURL requestParams:@{
        @"userId":[LYUserInfoManager shareInstance].userInfo.userId ?:@""
    } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        self.model = [AssetModel modelWithDictionary:response[@"data"]];
         [self configTableViewHeaderFooterView];
        
        //列表
        [LYNetwork POSTWithApiPath:coinTypeURL requestParams:@{
            @"userId":[LYUserInfoManager shareInstance].userInfo.userId ?:@"",
            @"userInfoDTO":@{@"coinType":self.model.coinType},
            @"pageSize":@"10",
            @"pageNum":[NSString stringWithFormat:@"%ld",(long)self.currage]
        } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            NSString *page = [NSString stringWithFormat:@"%@",[[response[@"data"]objectForKey:@"coinBill"] objectForKey:@"pages"]];
            if (self.currage < [page integerValue]) {
                [self.tableView.mj_footer resetNoMoreData];
            }
            else
            {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            NSArray *arr = [[response[@"data"]objectForKey:@"coinBill"]objectForKey:@"pageList"];
            for (int i = 0; i<arr.count; i++) {
                CoinDetailModel *coinmodel = [CoinDetailModel modelWithDictionary:arr[i]];
                [self.coinArr addObject:coinmodel];
   
            }
            self.chongtzhiStr = [[response[@"data"]objectForKey:@"coinInfo"]objectForKey:@"recon"];
            self.tiStr = [[response[@"data"]objectForKey:@"coinInfo"]objectForKey:@"wicon"];

            [self.tableView reloadData];
        }];
        
    }];
    
    
    
}
-(void)setUIData
{
    
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
    headerView.nameLab.text = self.model.name;
    headerView.coinShowLab.text = self.model.agcAmount;
    headerView.rmbLab.text = [NSString stringWithFormat:@"%@%@",@"=",self.model.agcToRmb];

    headerView.nameLab.textColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.coinArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AGCDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kAGCCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    CoinDetailModel *model = self.coinArr[indexPath.row];
    cell.nameLab.text = model.content;
    cell.timeLab.text = [self dateWithString:model.tradeTime];
    cell.coinShowLab.text = model.amount;
    [tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    if ([cell.coinShowLab.text containsString:@"-"]) {
        cell.coinShowLab.textColor = RGB(0, 153, 84, 1.0);
    }
    else
    {
        cell.coinShowLab.textColor = RGB(239, 22, 17, 1.0);
    }
        
    
    return cell;
}
//将时间戳转换为时间字符串
-(NSString*)dateWithString:(NSString*)str

{

    NSTimeInterval time = [str doubleValue];

    /** [[NSDate date] timeIntervalSince1970]*1000;*/

    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象

    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式

    NSString*currentDateStr = [dateFormatter stringFromDate:detaildate];

    return currentDateStr;

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
    TopUpViewController *topVC = [[TopUpViewController alloc]init];
    topVC.assModel = self.model;
    topVC.recon = self.chongtzhiStr;
    [self.navigationController pushViewController:topVC animated:YES];
}
-(void)topBtnAction
{
    WithdrawalViewController *withVC = [[WithdrawalViewController alloc]init];
    withVC.assModel = self.model;
    withVC.wicon = self.tiStr;
    [self.navigationController pushViewController:withVC animated:YES];
    
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
