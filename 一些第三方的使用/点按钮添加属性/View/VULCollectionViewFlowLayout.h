//
//  VULCollectionViewFlowLayout.h
//  一些第三方的使用
//
//  Created by 章程程 on 2019/1/26.
//  Copyright © 2019 zcc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WaterFlowLayoutTypeHorizontal = 1,
    WaterFlowLayoutTypeVertical,
} WaterFlowLayoutType;

NS_ASSUME_NONNULL_BEGIN

@protocol WaterFlowLayoutDataSource <NSObject>

@required

/**
 瀑布流的现实方式 横竖

 @return WaterFlowLayoutType 瀑布流显示方向
 */
- (WaterFlowLayoutType)collectionViewFlowLayoutType;


/**
 水平模式下 传入每个cell 的width 竖直模式下传入元素的高度

 @return cell的宽度 或者 高度 的数组
 */
- (NSArray *)flowLayoutElementsSize;


/**
 uicollectionview 的宽度

 @return uicollectionview宽
 */
- (CGFloat)flowLayoutWidth;

@optional


/**
 cell 高度不确定时需要实现此方法 制定collectionview中显示的列数

 @return UICollectionView的列数
 */
- (NSInteger)flowLayoutVerticalNumber;


/**
 cellw宽度不确定时 需要实现此方法 元素的高自定义

 @return uicollectionView中没个元素的高度
 */
- (CGFloat)flowLayoutHorizontalCommonHeight;

@end

@interface VULCollectionViewFlowLayout : UICollectionViewFlowLayout

@end

NS_ASSUME_NONNULL_END
