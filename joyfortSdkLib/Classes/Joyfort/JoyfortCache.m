//
//  Joyfort.m
//  Test
//
//  Created by godfery on 15/6/25.
//  Copyright (c) 2015年 joyfort. All rights reserved.
//

#ifndef JOYFORTCAHCE_IMPORT_h
#define JOYFORTCAHCE_IMPORT_h
#import "JoyfortCache.h"

#import <ASIHTTPRequest/ASIFormDataRequest.h>
#import "JoyfortParam.h"
#import "JoyfortConfig.h"
#import "JoyfortUtil.h"
//#import "LoginUI.h"

//#import "CFLogInViewController.h"
//#import "CFLoginView.h"
//#import "CFRegistView.h"
//#import "CFGetPasswordView.h"

#import "JoyfortConfigIp.h"
#import "JoyfortConfig.h"

//#import "FacebookLogin.h"

//#import <FBSDKCoreKit/FBSDKCoreKit.h>
//#import <FBSDKLoginKit/FBSDKLoginKit.h>
//#import "IpManage.h"
//#import "JoyfortIpMapping.h"
#endif
@implementation JoyfortCache

static JoyfortCache * sharedSingleton = nil;

+(JoyfortCache *)getInstance
{
    if (sharedSingleton == nil) {
        sharedSingleton = [[JoyfortCache alloc] init];
    }
    return sharedSingleton;
}



-(void)setVersion:(NSString*)versionStr{
    [JoyfortParam setVersion:versionStr];
}

-(void)setSid:(NSString*)sid{
    [JoyfortParam setSid:sid];
}

//版本检测
-(NSString*)versionCheck{
    NSLog(@"%@",@"versionCheck");
    
    ASIFormDataRequest *requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString: VERSION_CHECK_URL]];
    
    
    //设置需要POST的数据，这里提交两个数据，A=a&B=b
    
    [requestForm setPostValue:[JoyfortParam getVersion] forKey:@"client"];
    
    [requestForm setPostValue:[JoyfortParam getCode] forKey:@"code"];
    [requestForm startSynchronous];
    NSLog(@"%@",requestForm.url);
    NSString *jsonStr = nil;
    NSError * error =[requestForm error];
    if(requestForm.responseStatusCode >400  || error) {
        NSLog(@"%@", error.localizedDescription);
        
        
        ASIFormDataRequest * aff = [requestForm copy];
        
        aff.url =[NSURL URLWithString: VERSION_CHECK_URL_IP];
        
        [aff startSynchronous];
        
        jsonStr = [aff responseString];
        NSLog(@"%@",aff.url);
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    } else {
        
        jsonStr = [requestForm responseString];
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    }
    
    
    return jsonStr;
}
-(void)pingIPInit {
    NSString* syncUrl = JOYFORT_SYNC_IP_URL;
//    [[JoyfortIpMappingManager sharedInstance] startSyncTimerWithInterval:JOYFORT_SYNC_IP_TIME_INTERVAL withSrcUrl:syncUrl];
//    NSMutableArray* tt = [[NSMutableArray alloc]init];
//    //        58.68.228.171;50.22.62.67;119.81.2.166
//    
//    [tt addObject:@"50.22.62.67"];
//    [tt addObject:@"119.81.2.166"];
//    
//    //
//    [IpManage getInstance].replaceIp = @"50.22.62.67";
//    [[IpManage getInstance]init:tt];
//    [[IpManage getInstance]do];
    
    
}
-(void)initIpReplace{
    
    //    NSMutableArray* tt = [[NSMutableArray alloc]init];
    //    58.68.228.171;50.22.62.67;119.81.2.166
    //    [tt addObject:@"58.68.228.171"];
    //    [tt addObject:@"50.22.62.67"];
    //    [tt addObject:@"119.81.2.166"];
    //
    //    //
    //    [[IpManage getInstance]init:tt];
    //    [[IpManage getInstance]do];
    
    //        [self pingIPInit];
    
//    [IpManage getInstance].replaceIp = @"50.22.62.67";
//    [IpManage getInstance].voteIp = @"gslb.lefou666.com";

}
-(void)initParam:(NSString *)code deviceid: (NSString *) deviceid{
    
    [JoyfortParam setCode:code];
    [JoyfortParam setDeviceId:deviceid];
    
//    [self pingIPInit];
    
    [self initIpReplace];
    NSLog(@"%@",[JoyfortParam getDeviceId]);
    
    NSLog(@"%@",[JoyfortParam getCode]);
}


