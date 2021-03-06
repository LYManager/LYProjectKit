// LYTransactionViewController.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/29. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYTransactionViewController.h"
#import "LYTransactionHeaderView.h"
#import "LYTransactionSessionHeaderView.h"
#import "LYTransactionSaleTableViewCell.h"
#import "LYTransactionRecordTableViewCell.h"
#import "LYTradeModel.h"
#import "LYTradePageModel.h"
#import "LYTradeRecordModel.h"
#import "LYTradeRecordPageModel.h"
#import <OYCountDownManager.h>
#import "ReleaseBuyViewController.h"
#import "ReleaseSellViewController.h"
#import "PayDetailViewController.h"
#import "PayStateViewController.h"


@interface LYTransactionViewController ()<UITableViewDelegate,UITableViewDataSource,
LYTransactionSessionHeaderViewDelegate,
LYTransactionSaleTableViewCellDelegate,
LYTransactionRecordTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**< headerView*/
@property(nonatomic,strong)LYTransactionHeaderView * headerView;
/**< SessionHeaderView*/
@property(nonatomic,strong)LYTransactionSessionHeaderView * sessionHeaderView;
/**< type*/
@property(nonatomic,assign)LYTransactionSessionHeaderViewClickType clickType;
/**< model*/
@property(nonatomic,strong)LYTradeModel * model;
/**< array*/
@property(nonatomic,strong)NSMutableArray<LYTradePageModel *> * dataArray;
/**< 记录array*/
@property(nonatomic,strong)NSMutableArray<LYTradeRecordPageModel *> *recordArray;
/**< */
@property(nonatomic,assign)NSInteger pageNum;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCon;
@property (weak, nonatomic) IBOutlet UIButton *fabuBtn;

@end

@implementation LYTransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"交易";
    [self.fabuBtn ly_gradint];
    [self configHeaderView];
    self.clickType = LYTransactionSessionHeaderViewClickType_Sale;
//    [self configBottomCons];
    [kCountDownManager start];
    self.pageNum = 1;
    [self loadRequest:3];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 40);
    [button setTitle:@"交易规则" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tradeRule) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    // Do any additional setup after loading the view from its nib.
}




- (void)loadRequest:(NSInteger)page{
    [LYNetwork POSTWithApiPath:tradeURL requestParams:@{
        @"areaType":@(self.clickType),
        @"pageSize":@(10),
        @"pageNum":@(page)
    } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        LYTradeModel * model = [LYTradeModel modelWithDictionary:response];
        self.model = model;
        [self configHeaderViewWithModel:model];
        if (self.dataArray.count >= model.data.tradeList.total) {
            [self.tableView reloadData];
            return ;
        }
        [self.dataArray addObjectsFromArray:model.data.tradeList.pageList];
        [self.tableView reloadData];
    }];
}

- (void) loadRecordData:(NSInteger)page{
    [LYNetwork POSTWithApiPath:tradeRecordURL requestParams:@{
        @"pageNum":@(self.pageNum),
        @"pageSize":@(10)
    } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        LYTradeRecordModel * model = [LYTradeRecordModel modelWithDictionary:response];
        if (self.recordArray.count >= model.data.total) {
            [self.tableView reloadData];
            return ;
        }
        [self.recordArray addObjectsFromArray:model.data.pageList];
             [self.tableView reloadData];
    }];
}

#pragma mark🐒------下架------🐒
- (void)unSaleAction:(LYTradePageModel *)model{
    @weakify(self)
    [LYNetwork POSTWithApiPath:soldOutURL requestParams:@{
        @"tradeId":@(model.tradeId)
    } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
         @strongify(self)
        [self popConfirmControllerType:ConfirmType_SoldOut backBlock:^{
            [self.dataArray removeObject:model];
            [self.tableView reloadData];
        }];
    }];
}

-(void) addRefresh{
     CGFloat headerWidth  = [UIScreen mainScreen].bounds.size.width;
    self.tableView.mj_header.ignoredScrollViewContentInsetTop = headerWidth * 124 / 414;
    @weakify(self)
       self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           @strongify(self)
           [self.tableView.mj_header endRefreshing];
           [self headerRefreshFinish];
       }];
       
       self.tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
           @strongify(self)
           [self.tableView.mj_footer endRefreshing];
           [self footerRefreshFinish];
       }];
}

- (void) headerRefreshFinish{
    self.pageNum = 1;
    if (self.clickType == LYTransactionSessionHeaderViewClickType_Record) {
        [self.recordArray removeAllObjects];
        [self loadRecordData:self.pageNum];
    }else{
        [self.dataArray removeAllObjects];
        [self loadRequest:self.pageNum];
    }
    
}

- (void)footerRefreshFinish {
    self.pageNum += 1;
       if (self.clickType == LYTransactionSessionHeaderViewClickType_Record) {
           [self loadRecordData:self.pageNum];
       }else{
           [self loadRequest:self.pageNum];
       }
}
#pragma mark🐒------确认放币------🐒
- (void)confirmSendAGC:(LYTradeRecordPageModel *)model{
    [self popConfirmControllerType:ConfirmType_FB backBlock:^{
        [LYNetwork POSTWithApiPath:concormlOutURL requestParams:@{
                    @"tradeId":@(model.recordId)
            } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
            [self.view makeToast:@"已放币" duration:1 position:CSToastPositionCenter];
            [self loadRecordData:1];
         }];
    }];
}

#pragma mark🐒------取消交易------🐒
- (void) cancelTrade:(LYTradeRecordPageModel *)model{
    [self popConfirmControllerType:ConfirmType_CancelTrade backBlock:^{
        [LYNetwork POSTWithApiPath:cancelOutURL requestParams:@{
                    @"tradeId":@(model.recordId)
                } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
               
            [self.view makeToast:@"已取消" duration:1 position:CSToastPositionCenter];
            [self loadRecordData:1];
        }];
    }];
}

