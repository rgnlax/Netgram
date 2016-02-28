//
//  NTMessage.h
//  Netgram
//
//  Created by Maxim Pedchenko on 28.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTConversation.h"
#import "NTUser.h"

@interface NTMessage : NSObject

@property (nonatomic, assign) NTConversation *conversation;
@property (nonatomic, assign) NTUser *sender;
@property (nonatomic) NSInteger UID;
@property (nonatomic) NSString *text;
@property (nonatomic) NSDate *date;

+ (NSArray *)getMessagesByConversation:(NTConversation *)conversation offset:(NSInteger)offset limit:(NSInteger)limit;

@end