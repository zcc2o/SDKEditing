//
//  VULTopProgressView.h
//  一些第三方的使用
//
//  Created by 章程程 on 2019/3/19.
//  Copyright © 2019 zcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VULProgressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface VULTopProgressView : UIView

- (void)progressViewWithArray:(NSArray<VULProgressModel *> *)progressModels;

@end

NS_ASSUME_NONNULL_END
