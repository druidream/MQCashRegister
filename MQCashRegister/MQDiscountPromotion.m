//
//  MQDiscountPromotion.m
//  MQCashRegister
//
//  Created by Gu Jun on 2/29/16.
//
//

#import "MQDiscountPromotion.h"

@implementation MQDiscountPromotion

- (instancetype)init{
    self = [super init];
    if (self) {
        self.promotionItems = [NSArray array];
        self.rate = 0.95;
    }
    return self;
}

@end
