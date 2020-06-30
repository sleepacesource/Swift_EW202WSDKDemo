//
//  SLPHTTPManager.h
//  SDK
//
//  Created by Michael on 2020/5/28.
//  Copyright © 2020 Martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SLPAidInfo.h"
#import "SLPClockDormancyBean.h"
#import "SLPDataTransferDef.h"
#import "SLPAlarmInfo.h"
NS_ASSUME_NONNULL_BEGIN

#define SLPSharedHTTPManager [SLPHTTPManager sharedInstance]

@interface SLPHTTPManager : NSObject

@property (nonatomic,readonly) NSString *sid;
@property (nonatomic,readonly) NSString *urlString;
@property (nonatomic,readonly) NSString *channelID;

+(SLPHTTPManager*)sharedInstance;

/*
 *
 *初始化HTTP信息
 * @parameters 参数
 * {
 * url : @"HTTP地址,类型：String",
 * channelID : @"channelID值，类型：String"
 * }
 */
- (void)initHttpServiceInfo:(NSDictionary *)parameters;

/*
*授权
*@token
*@timeoutInterval
*@completion
*/
- (void)authorize:(NSString *)token
          timeout:(CGFloat)timeoutInterval
       completion:(void (^)(BOOL result,id responseObject, NSString *error))completion;


/*
 *获取当前设备信息
 *@param
 */
- (void)getBindedDeviceInformationWithUserID:(NSString *)userID
                                     timeout:(CGFloat)timeoutInterval
                                   completion:(void (^)(NSInteger status,id responseObject, NSString *error))completion;

/**
 *  绑定设备
 *
 */
- (void)bindDeviceWithParameters:(NSDictionary *)parameters
                                 userID:(NSString *)userID
                                timeOut:(CGFloat)timeoutInterval
                             completion:(void (^)(BOOL result, NSDictionary *dict,NSString *error))completion;

/*
 *  解绑设备
 *
 */

- (void)unBindDeviceWithParameters:(NSDictionary *)parameters
                                userID:(NSString *)userID
                               timeOut:(CGFloat)timeoutInterval
                            completion:(void (^)(BOOL result, NSString *error))completion;

/*
 *获取设备版本信息
 *@param
 */
- (void)getDeviceVersionWithParameters:(NSDictionary *)parameters
                                userID:(NSString *)userID
                               timeout:(CGFloat)timeoutInterval
                            completion:(void (^)(BOOL result,id responseObject, NSString *error))completion;

/*
 *闹钟配置
 *@param
 */
- (void)alarmConfigWithParameters:(NSDictionary *)parameters
                       deviceInfo:(NSString *)deviceName
                       deviceType:(SLPDeviceTypes)deviceType
                           userID:(NSString *)userID
                          timeOut:(CGFloat)timeout
                       completion:(void (^)(BOOL result,id responseObject, NSString *error))completion;

/*
 *时钟休眠配置
 *@param
 */
- (void)configClockDormancyWithParameters:(NSDictionary *)parameters deviceInfo:(NSString *)deviceName userID:(NSString *)userID timeOut:(CGFloat)timeout completion:(void (^)(BOOL result,id responseObject, NSString *error))completion;

/*
 *助眠配置
 *@param
 */
- (void)configAidInfoWithParameters:(NSDictionary *)parameters deviceInfo:(NSString *)deviceName userID:(NSString *)userID deviceType:(SLPDeviceTypes)deviceType  timeout:(CGFloat)timeout completion:(void (^)(BOOL result,id responseObject, NSString *error))completion;

/*
 *获取助眠配置
 *@param
 */
- (void)getAidInfoWithDeviceInfo:(NSString *)deviceName userID:(NSString *)userID timeOut:(CGFloat)timeout completion:(void (^)(BOOL result,id responseObject, NSString *error))completion;

/*
 *获取时钟休眠
 *@param
 */
- (void)getClockDormancyWithDeviceInfo:(NSString *)deviceName userID:(NSString *)userID timeOut:(CGFloat)timeout completion:(void (^)(BOOL result,id responseObject, NSString *error))completion;

/*
 *获取闹钟列表
 *@param
 */
- (void)getAlarmListWithDeviceInfo:(NSString *)deviceName userID:(NSString *)userID timeOut:(CGFloat)timeout completion:(void (^)(BOOL result,id responseObject, NSString *error))completion;



@end

NS_ASSUME_NONNULL_END
