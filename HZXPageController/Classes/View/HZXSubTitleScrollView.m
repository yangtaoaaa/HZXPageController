//
//  HZXSubTitleScrollView.m
//  HZXPageController
//
//  Created by 何紫璇 on 2017/11/16.
//  Copyright © 2017年 hezixuan. All rights reserved.
//

#import "HZXSubTitleScrollView.h"

@interface HZXSubTitleScrollView()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrV;
@property (strong, nonatomic) UIPageControl *pageC;
@property (strong, nonatomic) UIImageView *imgVLeft;
@property (strong, nonatomic) UIImageView *imgVCenter;
@property (strong, nonatomic) UIImageView *imgVRight;
@property (strong, nonatomic) UILabel *lblImageDesc;
@property (strong, nonatomic) NSMutableDictionary *mDicImageData;
@property (assign, nonatomic) NSUInteger currentImageIndex;
@property (assign, nonatomic) NSUInteger imageCount;

@property (nonatomic, assign) CGFloat imageleftWidth; // image偏离的左边距
@property (nonatomic, assign) CGFloat imageWidth; // image的宽度
@property (nonatomic, assign) BOOL isSingleTapImage;

@end

@implementation HZXSubTitleScrollView
- (id)initWithFrame:(CGRect)frame saleMsgArray:(NSArray *)saleMsgArray{
    self = [super initWithFrame:frame];
    if(self){
        _imageleftWidth = 50;
        _imageWidth = (screenWidth - 120);
        _imageCount = 7;
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI {
    [self addScrollView];
    [self addImageViewsToScrollView];
    [self setDefaultInfo];
}

- (void)addScrollView {
    _scrV = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrV.contentSize = CGSizeMake(_imageWidth * 3 + 20, self.height);
    //HZXLog(@"宽度是%f, imgWidth====%f", screenWidth, _imageWidth);
    _scrV.contentOffset = CGPointMake(_imageWidth - _imageleftWidth, 0.0);
    _scrV.pagingEnabled = YES;
    _scrV.bounces = NO;
    _scrV.showsHorizontalScrollIndicator = NO;
    _scrV.showsVerticalScrollIndicator = NO;
    _scrV.delegate = self;
    [self addSubview:_scrV];
}

- (void)addImageViewsToScrollView {
    //图片视图；左边
    _imgVLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, _imageWidth, self.height)];
    _imgVLeft.contentMode = UIViewContentModeScaleToFill;
    [_scrV addSubview:_imgVLeft];
    
    //图片视图；中间
    _imgVCenter = [[UIImageView alloc] initWithFrame:CGRectMake(_imageWidth+10, 0.0, _imageWidth, self.height)];
    _imgVCenter.contentMode = UIViewContentModeScaleToFill;
    _imgVCenter.userInteractionEnabled = YES;
    [_scrV addSubview:_imgVCenter];
    // 添加手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [_imgVCenter addGestureRecognizer:singleTap];
    
    //图片视图；右边
    _imgVRight = [[UIImageView alloc] initWithFrame:CGRectMake(_imageWidth * 2.0+20, 0.0, _imageWidth, self.height)];
    _imgVRight.contentMode = UIViewContentModeScaleToFill;
    [_scrV addSubview:_imgVRight];
}

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    HZXLog(@"点击的图片信息是====%ld", _currentImageIndex);
}

