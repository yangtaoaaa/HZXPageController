//
//  ViewController.m
//  HZXPageController
//
//  Created by hezixuan on 2017/11/14.
//  Copyright © 2017年 hezixuan. All rights reserved.
//

#define kTitleScrollHeight 50

#import "HZXViewController.h"
#import "HZXHomeScrollView.h"
#import "HZXTitleScrollView.h"
#import "HZXNormalViewController.h"


@interface HZXViewController ()<HZXHomeScrollViewDelegate>
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *ctrlArr;

@end


@implementation HZXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *titlesArr = [NSArray arrayWithObjects:@"推荐", @"新品", @"限时购", @"居家", @"餐厨", @"配件", @"服装", @"电器", @"洗护", @"杂货", @"饮食", nil];
    // 下面的大scrollView
    HZXHomeScrollView *homeScrollView = [[HZXHomeScrollView alloc]initWithFrame:CGRectMake(0, statusAndNavHeight + kTitleScrollHeight , screenWidth, self.view.height - statusAndNavHeight - kTitleScrollHeight)titlesCount:titlesArr.count];
    homeScrollView.homeScrollViewelegate = self;
    [self.view addSubview:homeScrollView];
    int index = 0;
    // 子控制器
    for (NSString *titleStr in titlesArr) {
        HZXNormalViewController *normalVc = [[HZXNormalViewController alloc]init];
        normalVc.title = titleStr;
        [self addChildViewController:normalVc];
        // 先放在这
        if (index == 0) {
            [homeScrollView addSubview:normalVc.view];
            index++;
        }
    }
    
    // 标题
    HZXTitleScrollView *titleScrollView = [[HZXTitleScrollView alloc]initWithFrame:CGRectMake(0, kStatusAndNavH, screenWidth, kTitleScrollHeight) titlesArr:titlesArr];
    [self.view addSubview:titleScrollView];
    
}

- (void)scrollViewDidEndDragging:(HZXHomeScrollView *)scrollView
{
    // 取出对应的子控制器
    int index = scrollView.contentOffset.x / scrollView.width;
    UIViewController *willShowChildVc = self.childViewControllers[index];
    
    // 如果控制器的view已经被创建过，就直接返回
    if (willShowChildVc.isViewLoaded) return;
    
    // 添加子控制器的view到scrollView身上
    willShowChildVc.view.frame = scrollView.bounds;
    [scrollView addSubview:willShowChildVc.view];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
