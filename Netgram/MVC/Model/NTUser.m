//
//  NTUser.m
//  Netgram
//
//  Created by Maxim Pedchenko on 28.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTUser.h"

@implementation NTUser

- (instancetype)initWithNickname:(NSString *)nickname andID:(NSInteger)userID {
    if (self = [super init]) {
        self.nickname = nickname;
        self.UID = userID;
    }
    return self;
}

+ (instancetype)userFromObject:(id)object {
    NTUser *user = [[NTUser alloc]initWithNickname:object[@"nickname"] andID:[object[@"id"] integerValue]];
    return user;
}

@end
