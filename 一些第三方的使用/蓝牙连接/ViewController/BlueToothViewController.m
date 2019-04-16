//
//  BlueToothViewController.m
//  一些第三方的使用
//
//  Created by ZCc on 2019/4/15.
//  Copyright © 2019 zcc. All rights reserved.
//

#import "BlueToothViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
//#import "CentralManager.h"
#import "VULCommon.h"
@interface BlueToothViewController ()<UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate>//CentralManagerDelegate

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *peripheralArrayM;

//@property (nonatomic, strong) CBPeripheral *peripheral; /**< 连接到的外设 */

@property (nonatomic, strong) CBCentralManager *cManager;

@end

@implementation BlueToothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
//    self.cManger = [CentralManager shareCentralManager];
//    [self.cManger startSearch];
    _cManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBManagerStateUnknown:
            NSLog(@">>>CBCentralManagerStateUnknown");
            break;
        case CBManagerStateResetting:
            NSLog(@">>>CBManagerStateResetting");
            break;
        case CBManagerStateUnsupported:
            NSLog(@">>>CBManagerStateUnsupported");
            break;
        case CBManagerStateUnauthorized:
            NSLog(@"CBManagerStateUnauthorized");
            break;
        case CBManagerStatePoweredOff:
            NSLog(@"CBManagerStatePoweredOff");
            break;
        case CBManagerStatePoweredOn:{
            NSLog(@"CBManagerStatePoweredOn");
            //开始扫描设备
            /*
             第一个参数nil就是扫描周围所有的外设，扫描到外设后会进入
             - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;
             */
            [_cManager scanForPeripheralsWithServices:nil options:nil];
        }
            
            break;
        default:
            break;
    }
}

//发现外围设备 进入这个代理
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"当扫描到设备%@", peripheral.name);
    //接下来可以连接设备
}

//- (void)searchedPeripheralDevices:(NSMutableArray *)arrayM {
//    self.peripheralArrayM = arrayM;
//    [self.tableView reloadData];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.peripheralArrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    CBPeripheral *peripheral = _peripheralArrayM[indexPath.row];
    cell.textLabel.text = peripheral.name;
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, K_NavBar_Height, VULSCREEN_WIDTH, VULSCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
