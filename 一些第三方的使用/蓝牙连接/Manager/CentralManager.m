//
//  CentralManager.m
//  一些第三方的使用
//
//  Created by ZCc on 2019/4/15.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "CentralManager.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface CentralManager ()<CBCentralManagerDelegate, CBPeripheralDelegate>
@property (nonatomic, strong) CBCentralManager *cMgr; /**< 中心管理者 */
@property (nonatomic, strong) CBPeripheral *peripheral; /**< 连接到的外设 */
@property (nonatomic, strong) NSMutableArray *peripheralArrayM; /**< 外围设备数组array */
@end

@implementation CentralManager

+ (CentralManager *)shareCentralManager {
    static CentralManager *shareCentralManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareCentralManager = [[CentralManager alloc] init];
    });
    return shareCentralManager;
}

- (void)startSearch {
    
    [self cMgr]; /**< 初始化 */
}

- (CBCentralManager *)cMgr {
    if (!_cMgr) {
        _cMgr = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return _cMgr;
}

//只要中心管理者初始化 就会触发此代理方法 判断手机蓝牙状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case 0:
            NSLog(@"CBManagerStateUnknown");
            break;
        case 1:
            NSLog(@"CBCentralManagerStateResetting");
            break;
        case 2:
            NSLog(@"CBCentralManagerStateUnsupported"); /**< 不支持蓝牙 */
            break;
        case 3:
            NSLog(@"CBManagerStateUnauthorized");
            break;
        case 4:
            NSLog(@"CBManagerStatePoweredOff"); /**< 蓝牙未开启 */
            break;
        case 5: {
            NSLog(@"CBManagerStatePoweredOn"); /**< 蓝牙已开启 */
            //在中心管理者成功开启后在进行一些操作
            //搜索外设
            [self.cMgr scanForPeripheralsWithServices:nil options:nil]; /**< 通过某些服务筛选外设 */
            // 搜索成功后 会调到外设的代理方法 - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI; //找到外设
        }
            break;
        
        default:
            break;
    }
    /*
     CBManagerStateUnknown = 0,
     CBManagerStateResetting,
     CBManagerStateUnsupported,
     CBManagerStateUnauthorized,
     CBManagerStatePoweredOff,
     CBManagerStatePoweredOn,
     */
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    //NSLog(@"%s, line = %d, cetral = %@,peripheral = %@, advertisementData = %@, RSSI = %@", __FUNCTION__, __LINE__, central, peripheral, advertisementData, RSSI);
    
    /*
     peripheral = <CBPeripheral: 0x166668f0 identifier = C69010E7-EB75-E078-FFB4-421B4B951341, Name = "OBand-75", state = disconnected>, advertisementData = {
     kCBAdvDataChannel = 38;
     kCBAdvDataIsConnectable = 1;
     kCBAdvDataLocalName = OBand;
     kCBAdvDataManufacturerData = <4c69616e 0e060678 a5043853 75>;
     kCBAdvDataServiceUUIDs =     (
     FEE7
     );
     kCBAdvDataTxPowerLevel = 0;
     }, RSSI = -55
     根据打印结果,我们可以得到运动手环它的名字叫 OBand-75
     */
    
    // 需要对连接到的外设进行过滤
    // 1.信号强度(40以上才连接, 80以上连接)
    // 2.通过设备名(设备字符串前缀是 OBand)
    // 在此时我们的过滤规则是:有OBand前缀并且信号强度大于35
    // 通过打印,我们知道RSSI一般是带-的
//    peripheral
    if (self.peripheralArrayM.count > 0) {
        BOOL isContact = NO;
        for (CBPeripheral *per in self.peripheralArrayM) {
            if ([peripheral.identifier.UUIDString isEqualToString:per.identifier.UUIDString]) {
                isContact = YES;
            }
        }
        if (!isContact) {
            [self.peripheralArrayM addObject:peripheral];
            if ([self.delegate respondsToSelector:@selector(searchedPeripheralDevices:)]) {
                [self.delegate searchedPeripheralDevices:self.peripheralArrayM];
            }
        }
    } else {
        [self.peripheralArrayM addObject:peripheral];
        if ([self.delegate respondsToSelector:@selector(searchedPeripheralDevices:)]) {
            [self.delegate searchedPeripheralDevices:self.peripheralArrayM];
        }
    }
}

#pragma mark - Getter
- (NSMutableArray *)peripheralArrayM {
    if (!_peripheralArrayM) {
        _peripheralArrayM = [NSMutableArray array];
    }
    return _peripheralArrayM;
}

@end
