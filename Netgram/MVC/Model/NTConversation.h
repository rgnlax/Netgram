//
//  NTConversation.h
//  Netgram
//
//  Created by Maxim Pedchenko on 28.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTMessage.h"
#import "NTUser.h"

@class NTMessage;

@interface NTConversation : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSInteger UID;

- (instancetype)initWithTitle:(NSString *)title andUID:(NSInteger)UID;

- (void)addMessage:(NTMessage *)message;
- (NSArray *)getMessages;
- (NSString *)lastMessage;
- (NSArray *)getUsers;
+ (NSMutableArray *)conversationsFromObjects:(id)objects;
- (void)updateMessagesWithCompletion:(void(^)())completion;

@end
