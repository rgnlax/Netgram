//
//  NSTableView+NTKit.m
//  Netgram
//
//  Created by Maxim Pedchenko on 03.03.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NSTableView+NTKit.h"

@implementation NSTableView (NTKit)

- (void)scrollRowToVisible:(NSInteger)rowIndex animate:(BOOL)animate{
    if (animate) {
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
            context.allowsImplicitAnimation = YES;
            [self scrollRowToVisible: rowIndex];
        } completionHandler:NULL];
    } else{
        [self scrollRowToVisible:rowIndex];
    }
}
@end
