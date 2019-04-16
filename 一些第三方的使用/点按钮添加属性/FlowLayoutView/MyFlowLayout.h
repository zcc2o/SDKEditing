//
//  MyFlowLayout.h
//  一些第三方的使用
//
//  Created by 章程程 on 2019/1/28.
//  Copyright © 2019 zcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VULTagModel.h"

typedef enum : NSUInteger {
    WaterFlowLayoutTypeHorizontal = 1,
    WaterFlowLayoutTypeVertical,
} WaterFlowLayoutType;

NS_ASSUME_NONNULL_BEGIN

@interface MyFlowLayout : UICollectionViewFlowLayout

 /**< 滚动方向 横竖 */
@property (nonatomic, assign) WaterFlowLayoutType flowLayoutType;

/**
 瀑布流的现实方式 竖向
 
 @return WaterFlowLayoutType 瀑布流显示方向
 */
//- (WaterFlowLayoutType)collectionViewFlowLayoutType;

- (void)flowLayoutWithItemWidth:(CGFloat)itemWidth itemModelArray:(NSArray<VULTagModel *> *)itemModelArray;


/**
 瀑布流实现方式 横向

 @param itemHeight 没个item的高
 @param itemModelArray item文字尺寸数组
 */
- (void)flowLayoutWithItemHeight:(CGFloat)itemHeight itemModelArray:(NSArray<VULTagModel *> *)itemModelArray;

@end

NS_ASSUME_NONNULL_END
