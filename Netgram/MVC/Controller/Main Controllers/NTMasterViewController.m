//
//  NTMasterViewController.m
//  Netgram
//
//  Created by Maxim Pedchenko on 21.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTMasterViewController.h"
@interface NTMasterViewController()

@property (nonatomic) NSArray *dataSource;

@end

@implementation NTMasterViewController

#pragma mark - NSViewController lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = @[@"Broadcast", @"COM #1", @"COM #2"];    
}

#pragma mark - NSTableView
- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 60;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.dataSource.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NTMasterTableCellView *cell = (NTMasterTableCellView *)[tableView makeViewWithIdentifier:@"MasterCell" owner:tableView];
    
    [cell.titleField setStringValue:self.dataSource[row]];
    [cell.iconTextField setStringValue:[NSString stringWithFormat:@"#%lu", row + 1]];
    [cell.detailsField setStringValue:@"COM#1: Go!"];
    
    return cell;
}

- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row {
    return (NSTableRowView *)[tableView makeViewWithIdentifier:@"RowView" owner:tableView];
}

@end