#pragma mark🐒------立即支付------🐒
//- (void)payAtOnce:(LYTradeRecordPageModel *)model{
//    NSLog(@"立即支付");
//}

#pragma mark🐒------申述------🐒
- (void)shenshu:(LYTradeRecordPageModel *)model{
    NSLog(@"申述");
}

- (void) configHeaderView{
    LYTransactionHeaderView * headerView = [[NSBundle mainBundle]loadNibNamed:@"LYTransactionHeaderView" owner:self options:nil][0];
    CGFloat headerWidth  = [UIScreen mainScreen].bounds.size.width;
    dispatch_async(dispatch_get_main_queue(), ^{
        headerView.frame = CGRectMake(0, 0, headerWidth, headerWidth * 124 / 414);
        self.tableView.tableHeaderView = headerView;
    });
    self.headerView = headerView;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LYTransactionSaleTableViewCell" bundle:NSBundle.mainBundle] forCellReuseIdentifier:@"LYTransactionSaleTableViewCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"LYTransactionRecordTableViewCell" bundle:NSBundle.mainBundle] forCellReuseIdentifier:@"LYTransactionRecordTableViewCell"];
    self.tableView.rowHeight = 170;
    [self addRefresh];
}

- (void)configHeaderViewWithModel:(LYTradeModel *)model{
    [self.headerView configDataWithModel:model];
}

- (void)clickActionWithType:(LYTransactionSessionHeaderViewClickType)clickType{
    
    self.clickType = clickType;
    [self configBottomCons];
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
    self.pageNum = 1;
    if (clickType == LYTransactionSessionHeaderViewClickType_Record) {
        [self loadRecordData:self.pageNum];
    }else{
        [self loadRequest:self.pageNum];
    }
}
#pragma mark🐒------发布买单------🐒
- (IBAction)fabuBtnAction:(UIButton *)sender {
    ReleaseBuyViewController *releaseVC = [[ReleaseBuyViewController alloc]init];
    releaseVC.model = self.model;
    [self.navigationController pushViewController:releaseVC animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.clickType == LYTransactionSessionHeaderViewClickType_Record) {
        return self.recordArray.count;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (self.clickType == LYTransactionSessionHeaderViewClickType_Record) {
         LYTransactionRecordTableViewCell * recordCell = [tableView dequeueReusableCellWithIdentifier:@"LYTransactionRecordTableViewCell" forIndexPath:indexPath];
        [recordCell configWithModel:self.recordArray[indexPath.row]];
        recordCell.delegate = self;
//        [recordCell configUIWithStatus:indexPath.row % 5];
        return recordCell;
    }else{
         LYTransactionSaleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LYTransactionSaleTableViewCell" forIndexPath:indexPath];
        [cell configDataWithModel:self.dataArray[indexPath.row]];
        [cell configBtnEnable:self.clickType == LYTransactionSessionHeaderViewClickType_Buy];
        cell.delegate = self;
         return cell;
    }
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.sessionHeaderView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.clickType == LYTransactionSessionHeaderViewClickType_Sale) { // 出售
        LYTradePageModel * model = self.dataArray[indexPath.row];
        ReleaseSellViewController *releaseVC = [[ReleaseSellViewController alloc]init];
        releaseVC.model = model;
        releaseVC.tradmodel = self.model;
        releaseVC.successCallback = ^{
            [self loadRequest:1];
        };
        [self.navigationController pushViewController:releaseVC animated:YES];
        // TODO 跳转
    }else if (self.clickType == LYTransactionSessionHeaderViewClickType_Buy){ // 购买
        
        // TODO 跳转
    }else{    // 交易记录
        LYTradeRecordPageModel * model = self.recordArray[indexPath.row];
        if (model.tradeType == 1) {//出售
            PayStateViewController *payVC = [[PayStateViewController alloc]init];
            payVC.model = model;
            payVC.successCallback = ^{
                [self loadRecordData:1];
            };
            [self.navigationController pushViewController:payVC animated:YES];
        }
        else
        {//购买
            PayDetailViewController *payVC = [[PayDetailViewController alloc]init];
            payVC.model = model;
            payVC.successCallback = ^{
                [self loadRecordData:1];
            };
            [self.navigationController pushViewController:payVC animated:YES];
            
            
        }
        // TODO 跳转
    }
}

- (void)tradeRule{
    [self pushViewControllerWithClassName:@"LYTradeRuleViewController" params:nil];
}

- (void) configBottomCons{
    CGFloat bottomCons = self.clickType == LYTransactionSessionHeaderViewClickType_Buy ? 20 : -60;
    [self.view setNeedsLayout];
    [UIView animateWithDuration:0.2 animations:^{
        self.bottomCon.constant = bottomCons;
        [self.view layoutIfNeeded];
    }];
    
}

- (LYTransactionSessionHeaderView *)sessionHeaderView{
    if (!_sessionHeaderView) {
        _sessionHeaderView = [[NSBundle mainBundle]loadNibNamed:@"LYTransactionSessionHeaderView" owner:self options:nil][0];
        _sessionHeaderView.delegate = self;
    }
    return _sessionHeaderView;
}

- (NSMutableArray<LYTradePageModel *> *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray<LYTradeRecordPageModel *> *)recordArray{
    if (!_recordArray) {
        _recordArray = [NSMutableArray array];
    }
    return _recordArray;
}

- (void)dealloc{
    NSLog(@"delloc");
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
