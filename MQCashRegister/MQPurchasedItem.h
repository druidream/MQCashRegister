//
//  MQPurchasedItem.h
//  买单条目
//  MQCashRegister
//
//  Created by Gu Jun on 2/29/16.
//
//

#import <Foundation/Foundation.h>

@interface MQPurchasedItem : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign) NSUInteger quantity;

- (id)initWithCode:(NSString *)code quantity:(NSUInteger)quantity;

@end
