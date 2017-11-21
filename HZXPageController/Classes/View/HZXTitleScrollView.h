//
//  HZXTitleScrollView.h
//  HZXPageController
//
//  Created by 何紫璇 on 2017/11/18.
//  Copyright © 2017年 hezixuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HZXTitleScrollView;

@protocol HZXTitleScrollViewDelegate <NSObject>
@optional

- (void)didSelectTitleBtn:(HZXTitleScrollView *)titleScrollView index:(NSInteger)index;

@end


@interface HZXTitleScrollView : UIView

@property (nonatomic, weak) id<HZXTitleScrollViewDelegate>titleScrollViewDelegate;
@property (nonatomic, strong) UIColor *customColor;
- (id)initWithFrame:(CGRect)frame titlesArr:(NSArray *)titlesArr;

@end
