//
//  NTUser.m
//  Netgram
//
//  Created by Maxim Pedchenko on 28.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTUser.h"

@implementation NTUser

- (instancetype)initWithNickname:(NSString *)nickname {
    if (self = [super init]) {
        self.nickname = nickname;
        self.UID = [nickname hash] - [[NSDate date]hash];
    }
    return self;
}

@end
