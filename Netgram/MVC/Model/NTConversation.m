//
//  NTConversation.m
//  Netgram
//
//  Created by Maxim Pedchenko on 28.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTConversation.h"
#import "NTMessage.h"

@implementation NTConversation

- (NSArray *)getMessages {
    return nil;
}

- (NSArray *)getUsers {
    return nil;
}

- (NSString *)lastMessage {
    NTMessage *message = (NTMessage *)[[self getMessages]lastObject];
    return [NSString stringWithFormat:@"%@: %@", message.sender.nickname, message.text];
}


@end
