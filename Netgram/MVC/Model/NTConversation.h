//
//  NTConversation.h
//  Netgram
//
//  Created by Maxim Pedchenko on 28.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTConversation : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger UID;

- (NSArray *)getMessages;
- (NSString *)lastMessage;
- (NSArray *)getUsers;

@end
