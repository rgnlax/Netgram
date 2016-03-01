//
//  NTMainViewController.m
//  Netgram
//
//  Created by Maxim Pedchenko on 20.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTDetailViewController.h"
#import "NTMessageTableCellView.h"
#import "NTHeaderView.h"
#import "NTTextField.h"

@interface NTDetailViewController()

@property (weak) IBOutlet NTHeaderView *headerView;
@property (weak) IBOutlet NTTextField *sendTextField;
@property (nonatomic) NSMutableArray *dataSource;
@property (nonatomic) NTConversation *conversation;

@end

@implementation NTDetailViewController

#pragma mark - Lifecycle

- (void)loadView {
    [super loadView];
    NSScrollView *scrollView = [self.tableView enclosingScrollView];

    scrollView.scrollerInsets = NSEdgeInsetsMake(-10, 0, -10, 0);
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollViewDocumentOffsetChangingNotificationHandler:)
                                                 name:NSViewFrameDidChangeNotification
                                               object:scrollView.contentView];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - NSTableView Delegate

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    NTMessageTableCellView *cell = (NTMessageTableCellView *)[tableView makeViewWithIdentifier:@"MessageCell" owner:tableView];
    
    [self configureCell:cell forRow:row];

    return [cell estimateHeight];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.dataSource.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NTMessageTableCellView *cell = (NTMessageTableCellView *)[tableView makeViewWithIdentifier:@"MessageCell" owner:tableView];
    
    [self configureCell:cell forRow:row];
    
    return cell;
}

- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row {
    return (NSTableRowView *)[tableView makeViewWithIdentifier:@"RowView" owner:tableView];
}

- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row {
    [self.splitDelegate splitViewController:self didSelectRow:row inTableView:tableView];
    return true;
}

#pragma mark - NSTableView Configuration

- (void)configureCell:(NTMessageTableCellView *)cell forRow:(NSInteger)row {
    if ([self.dataSource[row] isKindOfClass:[NTMessage class]]) {
        NTMessage *message = self.dataSource[row];
        
        [cell.messageField setStringValue:message.text];
        [cell.iconTextField setStringValue:[NSString stringWithFormat:@"#%lu", row + 1]];
        [cell.senderField setStringValue:message.sender.nickname];
        [cell.dateTextField setStringValue:[message prettyDateString]];
        
//        if (row > 0 && message.sender.UID == [self lastMessageSender].UID) {
//            [cell setCompact:true];
//        }
    }
}

#pragma mark - Notifications

- (void)scrollViewDocumentOffsetChangingNotificationHandler:(id)sender {
    [self.tableView reloadData];
}

- (void)tableViewMessageDidReceived {
    NSInteger lastIndex = self.dataSource.count == 0 ? 0 : self.dataSource.count - 1;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:lastIndex];
    [_tableView insertRowsAtIndexes:indexSet withAnimation:NSTableViewAnimationEffectFade];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
            context.allowsImplicitAnimation = YES;
            [self.tableView scrollRowToVisible:[indexSet firstIndex]];
        } completionHandler:NULL];
    }];
}

#pragma mark - Actions

- (void)sendTextMessage:(NSString *)text {
    //TODO: Database
    NTMessage *message = [[NTMessage alloc]init];
    NTUser *user = [[NTUser alloc]init];
    
    user.nickname = @"Superman";
    user.UID = [user.nickname hash];
    
    message.text = text;
    message.sender = user;
    message.date = [NSDate date];
    
    [self.dataSource addObject:message];
    
    [_sendTextField clear];
    [self tableViewMessageDidReceived];
}

-(void)controlTextDidEndEditing:(NSNotification *)notification {
    if ([[[notification userInfo] objectForKey:@"NSTextMovement"] intValue] == NSReturnTextMovement) {
        if (_sendTextField.stringValue.length != 0) {
            [self sendTextMessage:_sendTextField.stringValue];
        }
    }
}

- (void)loadConversation:(NTConversation *)conversation {
    //TODO: Database
    self.conversation = conversation;
    
    [self.dataSource removeAllObjects];
    [self setupViews];
}

#pragma mark - Interface configuration

- (void)setupViews {
    [self.headerView.titleField setStringValue:self.conversation.name];
    
    [self.tableView reloadData];
}

- (NTUser *__nullable)lastMessageSender {
    if (self.dataSource.count != 0) {
        //return ((NTMessage *)[self.dataSource lastObject]).sender;
    }
    return nil;
}

#pragma mark - Getters

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}


@end
