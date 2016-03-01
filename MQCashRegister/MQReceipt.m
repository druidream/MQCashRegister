//
//  MQReceipt.m
//  MQCashRegister
//
//  Created by Gu Jun on 3/1/16.
//
//

#import "MQReceipt.h"

@implementation MQReceipt

- (instancetype)init {
    self = [super init];
    if (self) {
        self.shoppingItems = [[NSMutableArray alloc] init];
        self.additionalItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)receiptText {
    NSMutableString *consoleText = [[NSMutableString alloc] init];
    static NSString *carriageReturn = @"\n";

    // header
    [consoleText appendString:@"***<没钱赚商店>购物清单***"];
    [consoleText appendString:carriageReturn];
    
    // 购物清单
    [[self.shoppingItems copy] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [consoleText appendString:obj];
        [consoleText appendString:carriageReturn];
    }];
    [consoleText appendString:@"----------------------"];
    [consoleText appendString:carriageReturn];

    // 买二赠一
    if (self.additionalItems.count > 0) {
        [consoleText appendString:@"买二赠一商品："];
        [consoleText appendString:carriageReturn];
        [[self.additionalItems copy] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [consoleText appendString:obj];
            [consoleText appendString:carriageReturn];
        }];
        [consoleText appendString:@"----------------------"];
        [consoleText appendString:carriageReturn];
    }
    
    // 汇总
    [consoleText appendString:self.totalAmount];
    [consoleText appendString:carriageReturn];
    if (self.discountAmount.length > 0) {
        [consoleText appendString:self.discountAmount];
        [consoleText appendString:carriageReturn];
    }
    
    // footer
    [consoleText appendString:@"**********************"];
    [consoleText appendString:carriageReturn];
    
    return consoleText;
}

@end
