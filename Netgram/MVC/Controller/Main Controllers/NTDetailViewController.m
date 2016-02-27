//
//  NTMainViewController.m
//  Netgram
//
//  Created by Maxim Pedchenko on 20.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTDetailViewController.h"
#import "NTMessageTableCellView.h"
#import "NTTextField.h"

@interface NTDetailViewController()
@property (weak) IBOutlet NTTextField *sendTextField;

@property (nonatomic) NSMutableArray *dataSource;

@end

@implementation NTDetailViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray array];
}

- (void)loadView {
    [super loadView];
    NSScrollView *scrollView = [self.tableView enclosingScrollView];

    scrollView.scrollerInsets = NSEdgeInsetsMake(-10, 0, -10, 0);
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollViewDocumentOffsetChangingNotificationHandler:)
                                                 name:NSViewFrameDidChangeNotification
                                               object:scrollView.contentView];
}

#pragma mark - NSTableView Delegate
- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    NTMessageTableCellView *cell = (NTMessageTableCellView *)[tableView makeViewWithIdentifier:@"MessageCell" owner:tableView];
    
    [self configureCell:cell forRow:row];

    return [cell makeHeight];
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

#pragma mark - NSTableView Configuration
- (void)configureCell:(NTMessageTableCellView *)cell forRow:(NSInteger)row {
    [cell.messageField setStringValue:self.dataSource[row]];
    [cell.iconTextField setStringValue:[NSString stringWithFormat:@"#%lu", row + 1]];
    [cell.senderField setStringValue:@"COM#1"];
}

#pragma mark - NSTextField Delegate
-(void)controlTextDidEndEditing:(NSNotification *)notification {
    if ([[[notification userInfo] objectForKey:@"NSTextMovement"] intValue] == NSReturnTextMovement) {
        if (_sendTextField.stringValue.length != 0) {
            [_dataSource addObject:_sendTextField.stringValue];
            [_sendTextField clear];
            
            [self tableViewMessageDidReceived];
        }
    }
}

#pragma mark - Notifications
- (void)scrollViewDocumentOffsetChangingNotificationHandler:(id)sender {
    [self.tableView reloadData];
}

- (void)tableViewMessageDidReceived {
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:_dataSource.count - 1];
    [_tableView insertRowsAtIndexes:indexSet withAnimation:NSTableViewAnimationEffectFade];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
            context.allowsImplicitAnimation = YES;
            [self.tableView scrollRowToVisible:[indexSet firstIndex]];
        } completionHandler:NULL];
    }];
}


@end
