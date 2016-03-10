//
//  NTMasterViewController.h
//  Netgram
//
//  Created by Maxim Pedchenko on 21.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NTSplitController.h"
#import "NTConversation.h"

@interface NTMasterViewController : NSViewController<NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *tableView;
@property (nonatomic) id<NTSplitTableViewControllerDelegate> splitDelegate;

- (void)loadConversationAtIndex:(NSInteger)index;
- (void)loadConversations;

- (NTConversation *)conversationAtIndex:(NSInteger)index;

@end
