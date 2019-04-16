//
//  CentralManager.h
//  一些第三方的使用
//
//  Created by ZCc on 2019/4/15.
//  Copyright © 2019 zcc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CentralManagerDelegate <NSObject>

- (void)searchedPeripheralDevices:(NSMutableArray *)arrayM;

@end

@interface CentralManager : NSObject

@property (nonatomic, weak) id<CentralManagerDelegate>delegate;

+ (CentralManager *)shareCentralManager;

- (void)startSearch;

@end

NS_ASSUME_NONNULL_END
