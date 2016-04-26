//
//  NTMasterViewController.m
//  Netgram
//
//  Created by Maxim Pedchenko on 21.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTMasterViewController.h"
#import "NTMasterTableCellView.h"
#import "NTSessionManager.h"
#import "NTAPIManager.h"

@interface NTMasterViewController()

@property (nonatomic) NSMutableArray *dataSource;
@property (nonatomic) NSInteger selectedConversation;

@property (weak) IBOutlet NSTextField *chatNameTextField;
@property (weak) IBOutlet NSTextField *chatDescriptionTextField;

@end

@implementation NTMasterViewController

#pragma mark - NSViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newMessageHandler) name:@"MessageNotification" object:nil];
}

#pragma mark - NTMasterViewController Lifecycle

- (void)loadConversationAtIndex:(NSInteger)index {
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
    [self.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
    
    [self.splitDelegate splitViewController:self didSelectRow:index inTableView:self.tableView];
}

- (void)loadConversations {
    [[NTAPIManager manager]getConversationsByUserID:[NTSessionManager manager].user.UID completion:^(id objects) {
        [self.dataSource addObjectsFromArray:[NTConversation conversationsFromObjects:objects]];
        
        [self setupHeaderView];
        [self.tableView reloadData];
    }];
}

- (void)setupHeaderView {
    self.chatNameTextField.stringValue = @"Network";
    self.chatDescriptionTextField.stringValue = [NSString stringWithFormat:@"%lu chats", self.dataSource.count];
}

- (NTConversation *)conversationAtIndex:(NSInteger)index {
    self.selectedConversation = index;
    return self.dataSource[index];
}

#pragma mark - NTMasterViewController Getters

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

#pragma mark - NTMasterViewController Notifications

- (void)newMessageHandler {
    [self.tableView reloadData];
    [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:self.selectedConversation] byExtendingSelection:NO];
}

#pragma mark - NSTableView Delegate

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 60.0;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.dataSource.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NTMasterTableCellView *cell = (NTMasterTableCellView *)[tableView makeViewWithIdentifier:@"MasterCell" owner:tableView];
    
    NTConversation *conversation = (NTConversation *)self.dataSource[row];
    
    [cell.titleField setStringValue:conversation.title];
    [cell setIconTextFieldText:[NSString stringWithFormat:@"#%lu", row + 1]];
    [cell.detailsField setStringValue:[conversation lastMessage]];
    
    return cell;
}

- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row {
    return (NSTableRowView *)[tableView makeViewWithIdentifier:@"RowView" owner:tableView];
}

- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row {
    [self.splitDelegate splitViewController:self didSelectRow:row inTableView:tableView];
    return true;
}

@end
