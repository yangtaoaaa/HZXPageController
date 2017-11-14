//
//  ViewController.m
//  HZXPageController
//
//  Created by hezixuan on 2017/11/14.
//  Copyright © 2017年 hezixuan. All rights reserved.
//

#import "HZXViewController.h"

@interface HZXViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation HZXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        UILabel *rowlabel = [[UILabel alloc] init];
        rowlabel.frame = CGRectMake(0, 0, 100, 78);
        rowlabel.backgroundColor = [UIColor greenColor];
        rowlabel.text = [NSString stringWithFormat:@"第%ld行", indexPath.row];
        rowlabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:rowlabel];
    }
    return cell;
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
