//
//  JoyfortPay.h
//  JoyfortIosSDK
//
//  Created by godfery on 15/7/1.
//  Copyright (c) 2015年 joyfort. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol PayDelegate  <NSObject>
@required//这个可以是required，也可以是optional




-(void)payResult:(NSString*)str;

@optional

-(void)productListResult:(NSArray*)info;

@end

@interface JoyfortPay : NSObject

+ (JoyfortPay *) getInstance;

@property (nonatomic, assign) id<PayDelegate> delegate;
//1 search product info 2 pay
@property (nonatomic,assign) NSInteger payFlag;
//@property (nonatomic,assign) NSString* role_name;
//@property (nonatomic,assign) NSString* jf_sid;
//@property (nonatomic,assign) NSString* jf_uid;
//@property (nonatomic,assign) NSString* extraData;
@property (nonatomic,assign) NSString*receipt;

-(void)setRoleName:(NSString*)roleName;

-(void)setExtraData:(NSString *)extraData;

-(void)setJfUid:(NSString*)jf_uid;

-(void)purchase:(NSString*)productId extraData:(NSString*)extraData;

-(void)purchase:(NSString*)productId;

-(NSString*)pay:(NSString*)role_name  jf_sid:(NSString*)jf_sid jf_uid:(NSString*)jf_uid extraData:(NSString*)extraData receipt:(NSString*)receipt;

-(NSString*)pay:(NSString*)receipt;


-(void)sendPayResult:(NSString*)content;

-(void)queryProductLists:(NSArray*)productLists;

-(void)getProductInfo:(NSArray*)productLists;

-(void)sendProductInfo:(NSArray*)productLists;

-(void)doViewDidLoad;

- (void)doViewDidUnload;

@end
