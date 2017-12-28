//
//  IOSPay.h
//  JoyfortIosSDK
//
//  Created by godfery on 15/7/2.
//  Copyright (c) 2015年 joyfort. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "JoyfortPay.h"

@interface IOSPay : NSObject<SKProductsRequestDelegate,SKPaymentTransactionObserver>

+ (IOSPay *) getInstance;



-(void)searchProductsInfo:(NSArray*)productList;
-(void)purchase:(SKProduct*)product;

-(void)doViewDidLoad;

- (void)doViewDidUnload;

@end
