//
//  MyFlowLayout.m
//  一些第三方的使用
//
//  Created by 章程程 on 2019/1/28.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "MyFlowLayout.h"
#import "UIView+EXTENSION.h"

@interface MyFlowLayout ()

///**
// item 的高度数组
// */
//@property (nonatomic, copy) NSArray<VULTagModel *> *arrItemHeight;
//
//
///**
// item 的宽度数组  提前计算的
// */
//@property (nonatomic, copy) NSArray<VULTagModel *> *arrItemWidth;

 /**< item尺寸数组 */
@property (nonatomic, copy) NSArray<VULTagModel *> *itemModelArray;


/**
 cell 布局属性数组
 */
@property (nonatomic, strong) NSArray<UICollectionViewLayoutAttributes *> *arrAttributes;

@property (nonatomic, assign) NSInteger lineNumber; /**< 横向布局时列表的行数 */

@property (nonatomic, assign) CGSize contentSize;

@end

@implementation MyFlowLayout


/**
 瀑布流 布局方法

 @param itemWidth item 的宽度
 @param itemModelArray item 内容数组（包括itemsize尺寸）
 */
- (void)flowLayoutWithItemWidth:(CGFloat)itemWidth itemModelArray:(NSArray<VULTagModel *> *)itemModelArray {
    //传入纵向瀑布流数据
    self.itemSize = CGSizeMake(itemWidth, 0);
    self.itemModelArray = itemModelArray;
    [self.collectionView reloadData];
}

- (void)flowLayoutWithItemHeight:(CGFloat)itemHeight itemModelArray:(nonnull NSArray<VULTagModel *> *)itemModelArray{
    //横向瀑布流数据
    self.itemSize = CGSizeMake(0, itemHeight);
    self.itemModelArray = itemModelArray;
    [self.collectionView reloadData];
}

- (void)prepareLayout {
    [super prepareLayout];
    
    //这里 判断并切换瀑布流方向
    switch (_flowLayoutType) {
        case WaterFlowLayoutTypeHorizontal:
        {
            //横向
            [self horizontalLayout];
        }
            break;
        case WaterFlowLayoutTypeVertical:
        {
            //纵向
            [self verticalLayout];
        }
            break;
        default:
            break;
    }
}

//—————————————————————————————————下面方法为横向—————————————————————————————————//
- (void)horizontalLayout {
//    if ([self.itemModelArray count] == 0) {
//        return ;
//    }
    
    //创建数组 保存每一行宽度
    NSMutableArray *lineWidthArrM = [NSMutableArray array];
    CGFloat firstLineWidth = 0;
    [lineWidthArrM addObject:[NSNumber numberWithFloat:firstLineWidth]];
    
    CGFloat rowHeight = self.itemSize.height;
    
    NSMutableArray *arrmTemp = [NSMutableArray arrayWithCapacity:100];
    
    //遍历修改位置
    //直接获取att
    for (int i = 0; i < [self.itemModelArray count]; i++) {
        //获取index
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        //创建布局属性
        UICollectionViewLayoutAttributes *attris = [self layoutAttributesForItemAtIndexPath:index];
        CGRect rectFrame = attris.frame;
        
        //传入数据注意不得超过屏幕内容宽
        VULTagModel *tagModel = self.itemModelArray[i];
        
        rectFrame.size.width = tagModel.labelSize.width;
        //判断当前行宽度
        
        //当前行宽
        CGFloat lastLineWidth = [lineWidthArrM.lastObject doubleValue];
        
        if (lastLineWidth + self.minimumLineSpacing + rectFrame.size.width + self.sectionInset.right < self.collectionView.width) {
            //更新表情的x值
            rectFrame.origin.x = lastLineWidth + self.minimumLineSpacing;
            lastLineWidth = lastLineWidth + self.minimumLineSpacing + rectFrame.size.width;
            [lineWidthArrM replaceObjectAtIndex:lineWidthArrM.count - 1 withObject:[NSNumber numberWithDouble:lastLineWidth]];
        } else {
            CGFloat lastLineWidth = self.sectionInset.left;
            rectFrame.origin.x = lastLineWidth;
            lastLineWidth = lastLineWidth + rectFrame.size.width;
            [lineWidthArrM addObject:[NSNumber numberWithDouble:lastLineWidth]];
        }
        //更新标签的y值
        rectFrame.origin.y = self.sectionInset.top + (lineWidthArrM.count - 1) * (rowHeight + self.minimumInteritemSpacing);
        attris.frame = rectFrame;
        [arrmTemp addObject:attris];
    }
    self.arrAttributes = arrmTemp;
    // 规律 总间隔数 = 总行数+总个数
//    self.itemSize = CGSizeMake((self.collectionViewContentSize.width * lineWidthArrM.count - (lineWidthArrM.count + self.arrAttributes.count) * self.minimumInteritemSpacing) / self.arrAttributes.count, self.itemSize.height);
    
    //总宽度
    CGFloat totalWidth = 0;
    for (NSNumber *lineWidth in lineWidthArrM) {
        totalWidth += [lineWidth floatValue];
    }
    
    CGFloat averageWidth = (totalWidth - self.arrAttributes.count * self.minimumInteritemSpacing) / self.arrAttributes.count;
    self.itemSize = CGSizeMake(averageWidth, self.itemSize.height);
    self.lineNumber = lineWidthArrM.count;
    self.contentSize = CGSizeMake(self.collectionView.width - self.minimumInteritemSpacing * 2, self.lineNumber * (self.itemSize.height + self.minimumLineSpacing) + self.minimumLineSpacing);
}

