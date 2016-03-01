//
//  NTMessageTableCellView.h
//  Netgram
//
//  Created by Maxim Pedchenko on 25.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NTMessageTableCellView : NSTableCellView

@property (weak) IBOutlet NSImageView *iconImageView;
@property (weak) IBOutlet NSTextField *senderField;
@property (weak) IBOutlet NSTextField *messageField;
@property (weak) IBOutlet NSTextField *iconTextField;
@property (weak) IBOutlet NSTextField *dateTextField;

- (CGFloat)estimateHeight;
- (void)setCompact:(BOOL)compact;

@end
