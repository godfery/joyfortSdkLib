//
//  JoyfortPay.m
//  JoyfortIosSDK
//
//  Created by godfery on 15/7/1.
//  Copyright (c) 2015年 joyfort. All rights reserved.
//

#ifndef Test_JoyfortConfig_h_import
#define Test_JoyfortConfig_h_import

#import "JoyfortPay.h"
//#import "ASIFormDataRequest.h"
#import <ASIHTTPRequest/ASIFormDataRequest.h>
#import "JoyfortParam.h"
#import "JoyfortConfigIp.h"
#import "JoyfortConfig.h"
#import "JoyfortUtil.h"
#import <StoreKit/StoreKit.h>

#import "IOSPay.h"

#endif

@implementation JoyfortPay

static JoyfortPay * sharedSingleton = nil;

+(JoyfortPay *)getInstance
{
    if (sharedSingleton == nil) {
        sharedSingleton = [[JoyfortPay alloc] init];
    }
    return sharedSingleton;
}
-(void)setRoleName:(NSString*)roleName {
    [JoyfortParam setRoleName:roleName];
}


-(void)setExtraData:(NSString *)extraData {
    [JoyfortParam setExtraData:extraData];
}

-(void)setJfUid:(NSString*)jf_uid {
    [JoyfortParam setJfUid:jf_uid];
}

-(void)doViewDidLoad{

    [[IOSPay getInstance]doViewDidLoad];
}

- (void)doViewDidUnload{
    [[IOSPay getInstance]doViewDidUnload];

}

-(void)sendPayResult:(NSString*)content{
    
    [self.delegate payResult:content];
}
-(void)queryProductLists:(NSArray*)productLists{
    NSLog(@"queryProductLists");
    self.payFlag = 1;
    [[IOSPay getInstance]doViewDidLoad];
    [self getProductInfo:productLists];
}
-(void)getProductInfo:(NSArray *)productLists{
    NSLog(@"getProductInfo------%@",productLists);
   
    [[IOSPay getInstance]searchProductsInfo:productLists];
    
}

-(void)sendProductInfo:(NSArray *)productLists{
    NSLog(@"%@",productLists);
    SKProduct * product = productLists[0];
    
    
    NSLog(@"%@",product.price);
    
    NSLog(@"%@",product.localizedDescription);
    
    NSLog(@"%ld",(long)self.payFlag);
    if (self.payFlag == 1) {
        [self.delegate productListResult:productLists];
    } else if (self.payFlag == 2) {
                 

        [[IOSPay getInstance]purchase:product];

    }
    
    
}


-(void)purchase:(NSString*)productId extraData:(NSString*)extraData{
    
    NSLog(@"----purchase:%@",productId);
    self.payFlag = 2;
    NSArray * param = [NSArray arrayWithObjects:productId, nil];
    [self getProductInfo:param];
    
}
-(void)purchase:(NSString*)productId{
    
    NSLog(@"----purchase:%@",productId);
    self.payFlag = 2;
    NSArray * param = [NSArray arrayWithObjects:productId, nil];
    [self getProductInfo:param];
    
}
-(NSString*)pay:(NSString*)receipt{
    
    NSLog(@"%@",@"pay");
    
    ASIFormDataRequest *requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString: IOS_PAY_URL]];
    
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
    [requestForm setPostValue:[JoyfortParam getRoleName] forKey:@"role_name"];
    [requestForm setPostValue:@"" forKey:@"purchase_data"];
    [requestForm setPostValue:[JoyfortParam getSid] forKey:@"jf_sid"];
    
    [requestForm setPostValue:[JoyfortParam getCode] forKey:@"code"];
    [requestForm setPostValue:receipt forKey:@"receipt"];
    [requestForm setPostValue:[JoyfortParam getJfUid] forKey:@"jf_uid"];
    [requestForm setPostValue:[JoyfortParam getExtraData] forKey:@"extra_data"];
    [requestForm startSynchronous];
    
    
    [requestForm startSynchronous];
    NSLog(@"%@",requestForm.url);
    NSString *jsonStr = @"";
    NSError * error =[requestForm error];
    if(requestForm.responseStatusCode >400  || error) {
        NSLog(@"%@", error.localizedDescription);
        
        
        ASIFormDataRequest * aff = [requestForm copy];
        
        aff.url =[NSURL URLWithString: IOS_PAY_URL_IP];
        
        [aff startSynchronous];
        
        jsonStr = [aff responseString];
        NSLog(@"pay-retry-%@",aff.url);
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    } else {
        
        jsonStr = [requestForm responseString];
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    }
    
    
//    return jsonStr;
    
    
//    NSString *jsonStr = [requestForm responseString];
    //        //输入返回的信息
    NSLog(@"response\n%@",jsonStr);
    
    
    
    
    [self sendPayResult:jsonStr];
    return jsonStr;
}
-(NSString*)pay:(NSString*)role_name  jf_sid:(NSString*)jf_sid jf_uid:(NSString*)jf_uid extraData:(NSString*)extraData receipt:(NSString*)receipt{
    
    NSLog(@"%@",@"pay");
    
    ASIFormDataRequest *requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:IOS_PAY_URL]];

    
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
    [requestForm setPostValue:role_name forKey:@"role_name"];
    [requestForm setPostValue:@"" forKey:@"purchase_data"];
    [requestForm setPostValue:jf_sid forKey:@"jf_sid"];

    [requestForm setPostValue:[JoyfortParam getCode] forKey:@"code"];
    [requestForm setPostValue:receipt forKey:@"receipt"];
    [requestForm setPostValue:jf_uid forKey:@"jf_uid"];
    [requestForm setPostValue:[JoyfortParam getExtraData] forKey:@"extra_data"];
    [requestForm startSynchronous];
    
//    NSString *jsonStr = [requestForm responseString];
//    //        //输入返回的信息
//    NSLog(@"response\n%@",jsonStr);
//    [self sendPayResult:jsonStr];
//    return jsonStr;
    
    NSLog(@"%@",requestForm.url);
    NSString *jsonStr = @"";
    NSError * error =[requestForm error];
    if(requestForm.responseStatusCode >400  || error) {
        NSLog(@"%@", error.localizedDescription);
        
        
        ASIFormDataRequest * aff = [requestForm copy];
        
        aff.url =[NSURL URLWithString: IOS_PAY_URL_IP];
        
        [aff startSynchronous];
        
        jsonStr = [aff responseString];
        NSLog(@"pay-retry-%@",aff.url);
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    } else {
        
        jsonStr = [requestForm responseString];
        //        //返回的信息
        NSLog(@"response\n%@",jsonStr);
    }
    NSLog(@"response\n%@",jsonStr);
    
    [self sendPayResult:jsonStr];
    return jsonStr;
    
}



@end



