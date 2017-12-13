//
//  HZXRefreshDataViewController.m
//  HZXPageController
//
//  Created by 何紫璇 on 2017/12/5.
//  Copyright © 2017年 hezixuan. All rights reserved.
//

#import "HZXRefreshDataViewController.h"

@interface HZXRefreshDataViewController ()

@end

@implementation HZXRefreshDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *yxImgView = [[UIImageView alloc]init];
    yxImgView.frame = CGRectMake(0, 100, 300, 300);
    yxImgView.image = [UIImage imageNamed:@"yxImage"];
    [self.view addSubview:yxImgView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
