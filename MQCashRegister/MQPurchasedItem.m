//
//  MQPurchasedItem.m
//  MQCashRegister
//
//  Created by Gu Jun on 2/29/16.
//
//

#import "MQPurchasedItem.h"

@implementation MQPurchasedItem

- (id)initWithCode:(NSString *)code quantity:(NSUInteger)quantity {
    self = [super init];
    if (self) {
        self.code = code;
        self.quantity = quantity;
    }
    return self;
}
@end
