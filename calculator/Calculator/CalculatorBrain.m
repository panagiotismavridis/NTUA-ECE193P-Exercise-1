//
//  CalculatorBrain.m
//  Calculator
//
//  Created by panagiotis mavridis on 11/30/11.
//  Copyright (c) 2011 platonmerlin@gmail.com. All rights reserved.
//

#import "CalculatorBrain.h"
@interface CalculatorBrain()
@property (nonatomic,strong) NSMutableArray *operandStack;
@end




@implementation CalculatorBrain
@synthesize operandStack;

-( NSMutableArray *)operandStack
{
    if (!operandStack){
        operandStack = [[NSMutableArray alloc] init];
    }
    return operandStack;   
}
-(void)setOperandStack:(NSMutableArray *)anArray
{
    operandStack=anArray;
    
}
-(void)pushOperand:(double)operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
    
}
-(double)popOperand{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}
-(void)clearStack
{
        [self.operandStack removeAllObjects];
}

-(double)performOperation:(NSString *) operation;
{
    double result=0;
    
    //compute the result here
    if ([operation isEqualToString:@"+"]){
        result = [self popOperand] + [self popOperand];
    }
    else if ([@"*" isEqualToString:operation]){
        result = [self popOperand] * [self popOperand];
    }
    else if ([operation isEqualToString: @"-"]){
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    }
    else if ([operation isEqualToString: @"/"]){
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    }
    else if ([operation isEqualToString:@"+/-"]){
        result = (-1)*([self popOperand]);
    }
    else if ([operation isEqualToString: @"sin"]){
        result = sin([self popOperand]);
    }
    else if ([operation isEqualToString: @"cos"]){
        result = cos([self popOperand]);
    }
    else if ([operation isEqualToString: @"log"]){
        double operand;
        operand = [self popOperand];
        if (!operand)
            result = log(operand);
    }
    else if ([operation isEqualToString: @"sqrt"]){
        double operand;
        operand = [self popOperand];
        if (operand >=0) 
            result = sqrt(operand);
    }
    else if ([operation isEqualToString: @"π"]){
        result = M_PI;
    }
    else if ([operation isEqualToString: @"e"]){
        result = M_E;
    }
    [self pushOperand: result];
    
    return result;
}

@end
