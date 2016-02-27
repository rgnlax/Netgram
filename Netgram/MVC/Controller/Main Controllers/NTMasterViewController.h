//
//  NTMasterViewController.h
//  Netgram
//
//  Created by Maxim Pedchenko on 21.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NTMasterTableCellView.h"

@interface NTMasterViewController : NSViewController<NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *tableView;

@end
