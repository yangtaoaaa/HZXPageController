//
//  HZXSubTitleScrollView.h
//  HZXPageController
//
//  Created by 何紫璇 on 2017/11/16.
//  Copyright © 2017年 hezixuan. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HZXSubTitleScrollView;

@protocol PlayScrollViewDelegate <NSObject>
@optional
/** 点击图片回调 */
- (void)playScrollViewDelegate:(HZXSubTitleScrollView *)playScrollView didSelectImageView:(long)index;
/** 图片滚动回调 */
- (void)playScrollViewDelegate:(HZXSubTitleScrollView *)playScrollView didScrollToIndex:(NSInteger)index;
@end


@interface HZXSubTitleScrollView : UIView

@property (nonatomic, assign) id <PlayScrollViewDelegate>playDelegate;

- (id)initWithFrame:(CGRect)frame saleMsgArray:(NSArray *)saleMsgArray;

@property (nonatomic, strong) NSArray *saleMsgArray; // 商品信息
@property (nonatomic, strong) NSArray *imagesArray;    // 存放所有需要滚动的图片 UIImage
@property (nonatomic, strong) NSArray *saleTitleArray; //
@property (nonatomic, strong) NSArray *saleTypeArray;  // 类别
@property (nonatomic, strong) NSArray *moneyArray;     // 价钱

@end
