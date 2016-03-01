//
//  MQReceipt.h
//  小票model类
//  MQCashRegister
//
//  Created by Gu Jun on 3/1/16.
//
//

#import "MQPromotion.h"

@interface MQReceipt : MQPromotion

@property (nonatomic, copy) NSMutableArray *shoppingItems;
@property (nonatomic, copy) NSMutableArray *additionalItems;
@property (nonatomic, copy) NSString *totalAmount;
@property (nonatomic, copy) NSString *discountAmount;

- (NSString *)receiptText;
           
@end
