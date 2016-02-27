//
//  NTMasterCellView.h
//  Netgram
//
//  Created by Maxim Pedchenko on 21.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NTMasterTableCellView : NSTableCellView

@property (weak) IBOutlet NSTextField *titleField;
@property (weak) IBOutlet NSTextField *detailsField;
@property (weak) IBOutlet NSImageView *iconImageView;
@property (weak) IBOutlet NSTextField *iconTextField;

@end
