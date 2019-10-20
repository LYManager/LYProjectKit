// LYMayiGongHuiViewController.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/19. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYMayiGongHuiViewController.h"
#import "LYMayiGongHuiHeaderView.h"
#import "LYMayiGongHuiFooterView.h"
@interface LYMayiGongHuiViewController ()<LYMayiGongHuiHeaderViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LYMayiGongHuiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"蚂蚁工会";
    [self configTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void) configTableView {
    [self configTableViewHeaderFooterView];
//    [self.tableView registerNib:[UINib nibWithNibName:kMineTableViewCellIdentifier bundle:NSBundle.mainBundle] forCellReuseIdentifier:kMineTableViewCellIdentifier];
}
- (void) configTableViewHeaderFooterView{
     LYMayiGongHuiHeaderView *headerView = [[NSBundle mainBundle]loadNibNamed:@"LYMayiGongHuiHeaderView" owner:self options:nil][0];
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat width = UIScreen.mainScreen.bounds.size.width - 30;
        headerView.frame = CGRectMake(0, 0, width, width * 471  / 402);
        self.tableView.tableHeaderView = headerView;
    });
    headerView.delegate = self;
    
    
    LYMayiGongHuiFooterView * footerView = [[NSBundle mainBundle]loadNibNamed:@"LYMayiGongHuiFooterView" owner:self options:nil][0];
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat width = UIScreen.mainScreen.bounds.size.width;
        footerView.frame = CGRectMake(0, 0, width, width * 808  / 397);
        self.tableView.tableHeaderView = headerView;
    });
    self.tableView.tableFooterView = footerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return nil;
}

#pragma mark🐒------LYMayiGongHuiHeaderViewDelegate------🐒
- (void)useCardWithType:(CardType)cardType{
    
}

- (void)sendCaardWithType:(CardType)cardType{
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    [self.headerView configUI];
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