-(void)initParam:(NSString *)code deviceid: (NSString *) deviceid extendDeviceid: (NSString *) extendDeviceid {
    
    [self initParam:code deviceid:deviceid];
    [JoyfortParam setExtendDeviceId:extendDeviceid];
    

   
    [self initIpReplace];
    
    NSLog(@"%@",[JoyfortParam getDeviceId]);
    
    NSLog(@"%@",[JoyfortParam getCode]);
}



-(void)notifyBindUserResult:(NSString*)str{
    NSLog(@"bind user notify :%@",str);
    [self.delegate joyfortCacheBindUserResult:str];
}


//通知登录消息
-(void)notifyLogin:(NSString*)str{
    if(loginFlag == NO) {
        [self.delegate joyfortCacheLoginResult:str];
    } else {
        [self.delegate joyfortCacheSwitchUserResult:str];
    }
    
    
}
//记录登录的服，必须调用setSid
-(void)logPlaylog:(NSString*)uid{
    NSLog(@"%@",@"logPlaylog");
    
    ASIFormDataRequest *requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:PLAY_LOG_URL]];
    
    
    //设置需要POST的数据，这里提交两个数据，A=a&B=b
    
    [requestForm setPostValue:uid forKey:@"jf_uid"];
    [requestForm setPostValue:[JoyfortParam getSid] forKey:@"sid"];
    [requestForm setPostValue:[JoyfortParam getCode] forKey:@"code"];
    
    [requestForm startSynchronous];
    
    NSString *jsonStr = nil;
    NSError * error =[requestForm error];
    if(requestForm.responseStatusCode >400  || error) {
        NSLog(@"%@", error.localizedDescription);
        
        
        ASIFormDataRequest * aff = [requestForm copy];
        
        aff.url =[NSURL URLWithString: PLAY_LOG_URL_IP];
        
        [aff startSynchronous];
        
        jsonStr = [aff responseString];
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    } else {
        
        jsonStr = [requestForm responseString];
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    }
    
    
    
    //return jsonStr;
}

-(NSString*)servers:(NSString*)uid{
    NSLog(@"%@",@"servers");
    
    ASIFormDataRequest *requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:SERVERLIST_URL]];
    
    
    //设置需要POST的数据，这里提交两个数据，A=a&B=b
    
    [requestForm setPostValue:uid forKey:@"jf_uid"];
    [requestForm setPostValue:[JoyfortParam getCode] forKey:@"code"];
    
    [requestForm startSynchronous];
    
    NSString *jsonStr = nil;
    NSError * error =[requestForm error];
    if(requestForm.responseStatusCode >400  || error) {
        NSLog(@"%@", error.localizedDescription);
        
        
        ASIFormDataRequest * aff = [requestForm copy];
        
        aff.url =[NSURL URLWithString: SERVERLIST_URL_IP];
        
        [aff startSynchronous];
        
        jsonStr = [aff responseString];
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    } else {
        
        jsonStr = [requestForm responseString];
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    }
    
    
    return jsonStr;
    
}





-(NSString*)loginCache:(NSString*)email password:(NSString*)password{
    NSLog(@"%@",LOGIN_CACHE_URL_IP);
    
    ASIFormDataRequest *requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString: LOGIN_CACHE_URL_IOS]];
    
    NSString *timeStr = [[NSString alloc] initWithFormat:@"%d",[JoyfortParam getTimeStamp]];
    
    NSString *tokenStr=@"";
    NSLog(@"----%@",tokenStr);
    tokenStr = [tokenStr stringByAppendingString:[JoyfortParam getDeviceId]];
    NSLog(@"----%@",tokenStr);
    tokenStr = [tokenStr stringByAppendingString:timeStr];
    tokenStr = [tokenStr stringByAppendingString:SECRET];
    
    NSLog(@"----%@",tokenStr);
    
    NSString *token = [JoyfortUtil md5:tokenStr];
    NSLog(@"----token-----%@",token);
    
    //设置需要POST的数据，这里提交两个数据，A=a&B=b
    [requestForm setPostValue:[JoyfortParam getDeviceId] forKey:@"device_id"];
    [requestForm setPostValue:[JoyfortParam getVersion] forKey:@"client"];
    [requestForm setPostValue:timeStr forKey:@"time"];
    [requestForm setPostValue:[JoyfortParam getSid] forKey:@"sid"];
    [requestForm setPostValue:[JoyfortParam getCode] forKey:@"code"];
    [requestForm setPostValue:email forKey:@"email"];
    [requestForm setPostValue:password forKey:@"password"];
    [requestForm setPostValue:token forKey:@"token"];
    [requestForm setPostValue:[JoyfortParam getExtendDeviceId] forKey:@"unionid"];
    [requestForm startSynchronous];
    
    NSString *jsonStr = nil;
    NSError * error =[requestForm error];
    if(requestForm.responseStatusCode >400  || error) {
        NSLog(@"%@", error.localizedDescription);
        
        
        ASIFormDataRequest * aff = [requestForm copy];
        
        aff.url =[NSURL URLWithString: LOGIN_CACHE_URL_IP_IOS];
        
        [aff startSynchronous];
        
        jsonStr = [aff responseString];
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    } else {
        
        jsonStr = [requestForm responseString];
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    }
    
    
    return jsonStr;
    
}

