//
//  MQCommodity.h
//  商品model类
//  MQCashRegister
//
//  Created by Gu Jun on 2/29/16.
//
//

#import <Foundation/Foundation.h>

@interface MQCommodity : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *quantifier;
@property (nonatomic, strong) NSNumber *price;

- (id)initWithCode:(NSString *)code name:(NSString *)name quantifier:(NSString *)quantifier price:(NSNumber *)price;

@end
