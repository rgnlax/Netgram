//
//  NTMasterCellView.m
//  Netgram
//
//  Created by Maxim Pedchenko on 21.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTMasterTableCellView.h"
#import "NSColor+GRProKitHelpers.h"

@implementation NTMasterTableCellView

- (void)setBackgroundStyle:(NSBackgroundStyle)backgroundStyle {
    [super setBackgroundStyle:backgroundStyle];
    
    [self repaintWithStyle:backgroundStyle];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.iconImageView setWantsLayer: YES];
    
    self.iconImageView.layer.backgroundColor = [[NSColor selectedKnobColor] CGColor];

    self.iconImageView.layer.cornerRadius = 25;
    self.iconImageView.layer.masksToBounds = YES;
}

- (void)repaintWithStyle:(NSBackgroundStyle)backgroundStyle {
    if (backgroundStyle == NSBackgroundStyleLight) {
        self.titleField.textColor = [NSColor darkGrayColor];
        self.detailsField.textColor = [[NSColor lightGrayColor]darkerColor];
    } else {
        self.titleField.textColor = [NSColor whiteColor];
        self.detailsField.textColor = [NSColor whiteColor];
    }
}

- (void)setIconTextFieldText:(NSString *)text {
    [self.iconTextField setStringValue:text];
    
    self.iconImageView.layer.backgroundColor = [[[NSColor colorWithString:text] darkerColor]colorWithAlphaComponent:0.6].CGColor;
}




@end
