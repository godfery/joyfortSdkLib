//
//  JoyfortParam.m
//  Test
//
//  Created by godfery on 15/6/25.
//  Copyright (c) 2015年 joyfort. All rights reserved.
//


#import "JoyfortParam.h"
//客户端代号
static NSString* code;
//设备ID
static NSString* deviceId;
static NSString* extendDeviceId;
//客户端版本号
static NSString* version;
//服务器ID
static NSString* sid;

static NSString* extraData;

static NSString* role_name;

static NSString* jf_uid;

static NSString* facebook;

static NSString* t;

static NSString* accessToken;

@implementation JoyfortParam

+(void)setSid:(NSString*)sidStr{
    sid = sidStr;
}
+(NSString*)getSid{
    return sid;
}

+(void)setVersion:(NSString*)versionStr{
    version= versionStr;
}
+(NSString*)getVersion{
    return version;
}

+(void)setCode:(NSString*)codeStr{
    code = codeStr;
}
+(NSString*)getCode{
    return code;
}

+(void)setDeviceId:(NSString *)deviceIdStr{
    deviceId = deviceIdStr;
}

+(NSString*)getDeviceId{
    return deviceId;
}

+(void)setExtendDeviceId:(NSString*)deviceIdStr {
    extendDeviceId = deviceIdStr;
    
}

+(NSString*)getExtendDeviceId {
    return extendDeviceId;
}


+(void)setRoleName:(NSString*)role{
    role_name = role;
}

+(NSString*)getRoleName {
    return role_name;
}

+(void)setExtraData:(NSString*)data{
    extraData = data;
}

+(NSString*)getExtraData {
    return extraData;
}

+(void)setJfUid:(NSString*)uid{
    jf_uid = uid;
}

+(NSString*)getJfUid {
    return jf_uid;
}

+(void)setFacebook:(NSString*)id {
    facebook = id;
}

+(NSString*)getFacebook {
    return facebook;
}


+(void)setT:(NSString*)id {
    t = id;
}

+(NSString*)getT {
    return t;
}

+(void)setAccessToken:(NSString*)id {
    accessToken = id;
}


+(NSString*)getAccessToken {
    return accessToken;
}

+(void) parseLoginJson:(NSString*)s {
    NSError * error;
    if ([NSJSONSerialization isValidJSONObject:s]) {
        NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:s options:NSJSONReadingMutableLeaves error:&error];
        NSInteger status = [weatherDic objectForKey:@"status"];
        if (status == 1) {
            t =[weatherDic objectForKey:@"t"];
            accessToken = [weatherDic objectForKey:@"accessToken"];
            
        }
    }
    
    
    
}

//生成时间戳
+(int)getTimeStamp{
     int timestamp = [[NSDate date] timeIntervalSince1970];
    return timestamp;
}
@end
