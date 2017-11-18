//
//  HZXHomeScrollView.m
//  HZXPageController
//
//  Created by 何紫璇 on 2017/11/18.
//  Copyright © 2017年 hezixuan. All rights reserved.
//

#import "HZXHomeScrollView.h"

@interface HZXHomeScrollView()<UIScrollViewDelegate>


@end

@implementation HZXHomeScrollView

- (id)initWithFrame:(CGRect)frame titlesCount:(NSInteger)titlesCount
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor greenColor];
        self.showsHorizontalScrollIndicator = YES;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.delegate = self;
        self.contentSize = CGSizeMake(self.width * titlesCount, 0);
    }
    return self;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    HZXLog(@"dd");
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.homeScrollViewelegate && [self.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.homeScrollViewelegate scrollViewDidEndDragging:self];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    HZXLog(@"停止拖拽");
}

@end
