//
//  PayParam.h
//  JoyfortIosSDK
//
//  Created by godfery on 15/8/11.
//  Copyright (c) 2015年 joyfort. All rights reserved.
//

#ifndef JoyfortIosSDK_PayParam_h
#define JoyfortIosSDK_PayParam_h


#endif
#import <Foundation/Foundation.h>

@interface PayParam : NSObject

+ (PayParam *) getInstance;

@property (nonatomic,assign) NSString* role_name;
@property (nonatomic,assign) NSString*jf_sid;
@property (nonatomic,assign) NSString*jf_uid;
@property (nonatomic,assign) NSString*extraData;




@end