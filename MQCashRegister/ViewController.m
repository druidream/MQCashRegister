//
//  ViewController.m
//  MQCashRegister
//
//  Created by Gu Jun on 3/1/16.
//  Copyright © 2016 Gu Jun. All rights reserved.
//

#import "ViewController.h"
#import "MQCashRegister.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MQCashRegister *cashRegister = [[MQCashRegister alloc] init];
    [cashRegister checkout];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
