//
//  NTSplitController.m
//  Netgram
//
//  Created by Maxim Pedchenko on 27.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTSplitController.h"
#import "NTMasterViewController.h"
#import "NTDetailViewController.h"

@interface NTSplitController ()

@property (nonatomic) NTMasterViewController *masterViewController;
@property (nonatomic) NTDetailViewController *detailViewController;

@property (nonatomic) NSInteger selectedConversationIndex;

@end

@implementation NTSplitController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    _selectedConversationIndex = 0;
    
    return self;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupControllers];
    [self setupInitialState];
}

#pragma mark - Configuration

- (void)setupControllers {
    _masterViewController = (NTMasterViewController *)[self.splitViewItems firstObject].viewController;
    _detailViewController = (NTDetailViewController *)[self.splitViewItems lastObject].viewController;
    
    _masterViewController.splitDelegate = self;
    _detailViewController.splitDelegate = self;
    
    [_masterViewController loadConversations];
}

- (void)setupInitialState {
    [_masterViewController loadConversationAtIndex:_selectedConversationIndex];
}

#pragma mark - NTSplitTableViewControllerDelegate Delegate

- (void)splitViewController:(NSViewController *)viewController didSelectRow:(NSInteger)row inTableView:(NSTableView *)tableView {
    if ([viewController isKindOfClass:[NTMasterViewController class]]) {
        self.selectedConversationIndex = row;
    }
}

#pragma mark - Setters
- (void)setSelectedConversationIndex:(NSInteger)selectedConversationIndex {
    _selectedConversationIndex = selectedConversationIndex;
    [_detailViewController loadConversation:[_masterViewController currentConversation]];
}

@end
