//
//  NTMainViewController.m
//  Netgram
//
//  Created by Maxim Pedchenko on 20.02.16.
//  Copyright © 2016 MP. All rights reserved.
//
#import "NSTableView+NTKit.h"
#import "NTAPIManager.h"

#import "NTDetailViewController.h"
#import "NTMessageTableCellView.h"
#import "NTHeaderView.h"

@interface NTDetailViewController()

@property (weak) IBOutlet NTHeaderView *headerView;
@property (weak, nonatomic) IBOutlet NTMessageBottomBar *messageBottomBar;

@property (nonatomic) NTConversation *conversation;
@property (nonatomic) NSMutableArray *dataSource;

@end

@implementation NTDetailViewController

#pragma mark - NSViewController Lifecycle

- (void)loadView {
    [super loadView];
    NSScrollView *scrollView = [self.tableView enclosingScrollView];

    scrollView.scrollerInsets = NSEdgeInsetsMake(-10, 0, -10, 0);
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollViewDocumentOffsetChangingNotificationHandler:)
                                                 name:NSViewFrameDidChangeNotification
                                               object:scrollView.contentView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.messageBottomBar.sendDelegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewMessageReceiveHandler) name:@"MessageNotification" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - NTDetailViewController Lifecycle

- (void)loadConversation:(NTConversation *)conversation {
    self.conversation = conversation;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self selector:@selector(updateConversation)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)updateConversation {
    [self.conversation updateMessagesWithCompletion:^{
        self.dataSource = [NSMutableArray arrayWithArray:[self.conversation getMessages]];
        [self.tableView reloadData];
    }];
}

- (void)setupViews {
    [self.messageBottomBar setHidden:self.conversation==nil];
    
    [self.headerView.titleField setStringValue:self.conversation.title];
    [self.headerView.subtitleField setStringValue:@"online"];
    
    [self.tableView reloadData];
    [self.tableView scrollRowToVisible:[[NSIndexSet indexSetWithIndex:self.dataSource.count - 1] lastIndex] animate:true];
}

#pragma mark - NTDetailViewController Notifications

- (void)scrollViewDocumentOffsetChangingNotificationHandler:(id)sender {
    [self.tableView reloadData];
}

- (void)tableViewMessageReceiveHandler {
    NSInteger lastIndex = self.dataSource.count == 0 ? 0 : self.dataSource.count - 1;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:lastIndex];
    [_tableView insertRowsAtIndexes:indexSet withAnimation:NSTableViewAnimationEffectFade];
    
    [self.tableView scrollRowToVisible:[indexSet lastIndex] animate:true];
}

#pragma mark - NTDetailViewController Actions

- (void)sendTextMessage:(NSString *)text {
    NTMessage *message = [[NTMessage alloc]initWithText:text sender:[[NTSessionManager manager]user] id:1 date:[NSDate date] inConversation:self.conversation];
    [self.dataSource addObject:message];
    
    [[NTAPIManager manager]sendMessage:message completion:^{
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:@"message"];
        [[NSNotificationCenter defaultCenter] postNotificationName: @"MessageNotification" object:nil userInfo:userInfo];
    }];
}

#pragma mark - NTMessageBottomBar Delegate

- (void)messageBottomBar:(NTMessageBottomBar *)bottomBar sendActionWithMessage:(NSString *)message {
    if (message.length > 0) {
        [self sendTextMessage:message];
    }
}

#pragma mark - NTDetailViewController Properties

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (void)setConversation:(NTConversation *)conversation {
    _conversation = conversation;
    [_dataSource removeAllObjects];
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

- (void)configureCell:(NTMessageTableCellView *)cell forRow:(NSInteger)row {
    if ([self.dataSource[row] isKindOfClass:[NTMessage class]]) {
        NTMessage *message = self.dataSource[row];
        
        [cell setViewData:message];
    }
}

@end
