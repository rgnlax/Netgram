//
//  NTTextField.m
//  Netgram
//
//  Created by Maxim Pedchenko on 23.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTTextField.h"

#define CORNER_RADIUS 3

@interface NTTextField() {
    BOOL _hasLastIntrinsicSize;
    BOOL _isEditing;
    NSSize _lastIntrinsicSize;
}

@end

@implementation NTTextField

#pragma mark - Notifications

- (void)textDidBeginEditing:(NSNotification *)notification {
    [super textDidBeginEditing:notification];
    _isEditing = YES;
}

- (void)textDidEndEditing:(NSNotification *)notification {
    [super textDidEndEditing:notification];
    _isEditing = NO;
}

- (void)textDidChange:(NSNotification *)notification {
    [super textDidChange:notification];
    [self invalidateIntrinsicContentSize];
}


#pragma mark - Resizing

-(NSSize)intrinsicContentSize {
    NSSize intrinsicSize = _lastIntrinsicSize;
    
    // Only update the size if we’re editing the text, or if we’ve not set it yet
    // If we try and update it while another text field is selected, it may shrink back down to only the size of one line (for some reason?)
    if(_isEditing || !_hasLastIntrinsicSize)
    {
        intrinsicSize = [super intrinsicContentSize];
        
        // If we’re being edited, get the shared NSTextView field editor, so we can get more info
        NSText *fieldEditor = [self.window fieldEditor:NO forObject:self];
        if([fieldEditor isKindOfClass:[NSTextView class]])
        {
            NSTextView *textView = (NSTextView *)fieldEditor;
            NSRect usedRect = [textView.textContainer.layoutManager usedRectForTextContainer:textView.textContainer];
            
            usedRect.size.height += 5.0; // magic number! (the field editor TextView is offset within the NSTextField. It’s easy to get the space above (it’s origin), but it’s difficult to get the default spacing for the bottom, as we may be changing the height
            
            intrinsicSize.height = usedRect.size.height;
        }
        
        _lastIntrinsicSize = intrinsicSize;
        _hasLastIntrinsicSize = YES;
    }
    return intrinsicSize;
}

#pragma mark - Appearance

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setWantsLayer:true];
    
    self.layer.masksToBounds = true;
    self.layer.backgroundColor = [NSColor whiteColor].CGColor;
    self.layer.cornerRadius = CORNER_RADIUS;
    self.layer.borderColor = [NSColor colorWithCalibratedWhite:0.86 alpha:1.0].CGColor;
    self.layer.borderWidth = 1.0;
}

- (BOOL)becomeFirstResponder {
    BOOL success = [super becomeFirstResponder];
    if(success) {
        NSTextView* textField = (NSTextView*) [self currentEditor];
        if( [textField respondsToSelector: @selector(setInsertionPointColor:)] )
            [textField setInsertionPointColor: [NSColor colorWithCalibratedRed: 0.267 green: 0.467 blue: 0.698 alpha: 1]];
    }
    return success;
}

- (void)clear {
    self.stringValue = @"";
    [self layoutSubtreeIfNeeded];
    //[self invalidateIntrinsicContentSize];
}

@end
