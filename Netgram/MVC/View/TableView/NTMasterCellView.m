//
//  NTMasterCellView.m
//  Netgram
//
//  Created by Maxim Pedchenko on 21.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTMasterCellView.h"

@implementation NTMasterCellView

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
        self.detailsField.textColor = [NSColor lightGrayColor];
    } else {
        self.titleField.textColor = [NSColor whiteColor];
        self.detailsField.textColor = [NSColor whiteColor];
    }
}

@end
