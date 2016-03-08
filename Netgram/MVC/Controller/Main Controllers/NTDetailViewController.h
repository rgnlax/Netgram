//
//  NTMainViewController.h
//  Netgram
//
//  Created by Maxim Pedchenko on 20.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NTSessionManager.h"

#import "NTConversation.h"

#import "NTSplitController.h"
#import "NTMessageBottomBar.h"

@interface NTDetailViewController : NSViewController<NSTableViewDataSource, NSTableViewDelegate, NTMessageBottomBarSendDelegate>

@property (weak, nonatomic) IBOutlet NSTableView *tableView;
@property (nonatomic) id<NTSplitTableViewControllerDelegate> splitDelegate;

- (void)loadConversation:(NTConversation *)conversation;

@end
