//
//  HZXRefreshDataViewController.m
//  HZXPageController
//
//  Created by 何紫璇 on 2017/12/5.
//  Copyright © 2017年 hezixuan. All rights reserved.
//

#import "HZXRefreshDataViewController.h"

@interface HZXRefreshDataViewController ()

@property (nonatomic, strong) UIImageView *yxImgView;
@property (nonatomic, strong) CABasicAnimation* refreshRotationAnimation;
@property (nonatomic, assign) CGFloat angle;

@end

@implementation HZXRefreshDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *yxImgView = [[UIImageView alloc]init];
    yxImgView.frame = CGRectMake(0, 100, 300, 300);
    yxImgView.layer.masksToBounds = YES;
    yxImgView.layer.cornerRadius = yxImgView.width * 0.5;
    yxImgView.image = [UIImage imageNamed:@"timg111.jpeg"];
    [self.view addSubview:yxImgView];
    self.yxImgView = yxImgView;
    // 红点
    UIImageView *redPointImgView = [[UIImageView alloc]init];
    redPointImgView.frame = CGRectMake(0, 0, 10, 10);
    redPointImgView.centerX = yxImgView.centerX;
    redPointImgView.centerY = yxImgView.centerY;
    redPointImgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redPointImgView];
    // 开始
    UIButton *beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    beginBtn.frame = CGRectMake(0, CGRectGetMaxY(yxImgView.frame) + 50, 100, 30);
    beginBtn.centerX = self.view.centerX;
    beginBtn.backgroundColor = [UIColor lightGrayColor];
    [beginBtn setTitle:@"开始" forState:UIControlStateNormal];
    [beginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    beginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [beginBtn addTarget:self action:@selector(beginRefreshAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beginBtn];
    self.angle = M_PI;
}

- (void)beginRefreshAnimation
{
    _refreshRotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    _refreshRotationAnimation.fromValue = [NSNumber numberWithFloat: self.angle];
    NSLog(@"angle====%lf", self.angle);
    _refreshRotationAnimation.toValue = [NSNumber numberWithFloat:(self.angle - M_PI * 2)];
    _refreshRotationAnimation.duration = 10;
    _refreshRotationAnimation.cumulative = NO;
    _refreshRotationAnimation.repeatCount = 3;
    _refreshRotationAnimation.removedOnCompletion = NO;
    _refreshRotationAnimation.fillMode = kCAFillModeForwards;
    [self.yxImgView.layer addAnimation:_refreshRotationAnimation forKey:@"rotationAnimation"];
//    self.angle = self.yxImgView.;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
