//
//  CalculatorViewController.m
//  Calculator
//
//  Created by panagiotis mavridis on 11/29/11.
//  Copyright (c) 2011 platonmerlin@gmail.com. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"
@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic,strong) CalculatorBrain *brain;
@property (nonatomic) BOOL userPressedCommaDigit;
@end


@implementation CalculatorViewController
@synthesize display;
@synthesize fullDisp;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize userPressedCommaDigit;
@synthesize brain=_brain;

-(CalculatorBrain *)brain{
    
    if(!_brain)_brain = [[CalculatorBrain alloc] init];
    return _brain;
}
- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if (self.userIsInTheMiddleOfEnteringANumber){
        self.display.text = [self.display.text stringByAppendingString:digit]; //[self.display setText:newDisplayText];        
    }
    else{
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userPressedCommaDigit = NO;
    self.fullDisp.text = [self.fullDisp.text stringByAppendingString:@" "];
    self.fullDisp.text = [self.fullDisp.text stringByAppendingString:self.display.text];
}
- (IBAction)operationPressed:(id)sender {
    
    if (self.userIsInTheMiddleOfEnteringANumber){
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g",result];
    self.fullDisp.text = [self.fullDisp.text stringByAppendingString:@" "];
    self.fullDisp.text = [self.fullDisp.text stringByAppendingString:operation];
    //TODO: extra procedure for appearing "="
    //self.fullDisp.text = [self.fullDisp.text stringByAppendingString:@" ="];
}
- (IBAction)commaPressed:(id)sender {
    NSString *digit = [sender currentTitle];
    if (!self.userPressedCommaDigit && self.userIsInTheMiddleOfEnteringANumber){
        self.display.text = [self.display.text stringByAppendingString:digit];
        userPressedCommaDigit = YES;
        //[self.display setText:newDisplayText];
    }
}
- (IBAction)clearButton:(id)sender {
    self.display.text = @"0";
    self.fullDisp.text = @"";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userPressedCommaDigit = NO;
    [self.brain clearStack];
}
- (IBAction)backSpacePressed:(id)sender {
if (self.display.text.length != 0) 
    self.display.text = [self.display.text stringByPaddingToLength:(self.display.text.length - 1)  withString:self.display.text startingAtIndex: 0];
}

@end