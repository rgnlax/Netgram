//
//  NTAPIManager.h
//  Netgram
//
//  Created by Maxim Pedchenko on 26.04.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NTMessage;

@interface NTAPIManager : NSObject

+ (instancetype)manager;

- (void)loginWithNickname:(NSString *)nickname completion:(void(^)(id object))completion;
- (void)getConversationsByUserID:(NSInteger)userID completion:(void(^)(id objects))completion;
- (void)getMessagesByConversationID:(NSInteger)conversationID completion:(void(^)(id objects))completion;
- (void)sendMessage:(NTMessage *)message completion:(void(^)())completion;

@end