- (void)reloadImage {
    CGPoint contentOffset = [_scrV contentOffset];
    if (contentOffset.x > (_imageWidth - 0)) { //向左滑动
        _currentImageIndex = (_currentImageIndex + 1) % _imageCount;
    } else if (contentOffset.x < (_imageWidth - 0)) { //向右滑动
        _currentImageIndex = (_currentImageIndex - 1 + _imageCount) % _imageCount;
    }
    
    [self setInfoByCurrentImageIndex:_currentImageIndex];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self reloadImage];
    
    [_scrV setContentOffset:CGPointMake(_imageWidth - _imageleftWidth, 0) animated:NO];
    
    _pageC.currentPage = _currentImageIndex;
    
    NSString *currentImageNamed = [NSString stringWithFormat:@"%lu.png", (unsigned long)_currentImageIndex];
    _lblImageDesc.text = _mDicImageData[currentImageNamed];
}
// 减速开始
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    int index = (scrollView.contentOffset.x - (_imageWidth-_imageleftWidth) + _imageWidth/2) / _imageWidth;
//    if(index == 1){
//        HZXLog(@"index的值是====%d", index);
//        _currentImageIndex = (_currentImageIndex + 1) % _imageCount;
//        [self setInfoByCurrentImageIndex:_currentImageIndex];
//        [_scrV setContentOffset:CGPointMake(_imageWidth - _imageleftWidth, 0) animated:NO];
//
//        _pageC.currentPage = _currentImageIndex;
//    }
//}

- (void)addPageControl{
    _pageC = [UIPageControl new];
    CGSize size= [_pageC sizeForNumberOfPages:_imageCount]; //根据页数返回 UIPageControl 合适的大小
    _pageC.bounds = CGRectMake(0, 0, _imageWidth, self.height);
    _pageC.centerX = screenWidth / 2.0;
    _pageC.y = 90;
    _pageC.numberOfPages = _imageCount;
    _pageC.pageIndicatorTintColor = [UIColor whiteColor];
    _pageC.currentPageIndicatorTintColor = [UIColor brownColor];
    _pageC.userInteractionEnabled = NO; //设置是否允许用户交互；默认值为 YES，当为 YES 时，针对点击控件区域左（当前页索引减一，最小为0）右（当前页索引加一，最大为总数减一），可以编写 UIControlEventValueChanged 的事件处理方法
    [self addSubview:_pageC];
    //HZXLog(@"playScrollView的y值是%lf", self.height);
}

- (void)setDefaultInfo {
    _currentImageIndex = 0;
    [self setInfoByCurrentImageIndex:_currentImageIndex];
}

- (void)setInfoByCurrentImageIndex:(NSUInteger)currentImageIndex {
    NSString *currentImageNamed = [NSString stringWithFormat:@"meishi%lu", (unsigned long)currentImageIndex];
    _imgVCenter.image = [UIImage imageNamed:currentImageNamed];
    _imgVLeft.image = [UIImage imageNamed:[NSString stringWithFormat:@"meishi%lu", (unsigned long)((_currentImageIndex - 1 + _imageCount) % _imageCount)]];
    _imgVRight.image = [UIImage imageNamed:[NSString stringWithFormat:@"meishi%lu", (unsigned long)((_currentImageIndex + 1) % _imageCount)]];
    
    _pageC.currentPage = currentImageIndex;
    _lblImageDesc.text = _mDicImageData[currentImageNamed];
}

// 我写的
- (void)setupChildViews:(CGRect)frame{
    for (int i = 0; i < 7; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor greenColor];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        imageView.image = [UIImage imageNamed:@"timg11"];
        [self.scrV addSubview:imageView];
        imageView.size = CGSizeMake(_imageWidth, frame.size.height);
        imageView.y = 0;
        imageView.x = 10 + (_imageWidth + 10) * i;
        //        if(i == 6){
        //            imageView.x = imageleftWidth - imageWidth;
        //        }
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [imageView addGestureRecognizer:singleTap];
    }
    self.scrV.contentSize = CGSizeMake((_imageWidth+10) * 7 + 10, 0);
    self.scrV.contentOffset = CGPointMake(_imageWidth - _imageleftWidth + 10, 0);
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    if (self.playDelegate && [self.playDelegate respondsToSelector:@selector(playScrollViewDelegate:didSelectImageView:)]) {
        [self.playDelegate playScrollViewDelegate:self didSelectImageView:tap.view.tag];
    }
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    //[self setupTimer];
//    //[self scrollViewDidEndScrollingAnimation:self.mainView];
//}



@end
