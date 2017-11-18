//
//  HZXTitleScrollView.m
//  HZXPageController
//
//  Created by 何紫璇 on 2017/11/18.
//  Copyright © 2017年 hezixuan. All rights reserved.
//

#import "HZXTitleScrollView.h"

@interface HZXTitleScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *titlesArr;
@end

@implementation HZXTitleScrollView

- (id)initWithFrame:(CGRect)frame titlesArr:(NSArray *)titlesArr
{
    self = [super initWithFrame:frame];
    if (self) {
        _titlesArr = titlesArr;
        [self addScrollView];
    }
    return self;
}


- (void)addScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    //_scrollView.contentSize = CGSizeMake(_titleArrs.count * 50, self.height);
    _scrollView.pagingEnabled = NO;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor purpleColor];
    [self addSubview:_scrollView];
}

@end
