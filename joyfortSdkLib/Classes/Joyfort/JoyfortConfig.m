//
//  JoyfortConfig.m
//  Test
//
//  Created by godfery on 15/6/25.
//  Copyright (c) 2015年 joyfort. All rights reserved.
//

#import <Foundation/Foundation.h>
//
//  Constants.h
//  HelloWorld
//

//声明常量
//export global constants

//export global constants

NSString *const KEY_USER_NAME = @"user_name";

const int RETRY_COUNT = 3;


NSString *const SECRET = @"eish4i*(kedjkgrefdwk23-893";
NSString *const LOGIN_URL = @"http://50.22.62.67/game/sdk/login.php";

NSString *const CREATE_USER = @"http://50.22.62.67/game/sdk/create_user.php";

NSString *const LOGIN_TOKEN_URL = @"http://50.22.62.67/game/sdk/loginToken.php";

NSString *const PAY_URL = @"http://50.22.62.67/payment/sdk/sdk.php";

NSString *const IOS_PAY_URL = @"http://50.22.62.67/payment/sdk/ios_sdk.php";

NSString *const SERVERLIST_URL = @"http://50.22.62.67/game/sdk/server.php";


NSString *const IS_BIND_URL = @"http://50.22.62.67/game/sdk/is_bind.php";

NSString *const BIND_URL = @"http://50.22.62.67/game/sdk/binded.php";

NSString *const PLAY_LOG_URL = @"http://50.22.62.67/game/sdk/playlog.php";

NSString *const VERSION_CHECK_URL = @"http://50.22.62.67/game/sdk/version_check.php";
//参数配置读取
NSString *const PARAM_URL = @"http://50.22.62.67/game/sdk/param.php";
//mycard auth code
NSString *const MYCARD_AUTHCODE = @"http://50.22.62.67/payment/sdk/mycard/sdk_auth.php";

NSString *const MYCARD_PAY_URL = @"http://50.22.62.67/payment/sdk/mycard/pay.php";

NSString *const PAYPAL_PAY_URL = @"http://50.22.62.67/payment/sdk/paypal/pay.php";

//---------cache
NSString *const BIND_CACHE_URL = @"http://50.22.62.67/game/sdk/binded_cache.php";
NSString *const  LOGIN_CACHE_URL = @"http://50.22.62.67/game/sdk/login_cache.php";
NSString *const  REVOKE_BIND_CACHE_URL = @"http://50.22.62.67/game/sdk/remove_bind_cache.php";

NSString *const  IS_BIND_CACHE_URL = @"http://50.22.62.67/game/sdk/is_bind_cache.php";

NSString *const CREATE_USER_CACHE = @"http://50.22.62.67/game/sdk/create_user_cache.php";
NSString *const SWITCH_LOGIN_URL = @"http://50.22.62.67/game/sdk/switch_login_cache.php";
//----------update

//NSString *const  SWITCH_LOGIN_URL_UPDATE = @"http://50.22.62.67/server/sdk/switch_login_cache_u.php";
//NSString *const  IS_BIND_CACHE_URL_UPDATE = @"http://50.22.62.67/server/sdk/is_bind_cache_u.php";
//NSString *const  REVOKE_BIND_CACHE_URL_UPDATE = @"http://50.22.62.67/server/sdk/remove_bind_cache_u.php";
//NSString *const  BIND_CACHE_URL_UPDATE = @"http://50.22.62.67/server/sdk/binded_cache_u.php";
//NSString *const  CREATE_USER_CACHE_UPDATE = @"http://50.22.62.67/server/sdk/create_user_cache.php";



//ios openid replace

NSString *const  LOGIN_CACHE_URL_IOS = @"http://sdk.lefou666.com/login/r.json";

NSString *const  SWITCH_LOGIN_URL_UPDATE_IOS = @"http://50.22.62.67/server/sdk/switch_login_cache_u_ios.php";
NSString *const  IS_BIND_CACHE_URL_UPDATE_IOS = @"http://50.22.62.67/server/sdk/is_bind_cache_u_ios.php";
NSString *const  REVOKE_BIND_CACHE_URL_UPDATE_IOS = @"http://50.22.62.67/server/sdk/remove_bind_cache_u_ios.php";
NSString *const  BIND_CACHE_URL_UPDATE_IOS = @"http://50.22.62.67/server/sdk/binded_cache_u_ios.php";
NSString *const  CREATE_USER_CACHE_UPDATE_IOS = @"http://50.22.62.67/server/sdk/create_user_cache_ios.php";


//----------

NSString *const JOYFORT_LOGIN_CACHE_KEY = @"joyfort_login_cache_key" ;

NSString *const JOYFORT_SHARE_KEY = @"joyfort_share_key";

NSString *const  JOYFORT_SHARE_UID =  @"joyfort_share_uid";

NSString *const  JOYFORT_SHARE_TOKEN = @"joyfort_share_token";

NSString *const JOYFORT_SHARE_USER_JSON =  @"joyfort_share_user_json";


NSString *const JOYFORT_SYNC_DNS_URL =  @"https://www.joyfort.com/server/url/mapper.php";
NSString *const JOYFORT_SYNC_IP_URL =  @"https://www.joyfort.com/server/url/ipmapper.php";
NSTimeInterval  JOYFORT_SYNC_IP_TIME_INTERVAL =  30;




