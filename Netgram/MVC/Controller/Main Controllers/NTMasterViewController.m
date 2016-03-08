//
//  NTMasterViewController.m
//  Netgram
//
//  Created by Maxim Pedchenko on 21.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTMasterViewController.h"
#import "NTMasterTableCellView.h"

@interface NTMasterViewController()

@property (nonatomic) NSMutableArray *dataSource;

@property (weak) IBOutlet NSTextField *chatNameTextField;
@property (weak) IBOutlet NSTextField *chatDescriptionTextField;

@end

@implementation NTMasterViewController

#pragma mark NTMasterViewController Lifecycle

- (void)loadConversationAtIndex:(NSInteger)index {
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
    [self.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
}

- (void)loadConversations {
    //TODO: Database
    _dataSource = [NSMutableArray new];
    NSArray *chats = @[@"Broadcast", @"COM#1", @"COM#2"];
    for (NSString *name in chats) {
        NTConversation *c = [[NTConversation alloc]init];
        
        c.name = name;
        c.UID = [name hash];
        
        [self.dataSource addObject:c];
    }
    
    [self setupHeaderView];
    [self.tableView reloadData];
}

- (void)setupHeaderView {
    self.chatNameTextField.stringValue = @"Network";
    self.chatDescriptionTextField.stringValue = [NSString stringWithFormat:@"%lu chats", self.dataSource.count];
}

- (NTConversation *)currentConversation {
    return self.dataSource[self.tableView.selectedRow];
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
    
    [cell.titleField setStringValue:conversation.name];
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
