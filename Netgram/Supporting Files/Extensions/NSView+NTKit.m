//
//  NSView+NTKit.m
//  Netgram
//
//  Created by Maxim Pedchenko on 10.03.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NSView+NTKit.h"

@implementation NSView (NTKit)

+ (NSView *)loadWithNibNamed:(NSString *)nibNamed owner:(id)owner class:(Class)loadClass {
    
    NSNib * nib = [[NSNib alloc] initWithNibNamed:nibNamed bundle:nil];
    
    NSArray * objects;
    if (![nib instantiateWithOwner:owner topLevelObjects:&objects]) {
        NSLog(@"Couldn't load nib named %@", nibNamed);
        return nil;
    }
    
    for (id object in objects) {
        if ([object isKindOfClass:loadClass]) {
            return object;
        }
    }
    return nil;
}

@end
