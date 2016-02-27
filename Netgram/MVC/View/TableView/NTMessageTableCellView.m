//
//  NTMessageTableCellView.m
//  Netgram
//
//  Created by Maxim Pedchenko on 25.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTMessageTableCellView.h"

@implementation NTMessageTableCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.iconImageView setWantsLayer: YES];
    
    self.iconImageView.layer.backgroundColor = [[NSColor selectedKnobColor] CGColor];
    
    self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.size.height / 2.0;
    self.iconImageView.layer.masksToBounds = YES;
}

- (CGFloat)makeHeight {
    
    CGRect textSize = [self.messageField.attributedStringValue
                   boundingRectWithSize:CGSizeMake(NSWidth(_messageField.bounds), CGFLOAT_MAX)
                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                   context:nil];
    
    return NSHeight(textSize) + NSHeight(_senderField.bounds) + 12;
}


@end
