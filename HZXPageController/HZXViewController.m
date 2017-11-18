//
//  ViewController.m
//  HZXPageController
//
//  Created by hezixuan on 2017/11/14.
//  Copyright © 2017年 hezixuan. All rights reserved.
//

#import "HZXViewController.h"
#import "HZXTitleScrollView.h"
#import "HZXNormalViewController.h"


@interface HZXViewController ()
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *ctrlArr;

@end


@implementation HZXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *titlesArr = [NSArray arrayWithObjects:@"推荐", @"新品", @"限时购", @"居家", @"餐厨", @"配件", @"服装", @"电器", @"洗护", @"杂货", @"饮食", nil];
    HZXTitleScrollView *titleScrollView = [[HZXTitleScrollView alloc]initWithFrame:CGRectMake(0, kStatusAndNavH, screenWidth, 50) titlesArr:titlesArr];
    [self.view addSubview:titleScrollView];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