-(NSString*)bindCache:(NSString*)email password:(NSString*)password flag:(NSString*)flag   uid:(NSString*)uid facebook:(NSString*)facebook{
//     BIND_CACHE_URL_UPDATE]
    ASIFormDataRequest *requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString: BIND_CACHE_URL_UPDATE_IOS]];
    
    NSString *timeStr = [[NSString alloc] initWithFormat:@"%d",[JoyfortParam getTimeStamp]];
    
    NSString *tokenStr=@"";
    NSLog(@"----%@",tokenStr);
    tokenStr = [tokenStr stringByAppendingString:email];
    tokenStr = [tokenStr stringByAppendingString:password];
    tokenStr = [tokenStr stringByAppendingString:facebook];
    NSLog(@"----%@",tokenStr);
    tokenStr = [tokenStr stringByAppendingString:timeStr];
    tokenStr = [tokenStr stringByAppendingString:SECRET];
    
    NSLog(@"----%@",tokenStr);
    
    NSString *token = [JoyfortUtil md5:tokenStr];
    NSLog(@"----token-----%@",token);
    
    //设置需要POST的数据，这里提交两个数据，A=a&B=b
    [requestForm setPostValue:email forKey:@"email"];
    [requestForm setPostValue:token forKey:@"token"];
    [requestForm setPostValue:password forKey:@"password"];
    [requestForm setPostValue:timeStr forKey:@"time"];
    [requestForm setPostValue:flag forKey:@"flag"];
    [requestForm setPostValue:uid forKey:@"uid"];
    [requestForm setPostValue:facebook forKey:@"facebook"];
    [requestForm setPostValue:[JoyfortParam getAccessToken] forKey:@"accessToken"];
    [requestForm setPostValue:[JoyfortParam getT] forKey:@"t"];
    
    
    
    [requestForm setPostValue:[JoyfortParam getCode] forKey:@"code"];
    [requestForm startSynchronous];
    
    NSString *jsonStr = nil;
    NSError * error =[requestForm error];
    if(requestForm.responseStatusCode >400  || error) {
        NSLog(@"%@", error.localizedDescription);
        
        
        ASIFormDataRequest * aff = [requestForm copy];
        
        aff.url =[NSURL URLWithString: BIND_CACHE_URL_UPDATE_IP_IOS];
        
        [aff startSynchronous];
        
        jsonStr = [aff responseString];
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    } else {
        
        jsonStr = [requestForm responseString];
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    }
    
    
    return jsonStr;
}

