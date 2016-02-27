//
//  NTTextFieldCell.m
//  Netgram
//
//  Created by Maxim Pedchenko on 23.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTTextFieldCell.h"

#define INITIAL_HEIGHT 30.0

@implementation NTTextFieldCell

- (CGRect)drawingRectForBounds:(NSRect)theRect {
    return [super drawingRectForBounds:[self adjustRect:theRect]];
}

- (CGRect)adjustRect:(CGRect)aRect {
    CGFloat leftPadding = 5;
    
    aRect.origin.x += leftPadding;
    aRect.size.width -= leftPadding;

    if (aRect.size.height <= INITIAL_HEIGHT) {
        CGFloat textHeight = 12;
        
        CGFloat topOffset = floor(aRect.size.height / 2.0 - textHeight);
        
        aRect.origin.y += topOffset;
        aRect.size.height -= topOffset;
    }
    
    return aRect;
}
@end
