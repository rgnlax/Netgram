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
#import "NTOverlayView.h"

#define INITIAL_CONVERSATION -1

@interface NTSplitController ()

@property (nonatomic) NTMasterViewController *masterViewController;
@property (nonatomic) NTDetailViewController *detailViewController;

@property (nonatomic) NSInteger selectedConversationIndex;
@property (nonatomic) NTOverlayView *overlayView;

@end

@implementation NTSplitController

#pragma mark - NTSplitTableViewControllerDelegate Lifecycle

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        _selectedConversationIndex = -1;
        _overlayView = [NTOverlayView new];
    }
    return self;
}

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
    [self.overlayView presentInView:self.detailViewController.view withText:@"Start with selecting a chat"];
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
    if (_selectedConversationIndex != selectedConversationIndex) {
        if (selectedConversationIndex < 0) {
            self.overlayView.hidden = false;
        } else {
            _selectedConversationIndex = selectedConversationIndex;
            [_detailViewController loadConversation:[_masterViewController conversationAtIndex:selectedConversationIndex]];
            
            self.overlayView.hidden = true;
        }
        
    }
    
}

@end
