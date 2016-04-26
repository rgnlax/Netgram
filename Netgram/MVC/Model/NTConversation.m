//
//  NTConversation.m
//  Netgram
//
//  Created by Maxim Pedchenko on 28.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTConversation.h"
#import "NTMessage.h"
#import "NTAPIManager.h"

@interface NTConversation ()

@property (nonatomic) NSMutableArray *messages;

@end

@implementation NTConversation

- (instancetype)initWithTitle:(NSString *)title andUID:(NSInteger)UID {
    self = [super init];
    
    self.title = title;
    self.UID = UID;
    
    return self;
}

- (void)addMessage:(NTMessage *)message {
    [self.messages addObject:message];
}

- (NSArray *)getMessages {
    return self.messages;
}

- (void)updateMessagesWithCompletion:(void(^)())completion {
    [self.messages removeAllObjects];
    
    [[NTAPIManager manager]getMessagesByConversationID:self.UID completion:^(id objects) {
        self.messages = [NTMessage messagesFromObjects:objects inConversation:self];
        completion();
    }];
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

+ (NSMutableArray *)conversationsFromObjects:(id)objects {
    NSMutableArray *array = [NSMutableArray array];
    
    for (id object in objects) {
        NTConversation *c = [[NTConversation alloc]initWithTitle:object[@"title"] andUID:[object[@"id"] integerValue]];
        [array addObject:c];
    }
    
    return array;
}


@end
