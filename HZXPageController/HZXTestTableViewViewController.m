//
//  HZXTestTableViewViewController.m
//  HZXPageController
//
//  Created by hezixuan on 2017/11/24.
//  Copyright © 2017年 hezixuan. All rights reserved.
//

#import "HZXTestTableViewViewController.h"
#import "HZXTestViewController.h"

#define kCycleHeight 200

@interface HZXTestTableViewViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headImgView;
@end

@implementation HZXTestTableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self setupTableView];
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
//    self.tableView.y -= kCycleHeight;
//    self.tableView.height += kCycleHeight;
//    self.tableView.contentInset = UIEdgeInsetsMake(kCycleHeight, 0, 0, 0);
    //头部视图
    UIImageView *headImgView = [[UIImageView alloc]init];
    headImgView.frame = CGRectMake(0, 0, screenWidth, kCycleHeight);
    headImgView.image = [UIImage imageNamed:@"111"];
    headImgView.contentMode = UIViewContentModeScaleToFill;
    self.headImgView = headImgView;
    
    // backView
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, kCycleHeight)];
    back.backgroundColor = [UIColor redColor];
    [back addSubview:headImgView];
    
    self.tableView.tableHeaderView = back;
    
    // 毛玻璃效果
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
    effectView.frame = CGRectMake(TR(14), 60, TR(218), TR(28));
    UILabel *effectLabel = [[UILabel alloc]init];
    effectLabel.frame = CGRectMake(0, 0, TR(218), TR(28));
    effectLabel.text = @"测试测试";
    effectLabel.textColor = [UIColor redColor];
    effectLabel.font = [UIFont systemFontOfSize:18];
    [effectView.contentView addSubview:effectLabel];
    [self.view addSubview:effectView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset = scrollView.contentOffset.y;
    NSLog(@"移动的值是==%lf", yOffset);
    if (yOffset < 0) {
        CGFloat totalOffset = kCycleHeight + ABS(yOffset);
        CGFloat f = totalOffset / kCycleHeight;
//        _headImgView.frame = CGRectMake(0, yOffset, screenWidth, kCycleHeight+ABS(yOffset));
        _headImgView.frame = CGRectMake(- (screenWidth * f - screenWidth) / 2, yOffset, screenWidth * f, totalOffset);
    }
}

#pragma mark - tableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"HZXNormalWithNavCellId";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        UILabel *rowlabel = [[UILabel alloc] init];
        rowlabel.frame = CGRectMake(0, 0, screenWidth, 98);
        rowlabel.font = [UIFont systemFontOfSize:18];
        rowlabel.backgroundColor = [UIColor whiteColor];
        rowlabel.text = [NSString stringWithFormat:@"第%ld行", indexPath.row];
        rowlabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:rowlabel];
        
        // lineView
        UIView *lineView = [[UIView alloc]init];
        lineView.frame = CGRectMake(0, 0, screenWidth, 2);
        lineView.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:lineView];
    }
    return cell;
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

#pragma mark - tableView dataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HZXTestViewController *testVc = [[HZXTestViewController alloc]init];
    [self presentViewController:testVc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
