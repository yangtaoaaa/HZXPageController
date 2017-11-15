//
//  ViewController.m
//  HZXPageController
//
//  Created by hezixuan on 2017/11/14.
//  Copyright © 2017年 hezixuan. All rights reserved.
//

#import "HZXViewController.h"

@interface HZXViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *titleArr;

@end


@implementation HZXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"PageController";
    self.titleArr = [NSArray arrayWithObjects:@"带普通导航栏的置顶滑动控件", @"不带导航栏的置顶滑动控件", @"变化导航栏的置顶滑动控件", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12" @"13", @"14", @"15", @"16", @"17", @"18", @"19", nil];
    self.view.backgroundColor = [UIColor whiteColor];
    // tableView
    self.tableView.frame = self.view.frame;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"HZXHomeCellId";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        UILabel *rowlabel = [[UILabel alloc] init];
        rowlabel.frame = CGRectMake(0, 0, screenWidth, 78);
        rowlabel.font = [UIFont systemFontOfSize:18];
        rowlabel.backgroundColor = [UIColor greenColor];
        rowlabel.text = self.titleArr[indexPath.row];
        rowlabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:rowlabel];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
