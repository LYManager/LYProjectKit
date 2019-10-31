// LYGonghuiRecordViewController.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/31. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYGonghuiRecordViewController.h"
#import "LYGonghuiRecordTableViewCell.h"
#import "LYGonghuiRecordModel.h"
@interface LYGonghuiRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**< <#des#>*/
@property(nonatomic,strong)LYGOnghuiRecordData * data;
@end

@implementation LYGonghuiRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"工会记录";
    [self configTableView];
    
    [self loadRequest];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadRequest{
    [LYNetwork POSTWithApiPath:gonghuiRecordURL requestParams:@{} handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        self.data = [LYGOnghuiRecordData modelWithDictionary:response];
        [self.tableView reloadData];
    }];
}

- (void) configTableView{
    [self.tableView registerNib:[UINib nibWithNibName:@"LYGonghuiRecordTableViewCell" bundle:nil] forCellReuseIdentifier:@"LYGonghuiRecordTableViewCell"];
    self.tableView.rowHeight = 92;
    self.tableView.tableFooterView = [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYGonghuiRecordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LYGonghuiRecordTableViewCell" forIndexPath:indexPath];
    [cell configDataWithModel:self.data.data[indexPath.row]];
    return cell;
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
