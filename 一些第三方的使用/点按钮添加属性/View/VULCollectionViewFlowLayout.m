//
//  VULCollectionViewFlowLayout.m
//  一些第三方的使用
//
//  Created by 章程程 on 2019/1/26.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "VULCollectionViewFlowLayout.h"

@interface VULCollectionViewFlowLayout (){
    NSArray *elementsSize; /**< 布局元素尺寸储存数组 */
    NSMutableArray *_arrayPosition; /**< 元素布局位置储存数组 */
    CGFloat flowLayoutWidth; /**< UICollectionView的宽度 */
    CGFloat HorizontalHeight; /**< UICollectionView的总高度 */
    
    //垂直布局
    NSInteger verticalNumber; /**< 纵向瀑布流布局时的列数 */
    
    //水平布局
    NSMutableArray *_dicVerticalHeight; /**< 对应列高度储存字典 */
    CGFloat horizontalElementsHeight; /**< 水平模式下每行元素的高度 */
    
    WaterFlowLayoutType flowLayoutType; /**< 布局模式 */
}

@end

@implementation VULCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    [self collectionViewFlowLayoutSource];
    
    switch (flowLayoutType) {
        case WaterFlowLayoutTypeHorizontal:
        {
            [self flowLayoutHorizontal];
        }
            break;
        case WaterFlowLayoutTypeVertical:
        {
            [self flowLayoutVertical];
        }
            break;
        default:
            break;
    }
}

- (void)collectionViewFlowLayoutSource {
    
}

- (void)flowLayoutHorizontal {
    [_arrayPosition removeAllObjects];
    CGFloat positionX = self.sectionInset.left;//最左边
    
    HorizontalHeight = self.sectionInset.top;//垂直方向的y
    CGFloat elementsWidth; //每个item的宽
    
    for (NSInteger i = 0; i < [elementsSize count]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        elementsWidth = [[elementsSize objectAtIndex:i] floatValue];
        NSAssert(elementsWidth > flowLayoutWidth, @"这个元素比collectionview的宽度还宽");
        if ((positionX + self.sectionInset.right + elementsWidth) > flowLayoutWidth) {
            //加入citem后
            positionX = self.sectionInset.left;
            HorizontalHeight = HorizontalHeight + horizontalElementsHeight + self.minimumInteritemSpacing;
            attr.frame = CGRectMake(positionX, HorizontalHeight, elementsWidth, horizontalElementsHeight);
            positionX = positionX + elementsWidth + self.minimumLineSpacing;
        } else {
            attr.frame = CGRectMake(positionX, HorizontalHeight, elementsWidth, horizontalElementsHeight);
            positionX = positionX + elementsWidth + self.minimumLineSpacing;
        }
        [_arrayPosition addObject:attr];
    }
    HorizontalHeight = HorizontalHeight + horizontalElementsHeight;
}

- (void)flowLayoutVertical {
    
}

@end
