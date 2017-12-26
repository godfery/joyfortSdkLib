//
//  PayParam.m
//  JoyfortIosSDK
//
//  Created by godfery on 15/8/11.
//  Copyright (c) 2015年 joyfort. All rights reserved.
//


#import "PayParam.h"

@implementation PayParam

static  PayParam* sharedSingleton = nil;

+(PayParam *)getInstance
{
    if (sharedSingleton == nil) {
        sharedSingleton = [[PayParam alloc] init];
    }
    return sharedSingleton;
}



@end