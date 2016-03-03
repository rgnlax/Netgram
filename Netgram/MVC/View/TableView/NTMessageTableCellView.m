//
//  NTMessageTableCellView.m
//  Netgram
//
//  Created by Maxim Pedchenko on 25.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTMessageTableCellView.h"
@interface NTMessageTableCellView()

@property (weak) IBOutlet NSLayoutConstraint *iconImageViewHeightConstraint;
@property (weak) IBOutlet NSLayoutConstraint *senderTextFieldHeightConstraint;

@end

@implementation NTMessageTableCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.iconImageView setWantsLayer: YES];
    
    self.iconImageView.layer.backgroundColor = [[NSColor selectedKnobColor] CGColor];
    
    self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.size.height / 2.0;
    self.iconImageView.layer.masksToBounds = YES;
}

- (CGFloat)estimateHeight {
    
    CGRect textSize = [self.messageField.attributedStringValue
                   boundingRectWithSize:CGSizeMake(NSWidth(_messageField.bounds), CGFLOAT_MAX)
                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                   context:nil];
    
    return NSHeight(textSize) + NSHeight(_senderField.bounds) + 12;
}

#pragma mark - Customization

- (void)setCompact:(BOOL)compact {
    if (compact) {
        self.iconImageViewHeightConstraint.constant = 0;
        self.senderTextFieldHeightConstraint.constant = 0;
        self.iconTextField.hidden = true;
    } else {
        self.iconImageViewHeightConstraint.constant = 36;
        self.senderTextFieldHeightConstraint.constant = 17;
        self.iconTextField.hidden = false;
    }
    
    [self layoutSubtreeIfNeeded];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self setCompact:false];
}


@end
