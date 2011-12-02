//
//  CalculatorBrain.h
//  Calculator
//
//  Created by panagiotis mavridis on 11/30/11.
//  Copyright (c) 2011 platonmerlin@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalculatorBrain : NSObject
-(void)pushOperand:(double)operand;
-(double)performOperation:(NSString *) operation;
-(void) clearStack;
@end
