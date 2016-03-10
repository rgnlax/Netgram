//
//  NTOverlayView.h
//  Netgram
//
//  Created by Maxim Pedchenko on 10.03.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSView+NTKit.h"

@interface NTOverlayView : NSView

- (void)presentInView:(NSView *)view withText:(NSString *)text;

@end
