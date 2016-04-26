//
//  NTSessionManager.m
//  Netgram
//
//  Created by Maxim Pedchenko on 07.03.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTSessionManager.h"
#import "NTAPIManager.h"

@interface NTSessionManager()

@property (nonatomic) NTUser *user;

@end

@implementation NTSessionManager

#pragma mark - NTSessionManager Singleton

+ (instancetype)manager {
    static NTSessionManager *sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [[self alloc] init];
    });
    return sessionManager;
}

- (instancetype)init {
    if (self = [super init]) {
        //Initialization
    }
    return self;
}

#pragma mark - NTSessionManager Lifecycle

- (void)connect {
    if (self.user) {
        self.isConnected = YES;
    }
}

- (void)disconnect {
    self.isConnected = NO;
}

#pragma mark - NTSessionManager User

- (void)authenticate:(id)user {
    NSString *nickname = [user objectForKey:@"nickname"];
    NSInteger userID = [[user objectForKey:@"id"]integerValue];
    
    self.user = [[NTUser alloc]initWithNickname:nickname andID:userID];
    
    if (!self.isConnected) {
        [self connect];
    }
}

- (NTUser *)user {
    if (!_user) {
        //Load from defaults
    }
    return _user;
}

@end
