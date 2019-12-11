//
//  TransactionResultSignatureView.m
//  PAGADITO
//
//  Created by Water Flower on 2019/2/8.
//  Copyright © 2019 PAGADITO. All rights reserved.
//

#import "TransactionResultSignatureView.h"
#import "Global.h"

@implementation TransactionResultSignatureView
@synthesize path;

- (id)initWithCoder:(NSCoder *)aDecoder // (1)
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setMultipleTouchEnabled:NO]; // (2)
        [self setBackgroundColor:[UIColor whiteColor]];
        path = [UIBezierPath bezierPath];
        [path setLineWidth:2.0];
    }
    return self;
}

- (void)drawRect:(CGRect)rect // (5)
{
    [[UIColor blackColor] setStroke];
    [path stroke];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [path moveToPoint:p];
    Global *globals = [Global sharedInstance];
    globals.signatureStatus = true;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [path addLineToPoint:p]; // (4)
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
    Global *globals = [Global sharedInstance];
    globals.signatureStatus = false;
}

- (IBAction)clearButtonAction:(id)sender {
    [self.path removeAllPoints];
    [self setNeedsDisplay];
    Global *globals = [Global sharedInstance];
    globals.signatureStatus = false;
}
@end
