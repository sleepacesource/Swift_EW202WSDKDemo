//
//  SLPLTcpDef.h
//  EW202W
//
//  Created by Michael on 2020/5/11.
//  Copyright © 2020 Martin. All rights reserved.
//

#ifndef SLPLTcpDef_h
#define SLPLTcpDef_h



// MARK: - Device

/**
 TCP长连接断开了
 */
#define kNotificationNameLTCPDisconnected @"kNotificationNameLTCPDisconnected"
/**
 长连接连接上
 */
#define kNotificationNameLTCPConnected @"kNotificationNameLTCPConnected"
/**
 TCP 设备升级进度
 */
#define kNotificationNameTCPDeviceUpdateRateChanged @"kNotificationNameTCPDeviceUpdateRateChanged"
/**
 EW202W的工作状态发生了变化
 */
#define kNotificationNameEW202WWorkModeChanged @"kNotificationNameEW202WWorkModeChanged"

/**
 设备在线状态发生改变
 */
#define kNotificationNameRequestDeviceOnlineStatusChanged @"kNotificationNameRequestDeviceOnlineStatusChanged"

/*
 设备采集状态变化
*/
#define kNotificationNameDeviceCollectStatusChanged @"kNotificationNameDeviceCollectStatusChanged"

/**
 post实时数据
 */
#define kNotificationNameWiFiDeviceRealtimeData @"kNotificationNameWiFiDeviceRealtimeData"
/**
 睡眠状态状态发生了改变
 */
#define kNotificationNameDeviceSleepStatusChanged @"kNotificationNameDeviceSleepStatusChanged"


#endif /* SLPLTcpDef_h */
