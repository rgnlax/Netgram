//
//  AppDelegate.m
//  Netgram
//
//  Created by Maxim Pedchenko on 20.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "AppDelegate.h"
#import "NTSessionManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [[NTSessionManager manager]authenticateWithName:@"Pentaho"];
    [[NTSessionManager manager]connect];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    [[NTSessionManager manager]disconnect];
}

@end
