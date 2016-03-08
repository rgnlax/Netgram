//
//  NTSessionManager.h
//  Netgram
//
//  Created by Maxim Pedchenko on 07.03.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTUser.h"

@interface NTSessionManager : NSObject

@property (nonatomic) BOOL isConnected;

+ (instancetype)manager;

- (void)authenticateWithName:(NSString *)name;
- (NTUser *)user;

- (void)connect;
- (void)disconnect;

@end
