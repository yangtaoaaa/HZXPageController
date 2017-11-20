# HZXPageController
//
//  HZXTestViewController.m
//  GameMall
//
//  Created by hezixuan on 2017/11/20.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "HZXTestViewController.h"

@interface HZXTestViewController ()
@property (nonatomic, strong) UIView *textView;
@end

@implementation HZXTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubViews];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)setupSubViews
{
    UIView *textViewff = [[UIView alloc]init];
    textViewff.frame = CGRectMake(self.view.width / 2 - 50, 0, 100, 100);
    textViewff.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:textViewff];
    UILabel *textLabelff = [[UILabel alloc]init];
    textLabelff.frame = CGRectMake(0, 70, 30, 30);
    textLabelff.text = @"2";
    textLabelff.textColor = [UIColor redColor];
    [textViewff addSubview:textLabelff];
    
    UIView *textView = [[UIView alloc]init];
    textView.frame = CGRectMake(self.view.width / 2 - 50, 0, 100, 100);
    textView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:textView];
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.frame = CGRectMake(0, 70, 30, 30);
    textLabel.text = @"2";
    textLabel.textColor = [UIColor redColor];
    [textView addSubview:textLabel];
    self.textView = textView;
    // 动画开始按钮
    UIButton *beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    beginBtn.frame = CGRectMake(0, self.view.height - 60, 80, 30);
    [beginBtn setTitle:@"开始" forState:UIControlStateNormal];
    [beginBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [beginBtn addTarget:self action:@selector(beginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beginBtn];
    // 返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(100, self.view.height - 60, 80, 30);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

- (void)beginBtnClick
{
    [self rightAnimation];
}

- (void)backBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 向右旋转
- (void)rightAnimation
{
    self.textView.layer.position = CGPointMake(self.textView.mj_x + 50, self.textView.height * 2);
    self.textView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [UIView animateWithDuration:5.f animations:^{
        self.textView.layer.transform = CATransform3DMakeRotation(M_PI/2, 0, 0, 1);
    }completion:^(BOOL finished) {
//        self.textView.layer.position = CGPointMake(0, self.textView.height);//self.view.width 让layer的中心点移动到左下角
//        self.textView.layer.anchorPoint = CGPointMake(0, 1); // 绕着左下角旋转
//        self.textView.layer.transform = CATransform3DMakeRotation(-M_PI/2, 0, 0, 1);
    }];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
