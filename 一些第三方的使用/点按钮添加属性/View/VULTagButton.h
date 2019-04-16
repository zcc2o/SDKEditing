//
//  VULTagButton.h
//  一些第三方的使用
//
//  Created by 章程程 on 2019/1/18.
//  Copyright © 2019 zcc. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface VULTagButton : UIButton

- (void)setTitle:(NSString *)title tag:(NSInteger)tag bgColor:(UIColor *)bgColor selected:(BOOL)selected;

@end

NS_ASSUME_NONNULL_END
