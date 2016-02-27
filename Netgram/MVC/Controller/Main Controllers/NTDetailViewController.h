//
//  NTMainViewController.h
//  Netgram
//
//  Created by Maxim Pedchenko on 20.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NTDetailViewController : NSViewController<NSTableViewDataSource, NSTableViewDelegate>

@property (weak, nonatomic) IBOutlet NSTableView *tableView;

@end
