//
//  BaseNavigationViewController.m
//  一些第三方的使用
//
//  Created by 章程程 on 2019/2/12.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "NavigationInteractiveTransition.h"
#import <objc/runtime.h>
@interface BaseNavigationViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) NavigationInteractiveTransition *navT;

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    
//    NSLog(@"%@", gesture);
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popRecognizer];
    
    NSLog(@"%@", self.interactivePopGestureRecognizer.delegate);
    
#if USE_PlanA
     //方案1
     _navT = [[NavigationInteractiveTransition alloc] initWithViewController:self];
     [popRecognizer addTarget:_navT action:@selector(handleControllerPop:)];
    
#elif USE_PlanB
    //方案2
    //获取系统原生 右滑手势对象的key值 和 调用方法
//    unsigned int count = 0;
//    Ivar *var = class_copyIvarList([UIGestureRecognizer class], &count);
//
//    for (int i = 0; i < count + 1; i ++) {
//        Ivar _var = *(var + i);
//        NSLog(@"%s", ivar_getTypeEncoding(_var));
//        NSLog(@"%s", ivar_getName(_var));
//    }
    
    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
//    NSLog(@"%@", _targets);
//    NSLog(@"%@", _targets[0]);
    
    id gestureRecognizerTarget = _targets.firstObject;
    
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    
    //target
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
    
    [popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];
#endif
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
     /// 这里有两个条件不允许手势执行 1.当前控制器为根控制器； 2.如果这个push pop 动画正在执行 （私有属性）
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}

@end
