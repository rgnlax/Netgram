//
//  NSView+NTKit.h
//  Netgram
//
//  Created by Maxim Pedchenko on 10.03.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSView (NTKit)

+ (NSView *)loadWithNibNamed:(NSString *)nibNamed owner:(id)owner class:(Class)loadClass;

@end
