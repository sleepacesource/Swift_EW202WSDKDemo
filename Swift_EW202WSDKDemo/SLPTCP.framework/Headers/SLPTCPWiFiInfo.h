//
//  SLPTCPWiFiInfo.h
//  SDK
//
//  Created by San on 27/10/2022.
//  Copyright © 2022 Martin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLPTCPWiFiInfo : NSObject

@property (nonatomic,copy)  NSString *deviceID;//设备ID UTF-8 带结束符( 例: "qiwueiuqwyeui" )
@property (nonatomic,assign) ushort  deviceType;
@property (nonatomic, assign) NSInteger signalStrength;//信号强度1-4


@end

NS_ASSUME_NONNULL_END
