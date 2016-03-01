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

@end
