//
//  MQPromotion.h
//  优惠信息
//  MQCashRegister
//
//  Created by Gu Jun on 2/29/16.
//
//

#import <Foundation/Foundation.h>

@interface MQPromotion : NSObject

@property (nonatomic, copy) NSArray *promotionItems;

- (BOOL)contain:(NSString *)code;

@end
