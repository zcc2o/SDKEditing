//
//  VULProgressView.h
//  一些第三方的使用
//
//  Created by 章程程 on 2019/3/19.
//  Copyright © 2019 zcc. All rights reserved.
//
//  三块： 左 中 右 |  >  >  |
//

#import <UIKit/UIKit.h>
#import "VULProgressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VULProgressView : UIView
@property (nonatomic, strong) VULProgressModel *progressModel;
- (void)drawProgressViewWithStatus:(BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