-(NSString*)isBindCache:(NSString*)uid {
    
   //     IS_BIND_CACHE_URL_UPDATE]
    ASIFormDataRequest *requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString: IS_BIND_CACHE_URL_UPDATE_IOS]];
    
    
    //设置需要POST的数据，这里提交两个数据，A=a&B=b
    
    [requestForm setPostValue:[JoyfortParam getDeviceId] forKey:@"device_id"];
    [requestForm setPostValue:[JoyfortParam getCode] forKey:@"code"];
    [requestForm setPostValue:uid forKey:@"uid"];
    [requestForm setPostValue:[JoyfortParam getExtendDeviceId] forKey:@"extend_device_id"];
    [requestForm startSynchronous];
    
    NSString *jsonStr = nil;
    NSError * error =[requestForm error];
    if(requestForm.responseStatusCode >400  || error) {
        NSLog(@"%@", error.localizedDescription);
        
        
        ASIFormDataRequest * aff = [requestForm copy];
        
        aff.url =[NSURL URLWithString: IS_BIND_CACHE_URL_UPDATE_IP_IOS];
        
        [aff startSynchronous];
        
        jsonStr = [aff responseString];
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    } else {
        
        jsonStr = [requestForm responseString];
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    }
    
    
    return jsonStr;
    
}
-(NSString*)revokeBindCache:(NSString*)uid loginFlag:(NSString*)flag {
    
//     REVOKE_BIND_CACHE_URL_UPDATE]
    ASIFormDataRequest *requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString: REVOKE_BIND_CACHE_URL_UPDATE_IOS]];
    
    
    //设置需要POST的数据，这里提交两个数据，A=a&B=b
    
    [requestForm setPostValue:[JoyfortParam getDeviceId] forKey:@"device_id"];
    [requestForm setPostValue:[JoyfortParam getCode] forKey:@"code"];
    [requestForm setPostValue:uid forKey:@"uid"];
    [requestForm setPostValue:flag forKey:@"loginFlag"];
    [requestForm setPostValue:[JoyfortParam getExtendDeviceId] forKey:@"extend_device_id"];
    [requestForm setPostValue:[JoyfortParam getAccessToken] forKey:@"accessToken"];
    [requestForm setPostValue:[JoyfortParam getT] forKey:@"t"];

    
    
    [requestForm startSynchronous];
    
    NSString *jsonStr = nil;
    NSError * error =[requestForm error];
    if(requestForm.responseStatusCode >400  || error) {
        NSLog(@"%@", error.localizedDescription);
        
        
        ASIFormDataRequest * aff = [requestForm copy];
        
        aff.url =[NSURL URLWithString: REVOKE_BIND_CACHE_URL_UPDATE_IP_IOS];
        
        [aff startSynchronous];
        
        jsonStr = [aff responseString];
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    } else {
        
        jsonStr = [requestForm responseString];
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    }
    
    
    return jsonStr;
    
}
-(void)facebookLogin:(NSString*)facebookId {
    
    
    
    //[[Joyfort getInstance]facebookLogin:facebookId];
    
//    [UIApplication sharedApplication];
//    [FBSDKSettings setAppID:facebookId];
//    
//
//    
//    //[self.delegate loginResult:[FBSDKSettings appID]];
//    
//    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
//    [loginManager logOut];
//    [loginManager logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//        if (error) {
//            // Process error
//            NSLog(@"facebook----error----%@",error.description);
//            
////            [[ThirdLogin getInstance] notify:@""];
//            [[JoyfortCache getInstance].delegate  joyfortCacheLoginResult:@""];
//        } else if (result.isCancelled) {
//            NSLog(@"facebook----error----%@",@"user cancel");
//            // Handle cancellations
////            [[ThirdLogin getInstance] notify:@""];
//            [[JoyfortCache getInstance].delegate  joyfortCacheLoginResult:@""];
//        } else {
//            // If you ask for multiple permissions at once, you
//            // should check if specific permissions missing
//            
//            
//            
//            if ([result.grantedPermissions containsObject:@"email"]) {
//                // Do work
//                
//                NSDictionary *dic = @{@"fields":@"id,name,email"};
//                
//                FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
//                                              initWithGraphPath:@"/me"
//                                              parameters:dic
//                                              HTTPMethod:@"GET"];
//                [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
//                                                      id result,
//                                                      NSError *error) {
//                    
//                    if(!error) {
//                        NSLog(@"fetched user:%@",result);
//                        NSDictionary *json = result;
//                        //                        NSError *error = nil;
//                        //                        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableLeaves error:&error];
//                        //                        NSLog(@"%@",[json objectForKey:@"email"]);
//                        //
//                        //
//                        
//                        NSString *email = [json objectForKey:@"email"];
//                        NSString *fbId = [json objectForKey:@"id"];
////                        [[ThirdLogin getInstance] notify:email];
//                        [[JoyfortCache getInstance].delegate  joyfortCacheLoginResult:fbId];
//                        
//                        NSLog(@"facebook---%@",email);
//                         NSLog(@"facebook---%@",fbId);
//                        
//                        
//                        
//                        
//                    } else {
//                        NSLog(@"%@",error.description);
//
//                        [[JoyfortCache getInstance].delegate  joyfortCacheLoginResult:@""];
//                    }
//                    // Handle the result
//                }];
//                
//            }
//        }
//    }];
    
}

