#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "JoyfortCache.h"
#import "JoyfortConfig.h"
#import "JoyfortConfigIp.h"
#import "JoyfortParam.h"
#import "JoyfortUtil.h"
#import "PayParam.h"

FOUNDATION_EXPORT double joyfortSdkLibVersionNumber;
FOUNDATION_EXPORT const unsigned char joyfortSdkLibVersionString[];

