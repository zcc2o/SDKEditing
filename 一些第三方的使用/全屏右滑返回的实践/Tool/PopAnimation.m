//
//  PopAnimation.m
//  一些第三方的使用
//
//  Created by 章程程 on 2019/2/12.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "PopAnimation.h"
#define VULRGBColor(r,g,b,al) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:al]

@interface PopAnimation ()

@property (nonatomic, strong) id <UIViewControllerAnimatedTransitioning> transitionContext;

@end

@implementation PopAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
     /**
      获取动画来自哪个控制器
      */
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
     /**
      获取转场到的哪个控制器
      */
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
     /**
      转场动画是两个控制器视图时间的动画 需要一个containerview来作为舞台 让动画执行
      */
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
     /**
      执行动画 w让fromviewi移动到最右侧
      */
    
    toViewController.view.transform = CGAffineTransformMakeTranslation( -[UIScreen mainScreen].bounds.size.width / 2, 0);
    
    fromViewController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:fromViewController.view.bounds].CGPath;
    fromViewController.view.layer.shadowColor = VULRGBColor(0, 0, 0, 1).CGColor;
    fromViewController.view.layer.shadowOffset = CGSizeMake(-3, 0);
    fromViewController.view.layer.shadowRadius = 3;
    fromViewController.view.layer.shadowOpacity = 0.2;
    
    [UIView animateWithDuration:duration animations:^{
        fromViewController.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0);
        toViewController.view.transform = CGAffineTransformMakeTranslation( 0, 0);
    } completion:^(BOOL finished) {
         /**<
           当你的动画执行完成 这个方法必须要调用 否则系统会认为你的奇遇操作都在动画执行过程中
          */
        fromViewController.view.transform = CGAffineTransformMakeTranslation(0, 0);
        toViewController.view.transform = CGAffineTransformMakeTranslation( 0, 0);
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];

        fromViewController.view.layer.shadowRadius = 0;
        fromViewController.view.layer.shadowOffset = CGSizeMake(0, 0);
    }];
}

@end
