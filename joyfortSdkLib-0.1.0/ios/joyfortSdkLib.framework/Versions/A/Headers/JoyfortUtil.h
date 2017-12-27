//
//  JoyfortUtil.h
//  Test
//
//  Created by godfery on 15/6/26.
//  Copyright (c) 2015年 joyfort. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>

@interface JoyfortUtil : NSObject

+(NSString *) md5:(NSString *)str;


+(NSString*)getLocal:(NSString*)key;



+(void)initJoyfortCookie;

+(void)setLocalCookie:(NSString*)key value:(NSString*)value;

+(NSString*)getLocalCookie:(NSString*)key;

+(BOOL)validateLoginCookieIsExist;

+(BOOL) isBlankString:(NSString *)string;

+(NSString*) trim:(NSString*)str;


+(NSDictionary*) getADConfigInfo;


@end
