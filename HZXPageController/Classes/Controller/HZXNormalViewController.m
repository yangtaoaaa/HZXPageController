//
//  HZXNormalViewController.m
//  HZXPageController
//
//  Created by 何紫璇 on 2017/11/16.
//  Copyright © 2017年 hezixuan. All rights reserved.
//

#import "HZXNormalViewController.h"
#import "HZXTestViewController.h"

@interface HZXNormalViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation HZXNormalViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"普通带导航";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleArr = [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", nil];
    
    [self setupTableView];
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.height -= (statusAndNavHeight + 50);
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 180)];
    headView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = headView;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"HZXNormalWithNavCellId";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        UILabel *rowlabel = [[UILabel alloc] init];
        rowlabel.frame = CGRectMake(0, 0, screenWidth, 78);
        rowlabel.font = [UIFont systemFontOfSize:18];
        rowlabel.backgroundColor = [UIColor whiteColor];
        rowlabel.text = self.titleArr[indexPath.row];
        rowlabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:rowlabel];
        
        // lineView
        UIView *lineView = [[UIView alloc]init];
        lineView.frame = CGRectMake(0, 79, screenWidth, 1);
        lineView.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:lineView];
    }
    return cell;
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

#pragma mark - tableView dataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HZXTestViewController *testVc = [[HZXTestViewController alloc]init];
    [self presentViewController:testVc animated:YES completion:nil];
}



@end
