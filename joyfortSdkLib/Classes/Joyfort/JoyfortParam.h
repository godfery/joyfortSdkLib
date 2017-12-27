//
//  JoyfortParam.h
//  Test
//
//  Created by godfery on 15/6/25.
//  Copyright (c) 2015年 joyfort. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface JoyfortParam : NSObject

+(void)setSid:(NSString*)sidStr;
+(NSString*)getSid;

+(void)setVersion:(NSString*)versionStr;
+(NSString*)getVersion;


+(void)setCode:(NSString*)codeStr;
+(NSString*)getCode;

+(void)setDeviceId:(NSString*)deviceIdStr;

+(NSString*)getDeviceId;

+(void)setExtendDeviceId:(NSString*)deviceIdStr;

+(NSString*)getExtendDeviceId;

+(void)setRoleName:(NSString*)role;

+(NSString*)getRoleName;

+(void)setExtraData:(NSString*)data;

+(NSString*)getExtraData;


+(void)setJfUid:(NSString*)uid;

+(NSString*)getJfUid;


+(void)setFacebook:(NSString*)id;

+(NSString*)getFacebook;

+(void)setT:(NSString*)id;

+(NSString*)getT;

+(void)setAccessToken:(NSString*)id;

+(NSString*)getAccessToken;

+(void) parseLoginJson:(NSString*)s;

//得到时间戳
+(int)getTimeStamp;



@end
