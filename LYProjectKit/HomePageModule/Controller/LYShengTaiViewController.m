// LYShengTaiViewController.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/19. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYShengTaiViewController.h"
#import "LYShengTaiHeaderView.h"
#import "LYShengTaiShopCardCell.h"
#import "UIColor+Extention.h"
@interface LYShengTaiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
static NSString * const kCardShopCellIdentifier = @"LYShengTaiShopCardCell";
@implementation LYShengTaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"生态";
    [self configTableView];
    
    // Do any additional setup after loading the view from its nib.
}
- (void) configTableView {
    [self configTableViewHeaderFooterView];
    [self.tableView registerNib:[UINib nibWithNibName:kCardShopCellIdentifier bundle:NSBundle.mainBundle] forCellReuseIdentifier:kCardShopCellIdentifier];
}
- (void) configTableViewHeaderFooterView{
    LYShengTaiHeaderView *headerView = [[NSBundle mainBundle]loadNibNamed:@"LYShengTaiHeaderView" owner:self options:nil][0];
     CGFloat width = UIScreen.mainScreen.bounds.size.width - 30;
   dispatch_async(dispatch_get_main_queue(), ^{
      
       headerView.frame = CGRectMake(0, 0, width, width * 140  / 414);
       self.tableView.tableHeaderView = headerView;
   });
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.rowHeight = width * 104 / 333;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorColor = [UIColor ly_colorWithHexString:@"#0C0D13"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYShengTaiShopCardCell * cell = [tableView dequeueReusableCellWithIdentifier:kCardShopCellIdentifier forIndexPath:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[NSBundle mainBundle]loadNibNamed:@"LYShengTaiSessionHeaderView" owner:self options:nil][0];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
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