-(NSString*)createUserCache:(NSString*)email password:(NSString*)password{
    NSLog(@"%@",LOGIN_TOKEN_URL);
    //     CREATE_USER_CACHE_UPDATE]
    ASIFormDataRequest *requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString: CREATE_USER_CACHE_UPDATE_IOS]];
    
    NSString *timeStr = [[NSString alloc] initWithFormat:@"%d",[JoyfortParam getTimeStamp]];
    
    NSString *tokenStr=@"";
    NSLog(@"----%@",tokenStr);
    tokenStr = [tokenStr stringByAppendingString:[JoyfortParam getDeviceId]];
    NSLog(@"----%@",tokenStr);
    tokenStr = [tokenStr stringByAppendingString:timeStr];
    tokenStr = [tokenStr stringByAppendingString:SECRET];
    
    NSLog(@"----%@",tokenStr);
    
    NSString *token = [JoyfortUtil md5:tokenStr];
    NSLog(@"----token-----%@",token);
    
    //设置需要POST的数据，这里提交两个数据，A=a&B=b
    [requestForm setPostValue:[JoyfortParam getDeviceId] forKey:@"device_id"];
    [requestForm setPostValue:[JoyfortParam getVersion] forKey:@"client"];
    [requestForm setPostValue:timeStr forKey:@"time"];
    [requestForm setPostValue:[JoyfortParam getSid] forKey:@"sid"];
    [requestForm setPostValue:[JoyfortParam getCode] forKey:@"code"];
    [requestForm setPostValue:email forKey:@"email"];
    [requestForm setPostValue:password forKey:@"password"];
    [requestForm setPostValue:token forKey:@"token"];
    [requestForm setPostValue:[JoyfortParam getExtendDeviceId] forKey:@"extend_device_id"];
    [requestForm setPostValue:[JoyfortParam getAccessToken] forKey:@"accessToken"];
    [requestForm setPostValue:[JoyfortParam getT] forKey:@"t"];

    
    [requestForm startSynchronous];
    
    NSString *jsonStr = nil;
    NSError * error =[requestForm error];
    if(requestForm.responseStatusCode >400  || error) {
        NSLog(@"%@", error.localizedDescription);
        
        
        ASIFormDataRequest * aff = [requestForm copy];
        
        aff.url =[NSURL URLWithString: CREATE_USER_CACHE_UPDATE_IP_IOS];
        
        [aff startSynchronous];
        
        jsonStr = [aff responseString];
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    } else {
        
        jsonStr = [requestForm responseString];
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    }
    
    
    return jsonStr;
}

-(NSString*)switchUserLogin:(NSString*)email password:(NSString*)password uid:(NSString*)uid facebook:(NSString*)facebook flag:(NSString*) flag{
    
//     SWITCH_LOGIN_URL_UPDATE]
    ASIFormDataRequest *requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString: SWITCH_LOGIN_URL_UPDATE_IOS]];
    
    NSString *timeStr = [[NSString alloc] initWithFormat:@"%d",[JoyfortParam getTimeStamp]];
    
    NSString *tokenStr=@"";
    NSLog(@"----%@",tokenStr);
    tokenStr = [tokenStr stringByAppendingString:email];
    tokenStr = [tokenStr stringByAppendingString:password];
    tokenStr = [tokenStr stringByAppendingString:facebook];
    NSLog(@"----%@",tokenStr);
    tokenStr = [tokenStr stringByAppendingString:timeStr];
    tokenStr = [tokenStr stringByAppendingString:SECRET];
    
    NSLog(@"----%@",tokenStr);
    
    NSString *token = [JoyfortUtil md5:tokenStr];
    NSLog(@"----token-----%@",token);
    
    //设置需要POST的数据，这里提交两个数据，A=a&B=b
    [requestForm setPostValue:email forKey:@"email"];
    [requestForm setPostValue:token forKey:@"token"];
    [requestForm setPostValue:password forKey:@"password"];
    [requestForm setPostValue:timeStr forKey:@"time"];
    [requestForm setPostValue:[JoyfortParam getDeviceId] forKey:@"device_id"];
    [requestForm setPostValue:uid forKey:@"uid"];
    [requestForm setPostValue:facebook forKey:@"facebook"];
    
    [requestForm setPostValue:[JoyfortParam getExtendDeviceId] forKey:@"extend_device_id"];
    [requestForm setPostValue:[JoyfortParam getCode] forKey:@"code"];
    [requestForm setPostValue:flag forKey:@"flag"];
    
    [requestForm setPostValue:[JoyfortParam getAccessToken] forKey:@"accessToken"];
    [requestForm setPostValue:[JoyfortParam getT] forKey:@"t"];

    
    
    [requestForm startSynchronous];
    
    NSString *jsonStr = nil;
    NSError * error =[requestForm error];
    if(requestForm.responseStatusCode >400  || error) {
        NSLog(@"%@", error.localizedDescription);
        
        
        ASIFormDataRequest * aff = [requestForm copy];
        
        aff.url =[NSURL URLWithString: SWITCH_LOGIN_URL_UPDATE_IP_IOS];
        
        [aff startSynchronous];
        
        jsonStr = [aff responseString];
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    } else {
        
        jsonStr = [requestForm responseString];
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    }
    
    
    return jsonStr;
}



@end
