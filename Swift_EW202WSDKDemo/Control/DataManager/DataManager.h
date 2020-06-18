//
//  DataManager.h
//  Binatone-demo
//
//  Created by Martin on 28/8/18.
//  Copyright © 2018年 Martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EW202W/EW202WAidInfo.h>
#import <EW202W/SLPLTcpUpgradeInfo.h>

#define SharedDataManager [DataManager sharedDataManager]
@class CBPeripheral;
@interface DataManager : NSObject
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, copy) NSString *deviceName;
@property (nonatomic, copy) NSString *deviceID;
@property (nonatomic, assign) BOOL inRealtime;
@property (nonatomic, assign) BOOL connected;
@property (nonatomic, strong) NSString *userID;

@property (nonatomic, assign) NSInteger selectItemsNum;

@property (nonatomic, assign) NSInteger assistMusicID;

@property (nonatomic, assign) NSInteger volumn;

@property (nonatomic, strong) EW202WAidInfo *aidInfo;

@property (nonatomic, assign) int waveAction;

@property (nonatomic, assign) int hoverAction;

@property (nonatomic, strong) NSMutableArray *alarmList;

+ (DataManager *)sharedDataManager;

- (void)toInit;

- (void)reset;

@end
