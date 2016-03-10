//
//  NTOverlayView.m
//  Netgram
//
//  Created by Maxim Pedchenko on 10.03.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTOverlayView.h"

@interface NTOverlayView()

@property (weak) IBOutlet NSTextField *textField;

@end

@implementation NTOverlayView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setWantsLayer:true];
    self.layer.backgroundColor = [NSColor whiteColor].CGColor;
}

- (void)presentInView:(NSView *)view withText:(NSString *)text {
    self.textField.stringValue = text;
    
    self.frame = view.frame;
    self.translatesAutoresizingMaskIntoConstraints = YES;
    self.autoresizingMask = NSViewHeightSizable | NSViewWidthSizable;
    
    [view addSubview:self];
}

+ (instancetype)new {
    return (NTOverlayView *)[NSView loadWithNibNamed:@"NTOverlayView" owner:self class:[NTOverlayView class]];
}

@end
