//
//  MQCommodity.m
//  MQCashRegister
//
//  Created by Gu Jun on 2/29/16.
//
//

#import "MQCommodity.h"

@implementation MQCommodity

- (id)initWithCode:(NSString *)code name:(NSString *)name quantifier:(NSString *)quantifier price:(NSNumber *)price {
    self = [super init];
    if (self) {
        self.code = code;
        self.name = name;
        self.quantifier = quantifier;
        self.price = price;
    }
    return self;
}

@end
