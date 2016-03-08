//
//  NTSplitController.h
//  Netgram
//
//  Created by Maxim Pedchenko on 27.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NTAuthViewController.h"

@protocol NTSplitTableViewControllerDelegate

@optional
- (void)splitViewController:(NSViewController *)viewController didSelectRow:(NSInteger)row inTableView:(NSTableView *)tableView;

@end

@interface NTSplitController : NSSplitViewController<NTSplitTableViewControllerDelegate, NTAuthViewControllerDelegate>

@end
