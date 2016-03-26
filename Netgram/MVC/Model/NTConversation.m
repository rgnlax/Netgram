//
//  NTConversation.m
//  Netgram
//
//  Created by Maxim Pedchenko on 28.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTConversation.h"
#import "NTMessage.h"

@interface NTConversation ()

@property (nonatomic) NSMutableArray *messages;

@end

@implementation NTConversation

- (void)addMessage:(NTMessage *)message {
    [self.messages addObject:message];
}

- (NSArray *)getMessages {
    return [self.messages copy];
}

- (NSArray *)getUsers {
    return nil;
}

- (NSString *)lastMessage {
    NTMessage *message = (NTMessage *)[[self getMessages]lastObject];
    NSString *result = message ? [NSString stringWithFormat:@"%@: %@", message.sender.nickname, message.text] : @"No messages yet...";
    return result;
}

- (NSMutableArray *)messages {
    if (!_messages) {
        _messages = [[NSMutableArray alloc]init];
    }
    return _messages;
}


@end
