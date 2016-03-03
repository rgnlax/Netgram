//
//  NSTableView+NTKit.h
//  Netgram
//
//  Created by Maxim Pedchenko on 03.03.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSTableView (NTKit)

- (void)scrollRowToVisible:(NSInteger)rowIndex animate:(BOOL)animate;

@end
