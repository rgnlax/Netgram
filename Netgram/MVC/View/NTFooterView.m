//
//  NTFooterView.m
//  Netgram
//
//  Created by Maxim Pedchenko on 22.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTFooterView.h"

@implementation NTFooterView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [self drawSeparatorInRect:dirtyRect];
}

- (void)drawSeparatorInRect:(NSRect)aRect {
    NSBezierPath *line = [NSBezierPath bezierPath];
    
    [line moveToPoint:NSMakePoint(0, NSHeight(aRect))];
    [line lineToPoint:NSMakePoint(NSWidth(aRect), NSHeight(aRect))];
    
    [line setLineWidth:2.0];
    [[NSColor colorWithCalibratedWhite:0.85 alpha:1.0] set];
    [line stroke];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setWantsLayer:true];
}
@end
