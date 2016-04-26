//
//  NTMessage.m
//  Netgram
//
//  Created by Maxim Pedchenko on 28.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTMessage.h"

@implementation NTMessage

+ (NSArray *)getMessagesByConversation:(NTConversation *)conversation offset:(NSInteger)offset limit:(NSInteger)limit {
    return nil;
}

- (NSString *)prettyDateString {
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH:mm"];
    
    return [timeFormat stringFromDate:self.date];
}


- (instancetype)initWithText:(NSString *)text sender:(NTUser *)sender id:(NSInteger)ID date:(NSDate *)date inConversation:(NTConversation *)conversation {
    if (self = [super init]) {
        self.text = text;
        self.sender = sender;
        self.UID = ID;
        
        self.conversation = conversation;
        [self.conversation addMessage:self];
        
        self.date = date;
    }
    return self;
}

+ (NSMutableArray *)messagesFromObjects:(id)objects inConversation:(NTConversation *)conversation {
    NSMutableArray *array = [NSMutableArray array];
    
    for (id object in objects) {
        NTMessage *m = [[NTMessage alloc]initWithText:object[@"text"]
                                               sender:[NTUser userFromObject:object[@"sender"]]
                                                   id:[object[@"id"] integerValue]
                                                 date:[NSDate dateWithTimeIntervalSince1970:[object[@"date"] integerValue]]
                                       inConversation:conversation];
        [array addObject:m];
    }

    return array;
}

@end
