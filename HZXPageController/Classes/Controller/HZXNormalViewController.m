//
//  HZXNormalViewController.m
//  HZXPageController
//
//  Created by 何紫璇 on 2017/11/16.
//  Copyright © 2017年 hezixuan. All rights reserved.
//

#import "HZXNormalViewController.h"
#import "HZXTestViewController.h"
#import "HZXTitleScrollView.h"

@interface HZXNormalViewController ()<UITableViewDelegate, UITableViewDataSource, HZXTitleScrollViewDelegate>

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
    
    // 时间对应的scrollView
    UIScrollView *timeBgScrollView = [[UIScrollView alloc]init];
    timeBgScrollView.frame = CGRectMake(0, 0, screenWidth, self.view.height - 240);
    timeBgScrollView.backgroundColor = [UIColor greenColor];
    timeBgScrollView.showsVerticalScrollIndicator = YES;
    timeBgScrollView.showsHorizontalScrollIndicator = YES;
    timeBgScrollView.pagingEnabled = YES;
    timeBgScrollView.bounces = NO;
    timeBgScrollView.delegate = self;
    timeBgScrollView.contentSize = CGSizeMake(self.view.width * self.titleArr.count, timeBgScrollView.height);
    [self.view addSubview:timeBgScrollView];
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
    
    // head
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 240)];
    headView.backgroundColor = [UIColor redColor];
    NSArray *titlesArr = [NSArray arrayWithObjects:@"10:00", @"12:00", @"14:00", @"16:00", @"18:00", @"20:00", @"22:00", @"24:00", nil];
    self.tableView.tableHeaderView = headView;
    // 下面的大scrollView
    // 标题
    HZXTitleScrollView *titleScrollView = [[HZXTitleScrollView alloc]initWithFrame:CGRectMake(0, 200, screenWidth, 40) titlesArr:titlesArr];
    titleScrollView.titleScrollViewDelegate = self;
    titleScrollView.customColor = [UIColor lightGrayColor];
    [headView addSubview:titleScrollView];
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
