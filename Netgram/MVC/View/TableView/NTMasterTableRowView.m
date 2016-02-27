//
//  NTMasterRowView.m
//  Netgram
//
//  Created by Maxim Pedchenko on 21.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTMasterTableRowView.h"
#import "NSColor+GRProKitHelpers.h"

#define LEADING_OFFSET 65

@implementation NTMasterTableRowView

#pragma mark - Drawing

- (void)drawSelectionInRect:(NSRect)dirtyRect {
    if (self.selectionHighlightStyle != NSTableViewSelectionHighlightStyleNone) {
        NSColor *selectionColor;
        
        if (![self shoudDrawAsKey]) {
            selectionColor = [[NSColor lightGrayColor]lighterColor];
        } else {
            selectionColor = [NSColor colorWithCalibratedRed: 0.267 green: 0.467 blue: 0.698 alpha: 1];
        }
        
        [selectionColor setFill];
        [[selectionColor darkerColor]setStroke];

        NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRect:dirtyRect];
        
        [selectionPath fill];
        [selectionPath stroke];
    }
}

- (void)drawSeparatorInRect:(NSRect)dirtyRect {
    if (!self.isSelected) {
        // Default separator color
        NSColor *normalColor = [NSColor colorWithCalibratedWhite:0.90 alpha:1.0];
        
        // Define coordinates of separator line
        NSRect drawingRect = NSMakeRect(LEADING_OFFSET, NSHeight(dirtyRect) - 1.0, NSWidth(dirtyRect) - LEADING_OFFSET, 1.0);
        
        // Set the color of the separator line
        [normalColor set]; // Default

        // Draw separator line
        NSRectFill (drawingRect);
    }
}

- (BOOL)shoudDrawAsKey {
    return (NSApp.active && _window.isKeyWindow && [_window.firstResponder isEqualTo:self.superview]);
}

@end
