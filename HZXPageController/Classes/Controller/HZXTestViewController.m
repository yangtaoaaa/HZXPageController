//
//  HZXTestViewController.m
//  HZXPageController
//
//  Created by 何紫璇 on 2017/11/20.
//  Copyright © 2017年 hezixuan. All rights reserved.
//

#import "HZXTestViewController.h"

@interface HZXTestViewController ()
@property (nonatomic, strong) UIView *textView;
@property (nonatomic, assign) BOOL isDouble;
@end

@implementation HZXTestViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubViews];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)setupSubViews
{
    UIView *textViewff = [[UIView alloc]init]; textViewff.frame = CGRectMake(self.view.width / 2 - 50, 0, 100, 100);
    textViewff.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:textViewff];
    UILabel *textLabelff = [[UILabel alloc]init];
    textLabelff.frame = CGRectMake(0, 70, 30, 30);
    textLabelff.text = @"2";
    textLabelff.textColor = [UIColor redColor];
    [textViewff addSubview:textLabelff];
    UIImageView *circleImgView = [[UIImageView alloc]init];
    circleImgView.frame = CGRectMake(0, 0, 400, 400);
    circleImgView.centerX = self.view.centerX;
    circleImgView.clipsToBounds = YES;
    circleImgView.layer.cornerRadius = 200;
    circleImgView.layer.borderWidth = 1;
    circleImgView.layer.borderColor = [UIColor greenColor].CGColor;
    [self.view addSubview:circleImgView];
    
    UIView *textView = [[UIView alloc]init];
    textView.frame = CGRectMake(self.view.width / 2 - 50, 0, 100, 100);
    textView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:textView];
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.frame = CGRectMake(0, 70, 30, 30);
    textLabel.text = @"2";
    textLabel.textColor = [UIColor redColor];
    [textView addSubview:textLabel];
    self.textView = textView; // 动画开始按钮
    UIButton *beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    beginBtn.frame = CGRectMake(0, self.view.height - 60, 80, 30);
    [beginBtn setTitle:@"开始" forState:UIControlStateNormal];
    [beginBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [beginBtn addTarget:self action:@selector(beginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beginBtn]; // 返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(100, self.view.height - 60, 80, 30);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside]; [self.view addSubview:backBtn];
    
    self.textView.layer.transform = CATransform3DMakeRotation(-M_PI/2, 0, 0, 1);
    self.textView.layer.position = CGPointMake(self.textView.x-100, self.textView.height*2);
}

- (void)leftToMiddleAnimation
{
    _isDouble = !_isDouble;
    if (_isDouble) {
//        self.textView.layer.anchorPoint = CGPointMake(-1.5, 0.5);
        [UIView animateWithDuration:5.f animations:^{
            self.textView.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1);
        }completion:^(BOOL finished) {
        }];
    } else {
        self.textView.layer.position = CGPointMake(self.textView.x - 100, self.textView.height*2);
        self.textView.layer.anchorPoint = CGPointMake(0.5, 2);
        [UIView animateWithDuration:5.f animations:^{ self.textView.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1); }completion:^(BOOL finished) {
        }];
    }
}

-(void)beginBtnClick
{
//    [self rightAnimation];
    [self leftToMiddleAnimation];
}
    
-(void)backBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
    
#pragma mark - 中间向右旋转
    
-(void)rightAnimation
{
    _isDouble = !_isDouble;
    if (_isDouble) {
    self.textView.layer.position = CGPointMake(self.textView.x + 50, self.textView.height*2);
    self.textView.layer.anchorPoint = CGPointMake(0.5, 2);
    [UIView animateWithDuration:5.f animations:^{
        self.textView.layer.transform = CATransform3DMakeRotation(M_PI/2, 0, 0, 1);
    }completion:^(BOOL finished) {
//        self.textView.layer.position = CGPointMake(0, self.textView.height);//self.view.width 让layer的中心点移动到左下角
//        self.textView.layer.anchorPoint = CGPointMake(0, 1); // 绕着左下角旋转
//        self.textView.layer.transform = CATransform3DMakeRotation(-M_PI/2, 0, 0, 1);
    }];
    }
    else {
        self.textView.layer.position = CGPointMake(self.textView.x - 100, self.textView.height*2);
        self.textView.layer.anchorPoint = CGPointMake(0.5, 2);
        [UIView animateWithDuration:5.f animations:^{ self.textView.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1); }completion:^(BOOL finished) {
        }];
    }
}
        
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
