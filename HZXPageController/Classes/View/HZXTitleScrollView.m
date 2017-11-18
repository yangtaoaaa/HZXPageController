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
@property (nonatomic, strong) NSMutableArray *titleButtons;
@property (nonatomic, strong) UIView *titleBottomView;
@property (nonatomic, strong) UIButton *selectedTitleButton;
@end

@implementation HZXTitleScrollView

- (id)initWithFrame:(CGRect)frame titlesArr:(NSArray *)titlesArr
{
    self = [super initWithFrame:frame];
    if (self) {
        _titlesArr = titlesArr;
        [self addScrollView];
        [self addTitleBtns];
    }
    return self;
}

- (void)addTitleBtns
{
    CGFloat allTitleButtonW = 20;
    for (int i = 0; i < _titlesArr.count; i++) {
        // 创建
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:HZXColor(231, 114, 120, 1) forState:UIControlStateSelected];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        titleButton.tag = i;
        [_scrollView addSubview:titleButton];
        [self.titleButtons addObject:titleButton];
        
        // x的位置先固定好
        titleButton.x = allTitleButtonW;
        // 文字
        NSString *title = _titlesArr[i];
        [titleButton setTitle:title forState:UIControlStateNormal];
        [titleButton sizeToFit];
        //titleButton.width += 35;
        allTitleButtonW += titleButton.width + 35;
        
        // frame
        titleButton.y = 0;
        titleButton.height = _scrollView.height;
    }
    
    _scrollView.contentSize = CGSizeMake(allTitleButtonW , 0);
    
    // 标签栏底部的指示器控件
    UIView *titleBottomView = [[UIView alloc] init];
    titleBottomView.backgroundColor = [self.titleButtons.lastObject titleColorForState:UIControlStateSelected];
    titleBottomView.height = 2;
    titleBottomView.y = _scrollView.height - titleBottomView.height;
    [_scrollView addSubview:titleBottomView];
    self.titleBottomView = titleBottomView;
    
    // 默认点击最前面的按钮
    UIButton *firstTitleButton = self.titleButtons.firstObject;
    [firstTitleButton.titleLabel sizeToFit];
    titleBottomView.width = firstTitleButton.titleLabel.width;
    titleBottomView.centerX = firstTitleButton.centerX;
    [self titleClick:firstTitleButton];
}

#pragma mark - 监听
- (void)titleClick:(UIButton *)titleButton
{
    //HZXLog(@"按钮当前的x值是==%lf", titleButton.x);
    // 控制按钮状态
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    // 底部控件的位置和尺寸
    [UIView animateWithDuration:0.25 animations:^{
        self.titleBottomView.width = titleButton.titleLabel.width;
        self.titleBottomView.centerX = titleButton.centerX;
    }];
    
    // 让scrollView滚动到对应的位置
//    CGPoint offset = self.scrollView.contentOffset;
//    offset.x = _scrollView.width * [self.titleButtons indexOfObject:titleButton];
//    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)addScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    //_scrollView.contentSize = CGSizeMake(_titleArrs.count * 50, self.height);
    _scrollView.pagingEnabled = NO;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_scrollView];
}

#pragma mark - lazy
- (NSMutableArray *)titleButtons
{
    if (!_titleButtons) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}

@end
