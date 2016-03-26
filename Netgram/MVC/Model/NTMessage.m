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

- (instancetype)initWithText:(NSString *)text sender:(NTUser *)sender inConversation:(NTConversation *)conversation {
    if (self = [super init]) {
        self.text = text;
        self.sender = sender;
        
        self.conversation = conversation;
        [self.conversation addMessage:self];
        
        self.date = [NSDate date];
        self.UID = [text hash] - [self.date hash];
    }
    return self;
}

@end
