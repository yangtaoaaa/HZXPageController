//
//  HZXHomeScrollView.h
//  HZXPageController
//
//  Created by 何紫璇 on 2017/11/18.
//  Copyright © 2017年 hezixuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HZXHomeScrollView;

@protocol HZXHomeScrollViewDelegate<NSObject>
@optional
- (void)scrollViewDidEndDragging:(HZXHomeScrollView *)scrollView;

@end


@interface HZXHomeScrollView : UIScrollView

- (id)initWithFrame:(CGRect)frame titlesCount:(NSInteger)titlesCount;

@property (nonatomic, weak) id<HZXHomeScrollViewDelegate>homeScrollViewelegate;

@end


































