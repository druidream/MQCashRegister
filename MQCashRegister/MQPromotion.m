//
//  MQPromotion.m
//  MQCashRegister
//
//  Created by Gu Jun on 2/29/16.
//
//

#import "MQPromotion.h"

@implementation MQPromotion


- (BOOL)contain:(NSString *)code {
    if ([self.promotionItems containsObject:code]) {
        return YES;
    }
    return NO;
}
@end
