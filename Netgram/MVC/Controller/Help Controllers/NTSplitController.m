//
//  NTSplitController.m
//  Netgram
//
//  Created by Maxim Pedchenko on 27.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTSessionManager.h"
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

#pragma mark - NTSplitTableViewControllerDelegate Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupControllers];
    
    if ([[NTSessionManager manager]isConnected]) {
        [self setupInitialState];
    } else {
        [self setupAuthController];
    }
}

#pragma mark - NTSplitTableViewControllerDelegate Configuration

- (void)setupControllers {
    _masterViewController = (NTMasterViewController *)[self.splitViewItems firstObject].viewController;
    _detailViewController = (NTDetailViewController *)[self.splitViewItems lastObject].viewController;
    
    _masterViewController.splitDelegate = self;
    _detailViewController.splitDelegate = self;
}

- (void)setupInitialState {
    [_masterViewController loadConversations];
    [_masterViewController loadConversationAtIndex:_selectedConversationIndex];
}

- (void)setupAuthController {
    NTAuthViewController *authController = [[NTAuthViewController alloc]init];
    [authController presentInViewController:self.detailViewController withDelegate:self];
}

#pragma mark - NTAuthViewController Delegate
- (void)authViewController:(NTAuthViewController *)controller didFinishWithName:(NSString *)name {
    [controller dismissAuthViewController];

    [[NTSessionManager manager]authenticateWithName:name];
    [self setupInitialState];
}

#pragma mark - NTSplitTableViewControllerDelegate Delegate

- (void)splitViewController:(NSViewController *)viewController didSelectRow:(NSInteger)row inTableView:(NSTableView *)tableView {
    if ([viewController isKindOfClass:[NTMasterViewController class]]) {
        self.selectedConversationIndex = row;
    }
}

#pragma mark - NTSplitTableViewController Properties
- (void)setSelectedConversationIndex:(NSInteger)selectedConversationIndex {
    _selectedConversationIndex = selectedConversationIndex;
    [_detailViewController loadConversation:[_masterViewController currentConversation]];
}

@end
