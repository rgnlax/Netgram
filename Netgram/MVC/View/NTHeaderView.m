//
//  NTHeaderView.m
//  Netgram
//
//  Created by Maxim Pedchenko on 22.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTHeaderView.h"

@implementation NTHeaderView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [[NSColor whiteColor]set];
    NSRectFill(dirtyRect);
    
    [self drawSeparatorInRect:dirtyRect];
}

- (void)drawSeparatorInRect:(NSRect)aRect {
    NSBezierPath *line = [NSBezierPath bezierPath];
    
    [line moveToPoint:NSMakePoint(0, 0)];
    [line lineToPoint:NSMakePoint(NSWidth(aRect), 0)];
    
    [line setLineWidth:2.0];
    [[NSColor colorWithCalibratedWhite:0.9 alpha:1.0] set];
    [line stroke];
}

@end
