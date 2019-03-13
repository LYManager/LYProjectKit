// LYTableViewController.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/9. 
// Copyright © 2019 赵良育. All rights reserved. 
// 
// <#Class des#>
#import "LYTableViewController.h"
#import "LYCellModelProtocol.h"
@interface LYTableViewController ()

@end



@implementation LYTableViewController

@synthesize tableView = _tableView;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Life
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - Public Methods
// 注册cell
- (void)registerCellWithIdentifiers:(NSArray *)identifiers
{
    [identifiers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.tableView registerClass:NSClassFromString(obj) forCellReuseIdentifier:obj];
    }];
}

#pragma mark - Notification

#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 必须要实现的，暂这样写，外部重写就可以了
    return nil;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    id<LYCellModelProtocol>model = self.dataArray[indexPath.row];
//    return model.cellHeight;
//}

#pragma mark - Private Methods
- (void)configUI
{
    [self.view addSubview:self.tableView];
}


- (void)addRefresh
{
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

- (void)headerRefreshFinish{};
- (void)footerRefreshFinish{};

#pragma mark - Lazy
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 200;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

#pragma mark - dealloc
- (void) dealloc
{
    
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
