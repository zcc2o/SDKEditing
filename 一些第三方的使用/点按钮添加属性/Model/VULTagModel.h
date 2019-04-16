//
//  VULTagModel.h
//  一些第三方的使用
//
//  Created by 章程程 on 2019/1/26.
//  Copyright © 2019 zcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    VULUserLabelTypeUnKnow,/**< 未知 */
    VULUserLabelTypeIndividuality,/**< 个性标签 */
    VULUserLabelTypeSport,/**< 运动爱好 */
    VULUserLabelTypeMusic, /**< 音乐爱好 */
    VULUserLabelTypeFood, /**< 食物爱好 */
    VULUserLabelTypeMovie, /**< 电影爱好 */
    VULUserLabelTypeBookAndCartoon, /**< 图书和卡通 */
    VULUserLabelTypeTravel, /**< 旅行 */
} VULUserLabelType;

NS_ASSUME_NONNULL_BEGIN

@interface VULTagModel : NSObject

@property (nonatomic, assign) NSInteger tagID; /**< 标签ID */

@property (nonatomic, strong) NSString *tagName; /**< 标签名 */

@property (nonatomic, assign) VULUserLabelType labelType; /**< 标签类型 */

@property (nonatomic, assign) BOOL isSelected; /**< 是否选中的 */

@property (nonatomic, assign) CGSize labelSize; /**< label尺寸 */

@end

NS_ASSUME_NONNULL_END
