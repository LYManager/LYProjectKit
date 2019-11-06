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

#import <OYCountDownManager.h>
@interface LYTransactionViewController ()<UITableViewDelegate,UITableViewDataSource,LYTransactionSessionHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**< SessionHeaderView*/
@property(nonatomic,strong)LYTransactionSessionHeaderView * sessionHeaderView;
/**< type*/
@property(nonatomic,assign)LYTransactionSessionHeaderViewClickType clickType;
@end

@implementation LYTransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"交易";
    
    [self configHeaderView];
    
    [kCountDownManager start];
    // Do any additional setup after loading the view from its nib.
}

- (void) configHeaderView{
    LYTransactionHeaderView * headerView = [[NSBundle mainBundle]loadNibNamed:@"LYTransactionHeaderView" owner:self options:nil][0];
    CGFloat headerWidth  = [UIScreen mainScreen].bounds.size.width;
    dispatch_async(dispatch_get_main_queue(), ^{
        headerView.frame = CGRectMake(0, 0, headerWidth, headerWidth * 124 / 414);
        self.tableView.tableHeaderView = headerView;
    });
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LYTransactionSaleTableViewCell" bundle:NSBundle.mainBundle] forCellReuseIdentifier:@"LYTransactionSaleTableViewCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"LYTransactionRecordTableViewCell" bundle:NSBundle.mainBundle] forCellReuseIdentifier:@"LYTransactionRecordTableViewCell"];
    self.tableView.rowHeight = 170;
}

- (void)clickActionWithType:(LYTransactionSessionHeaderViewClickType)clickType{
    self.clickType = clickType;
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (self.clickType == LYTransactionSessionHeaderViewClickType_Record) {
         LYTransactionRecordTableViewCell * recordCell = [tableView dequeueReusableCellWithIdentifier:@"LYTransactionRecordTableViewCell" forIndexPath:indexPath];
        [recordCell configUIWithStatus:indexPath.row % 5];
        return recordCell;
    }else{
         LYTransactionSaleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LYTransactionSaleTableViewCell" forIndexPath:indexPath];
        
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