//返回精确的collectioncontentinsert高度
- (CGSize)collectionViewContentSize {
    if (_flowLayoutType == WaterFlowLayoutTypeVertical) {
        return [super collectionViewContentSize];
    } else {
        return self.contentSize;
    }
}

//————————————————————————————————下面方法为纵向——————————————————————————————————//
- (void)verticalLayout {
    //item 数量为零 不做处理
    if ([self.itemModelArray count] == 0) {
        return ;
    }
    
    //计算一行可以放多少个项
    NSInteger nItemInRow = (self.collectionViewContentSize.width - self.sectionInset.left - self.sectionInset.right + self.minimumInteritemSpacing) / (self.itemSize.width + self.minimumInteritemSpacing);
    
    NSMutableArray *arrmColumnLength = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < nItemInRow; i++) {
        [arrmColumnLength addObject:@0];
    }
    
    NSMutableArray *arrmTemp = [NSMutableArray arrayWithCapacity:100];
    //遍历设置每一个item的布局
    for (int i = 0; i < [self.itemModelArray count]; i++) {
        //设置没个item的位置相关属性
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        //创建一个布局属性累  通过indexpath来创建
        UICollectionViewLayoutAttributes *attris = [self layoutAttributesForItemAtIndexPath:index];
        CGRect rectFrame = attris.frame;
        //由数组 获得内容真实高度
        VULTagModel *tagModel = self.itemModelArray[i];
        rectFrame.size.height = tagModel.labelSize.height;
        //最短列序号
        NSInteger nNumberShort = 0;
        //假设第一列为最短长度的一列
        CGFloat fshortLength = [arrmColumnLength[0] doubleValue];
        //循环判断是否有更短的一列
        for (int i = 1; i < [arrmColumnLength count]; i++) {
            CGFloat fLength = [arrmColumnLength[i] doubleValue];
            if (fLength < fshortLength) {
                nNumberShort = i;
                fshortLength = fLength;
            }
        }
        rectFrame.origin.x = self.sectionInset.left + (self.itemSize.width + self.minimumInteritemSpacing) * nNumberShort;
        rectFrame.origin.y = fshortLength + self.minimumLineSpacing;
        //更新保存 每列长度的数组
        arrmColumnLength[nNumberShort] = [NSNumber numberWithDouble:CGRectGetMaxY(rectFrame)];
        //更新布局
        attris.frame = rectFrame;
        [arrmTemp addObject:attris];
    }
    self.arrAttributes = arrmTemp;
    //因为使用了瀑布流布局使得滚动范围是根据item的大小和个数决定的， 所以以最长的列为l基准，将高度平均到每一个cell中
    //最长的序列号
    NSInteger nNumLong = 0;
    //最长的长度
    CGFloat fLongLength = [arrmColumnLength[0] doubleValue];
    //寻找最长的列*********
    for (int i = 1; i < arrmColumnLength.count; i++) {
        CGFloat flength = [arrmColumnLength[i] doubleValue];
        if (flength > fLongLength) {
            fLongLength = flength;
            nNumLong = i;
        }
    }
    
    //在大小一样的情况下，有多少行
    NSInteger nRows = ([self.itemModelArray count] + nItemInRow - 1) / nItemInRow;
    self.itemSize = CGSizeMake(self.itemSize.width, (fLongLength + self.minimumLineSpacing) / nRows - self.minimumLineSpacing);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.arrAttributes;
}

@end
