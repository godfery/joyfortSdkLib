//
//  IOSPay.m
//  JoyfortIosSDK
//
//  Created by godfery on 15/7/2.
//  Copyright (c) 2015年 joyfort. All rights reserved.
//


#import "IOSPay.h"
//#import "JoyfortAD.h"
static BOOL observerInit;

@implementation IOSPay
static IOSPay * sharedSingleton = nil;
static SKProduct *willBuyProduct =nil;

+(IOSPay *)getInstance
{
    if (sharedSingleton == nil) {
        sharedSingleton = [[IOSPay alloc] init];
    }
    return sharedSingleton;
}
-(void)doViewDidLoad{
    
    NSLog(@"pay init --%d",observerInit);
    
    if(!observerInit) {
        NSLog(@"pay init --%d",observerInit);
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
    }
    observerInit = true;
    
    if(observerInit) {
//        [[SKPaymentQueue defaultQueue]restoreCompletedTransactions];
    }

    
}

- (void)doViewDidUnload{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}
-(void)searchProductsInfo:(NSArray*)productList{
    [self doViewDidLoad];
    if([SKPaymentQueue canMakePayments]) {
        
        NSSet * set = [NSSet setWithArray:productList];
        SKProductsRequest * request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
        request.delegate = self;
        [request start];
    }
    
}

// 以上查询的回调函数
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *myProduct = response.products;
    if (myProduct.count == 0) {
        NSLog(@"无法获取产品信息，购买失败。");
        NSMutableDictionary *myNewDict = [NSMutableDictionary dictionary];
        [myNewDict setObject:@"无法获取产品信息，购买失败。" forKey:@"error"];
        [myNewDict setObject:@"12" forKey:@"status"];
        
        NSError *parseError = nil;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:myNewDict options:NSJSONWritingPrettyPrinted error:&parseError];
        
        ;
        
        [[JoyfortPay getInstance]sendPayResult: [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
        
        
        return;
    }
//    NSLog(@"%@",myProduct);
    
    
    [[JoyfortPay getInstance]sendProductInfo:myProduct];
    
    
    
}
-(void)purchase:(SKProduct*)product{
    
    [self doViewDidLoad];
    NSLog(@"purchase init");
    SKPayment* payment =[SKPayment paymentWithProduct:product ];
    NSLog(@"paymentQueue instance:%@",[SKPaymentQueue defaultQueue]);
    NSLog(@"%@",product.price);
    
    NSLog(@"%@",product.productIdentifier);
    
    willBuyProduct = product;
    
    NSLog(@"paymentQueue instance:%@",payment);
    if([SKPaymentQueue canMakePayments]) {
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    
    NSLog(@"purchase start");
}
/**
 *
 *deal the purchased producted
 */
 
- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSLog(@"received restored transactions: %lu", (unsigned long)queue.transactions.count);
    for(SKPaymentTransaction *transaction in queue.transactions){
        if(transaction.transactionState == SKPaymentTransactionStateRestored){
            //called when the user successfully restores a purchase
            NSLog(@"Transaction state -> Restored");
            
            
//            [self completeTransaction:transaction];
            //if you have more than one in-app purchase product,
            //you restore the correct product for the identifier.
            //For example, you could use
            //if(productID == kRemoveAdsProductIdentifier)
            //to get the product identifier for the
            //restored purchases, you can use
            //
            //NSString *productID = transaction.payment.productIdentifier;
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
//            break;
        }
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    NSLog(@"paymentQueue init");
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased://交易完成
                NSLog(@"transactionIdentifier = %@", transaction.transactionIdentifier);
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed://交易失败
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored://已经购买过该商品
                [self restoreTransaction:transaction];
                break;
            case SKPaymentTransactionStatePurchasing:      //商品添加进列表
                NSLog(@"商品添加进列表");
                break;
            default:
                break;
        }
    }
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    // Your application should implement these two methods.
    NSString * productIdentifier = transaction.payment.productIdentifier;
    //NSData* decodeData = transaction.transactionReceipt;
    
    
    NSData* decodeData =[NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]];
    NSString* receipt ;
    if(!decodeData) {
        decodeData = transaction.transactionReceipt;
        //receipt= [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
    } else {
        decodeData = [decodeData base64EncodedDataWithOptions:0];
    }
    
    //NSDictionary* receipt = @{@"receipt":[decodeData base64EncodedStringWithOptions:0]};
    
    
    receipt= [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
    
    NSLog(@"receipt---%@",receipt);
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    NSLog(@" productIdentifier---%@",productIdentifier);
    if ([productIdentifier length] > 0) {
        NSLog(@"---invoke platform 1");
        //        [self.joyfortpay pay:receipt];
        
        [[JoyfortPay getInstance]pay:receipt];
        
        // 向自己的服务器验证购买凭证
    }
    // Remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    //    NSString *str = [NSString str:willBuyProduct.price];
    @try
    {
//        [[JoyfortAD getInstance ]purchase:willBuyProduct.price.stringValue currency:willBuyProduct.priceLocale.currencyCode];
    }@catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        
        
    }
    
    
    
    
}
- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    
    if(transaction.error.code != SKErrorPaymentCancelled) {
        NSLog(@"---error-message:%@",transaction.error.description);
        NSLog(@"购买失败");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"IAP error"
                                                        message:transaction.error.description
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    
        NSMutableDictionary *myNewDict = [NSMutableDictionary dictionary];
        [myNewDict setObject:@"购买失败" forKey:@"error"];
        [myNewDict setObject:@"13" forKey:@"status"];
        
        NSError *parseError = nil;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:myNewDict options:NSJSONWritingPrettyPrinted error:&parseError];
        
        ;
        
        [[JoyfortPay getInstance]sendPayResult: [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
        
        
    } else {
        NSLog(@"用户取消交易");
        
        NSMutableDictionary *myNewDict = [NSMutableDictionary dictionary];
        [myNewDict setObject:@"用户取消交易" forKey:@"error"];
        [myNewDict setObject:@"14" forKey:@"status"];
        
        NSError *parseError = nil;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:myNewDict options:NSJSONWritingPrettyPrinted error:&parseError];
        
        ;
        
        [[JoyfortPay getInstance]sendPayResult: [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
        
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}
- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    // 对于已购商品，处理恢复购买的逻辑
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}
@end
