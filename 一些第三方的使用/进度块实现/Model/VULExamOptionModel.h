//
//  VULExamOptionModel.h
//  一些第三方的使用
//
//  Created by 章程程 on 2019/3/21.
//  Copyright © 2019 zcc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VULExamOptionModel : NSObject

@property (nonatomic, copy) NSString *itemStr; /**< 选项名 */
@property (nonatomic, strong) NSString *optionStr; /**< 选项字符 */
@property (nonatomic, assign) NSInteger optionNum; /**< 选项数量 */
@property (nonatomic, assign) BOOL selected; /**< 是否选中 */

@end

NS_ASSUME_NONNULL_END
