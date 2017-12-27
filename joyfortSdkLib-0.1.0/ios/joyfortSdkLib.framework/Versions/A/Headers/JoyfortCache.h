//
//  Joyfort.h
//  Test
//
//  Created by godfery on 15/6/25.
//  Copyright (c) 2015年 joyfort. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol LoginDelegate  <NSObject>
//@required//这个可以是required，也可以是optional

@optional


-(void)joyfortCacheLoginResult:(NSString*)str;

-(void)joyfortCacheSwitchUserResult:(NSString*)str;

-(void)joyfortCacheBindUserResult:(NSString*)str;

-(void)joyfortCachePushToken:(NSString*)str;




@end

@interface JoyfortCache : NSObject
{
@private
    NSString* bindUid;
    BOOL loginFlag ;
}


@property (nonatomic, assign) id<LoginDelegate> delegate;

@property(nonatomic,retain) id clientView;




+ (JoyfortCache *) getInstance;






-(void)initParam:(NSString *)code deviceid: (NSString *) deviceid;

-(void)initParam:(NSString *)code deviceid: (NSString *) deviceid extendDeviceid: (NSString *) extendDeviceid ;

-(void)setVersion:(NSString*)versionStr;

-(void)setSid:(NSString*)sid;





                   
                   



//版本检测
-(NSString*)versionCheck;


//登陆



//记录登录的服，必须调用setSid
-(void)logPlaylog:(NSString*)uid;

-(NSString*)servers:(NSString*)uid;



-(void)notifyLogin:(NSString*)str;
-(void)notifyBindUserResult:(NSString*)str;

//---------cache start

-(NSString*)loginCache:(NSString*)email password:(NSString*)password;
//-(NSString*)loginCache:(NSString*)sid  email:(NSString*)email password:(NSString*)password;

-(NSString*)bindCache:(NSString*)email password:(NSString*)password flag:(NSString*)flag uid:(NSString*)uid facebook:(NSString*)facebook;

-(NSString*)switchUserLogin:(NSString*)email password:(NSString*)password uid:(NSString*)uid facebook:(NSString*)facebook flag:(NSString*) flag;

-(NSString*)isBindCache:(NSString*)uid;
-(NSString*)revokeBindCache:(NSString*)uid loginFlag:(NSString*)flag;

-(NSString*)createUserCache:(NSString*)email password:(NSString*)password;

-(void)facebookLogin:(NSString*)facebookId;


//---------cache end

@end

