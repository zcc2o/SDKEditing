//
//  NavigationInteractiveTransition.h
//  一些第三方的使用
//
//  Created by 章程程 on 2019/2/12.
//  Copyright © 2019 zcc. All rights reserved.
//
//专门处理交互对象

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UIViewController, UIPercentDrivenInteractiveTransition;

NS_ASSUME_NONNULL_BEGIN

@interface NavigationInteractiveTransition : NSObject <UINavigationControllerDelegate>
- (instancetype)initWithViewController:(UIViewController *)vc;
- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer;
- (UIPercentDrivenInteractiveTransition *)interactivePopTransition;

@end

NS_ASSUME_NONNULL_END
