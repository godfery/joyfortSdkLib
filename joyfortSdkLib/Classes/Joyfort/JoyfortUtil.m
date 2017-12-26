//
//  JoyfortUtil.m
//  Test
//
//  Created by godfery on 15/6/26.
//  Copyright (c) 2015年 joyfort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JoyfortUtil.h"
#import "JoyfortConfig.h"

@implementation JoyfortUtil
+(NSString*) trim:(NSString*)str{
    
    return   [str stringByTrimmingCharactersInSet:
              [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
}
+(BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
+(void)initJoyfortCookie{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:JOYFORT_SHARE_KEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:JOYFORT_SHARE_TOKEN];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:JOYFORT_SHARE_UID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:JOYFORT_SHARE_USER_JSON];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(BOOL)validateLoginCookieIsExist{
    
    NSLog(@"%@,%@",[[NSUserDefaults standardUserDefaults] objectForKey:JOYFORT_SHARE_TOKEN],
          [[NSUserDefaults standardUserDefaults] objectForKey:JOYFORT_SHARE_UID]);
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:JOYFORT_SHARE_TOKEN]!=nil &&
       [[NSUserDefaults standardUserDefaults] objectForKey:JOYFORT_SHARE_UID]!=nil)
    {
        return YES;
    }
    return NO;
    
}
+(void)setLocalCookie:(NSString*)key value:(NSString *)value{
    
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(NSString*)getLocalCookie:(NSString*)key{
    
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
}



+(NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    
    NSString *re =  [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                     result[0], result[1], result[2], result[3],
                     result[4], result[5], result[6], result[7],
                     result[8], result[9], result[10], result[11],
                     result[12], result[13], result[14], result[15]
                     ];
    
    return [re lowercaseString];
}



+(NSString*)getLocal:(NSString*)key{
    
    NSString *langID        = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    NSLog(@"preferredLanguage: %@", langID);
    NSDictionary* en = @{@"language_lable_username":@"username",@"language_lable_password":@"password",
                         @"language_lable_confirm_password":@"confirm password",
                         @"language_button_login":@"login",
                         @"language_button_return":@"return",
                         @"language_button_reg":@"reg",
                         @"language_button_exit":@"exit",
                         @"language_button_cancel":@"cancel",
                         @"language_button_ok":@"ok",
                         @"language_message_tishi":@"confirm",
                         @"language_message_reg_success":@"success",
                         @"language_message_login_username_or_password_empty":@"Please ensure all fields have been completed.",
                         @"language_message_two_password_nosame":@"两次输入的密码不一致",
                         @"language_user_or_pwd_error":@"用户名或密码错误!",
                         @"language_login_success":@"登录成功!欢迎您,%@",
                         @"language_login_fail":@"登录失败",
                         @"status_error":@"Wrong sdk communication",
                         @"status_1":@"Success",
                         @"status_100":@"Successful binding",
                         @"status_101":@"Unsuccessful verify token",
                         @"status_102":@"Wrong verify time",
                         @"status_103":@"Inexistent username",
                         @"status_104":@"Used device ID",
                         @"status_105":@"Wrong data",
                         @"status_106":@"Wrong username or password",
                         @"status_107":@"Linked username",                         };
    
    
    //NSArray* supportLang = [NSArray arrayWithObjects:@"en",@"zh-Hans" ,nil];
    NSArray* supportLang = [NSArray arrayWithObjects:@"en" ,nil];
    
    NSDictionary* langReferce = @{@"en":en};
    
    
    
    if(![supportLang containsObject :langID]) {
        langID = @"en";
    }
    
    
    
    NSLog(@"%@",[[langReferce objectForKey:langID] objectForKey:key]);
    
    return [[langReferce objectForKey:langID] objectForKey:key];
}
+(NSDictionary*) getADConfigInfo{
    
    NSDictionary * ff = [[NSBundle mainBundle]infoDictionary];
    NSLog(@"%@",ff);

    
    NSDictionary *config = [NSDictionary init] ;
    
    [config setValue:[ff objectForKey:@"CHARTBOOST_APP_ID"] forKey:@"CHARTBOOST_APP_ID"];
    
    
    
    
    return config;
    
}
@end