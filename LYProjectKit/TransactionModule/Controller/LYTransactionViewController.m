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
@interface LYTransactionViewController ()<UITableViewDelegate,UITableViewDataSource,LYTransactionSessionHeaderViewDelegate>
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
@end

@implementation LYTransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"交易";
    
    [self configHeaderView];
    self.clickType = LYTransactionSessionHeaderViewClickType_Sale;
    [kCountDownManager start];
    self.pageNum = 1;
    [self loadRequest:1];
    // Do any additional setup after loading the view from its nib.
}




- (void)loadRequest:(NSInteger)page{
    [LYNetwork POSTWithApiPath:tradeURL requestParams:@{
        @"areaType":@(self.clickType),
        @"pageSize":@(10),
        @"pageNum":@(page)
    } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        LYTradeModel * model = [LYTradeModel modelWithDictionary:response];
        [self configHeaderViewWithModel:model];
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
        [self.recordArray addObjectsFromArray:model.data.pageList];
        
             [self.tableView reloadData];
        
       
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
    [self.dataArray removeAllObjects];
    self.pageNum = 1;
    if (clickType == LYTransactionSessionHeaderViewClickType_Record) {
        [self loadRecordData:self.pageNum];
    }else{
        [self loadRequest:self.pageNum];
    }
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
//        [recordCell configUIWithStatus:indexPath.row % 5];
        return recordCell;
    }else{
         LYTransactionSaleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LYTransactionSaleTableViewCell" forIndexPath:indexPath];
        [cell configDataWithModel:self.dataArray[indexPath.row]];
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
