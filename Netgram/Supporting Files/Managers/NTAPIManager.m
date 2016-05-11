//
//  NTAPIManager.m
//  Netgram
//
//  Created by Maxim Pedchenko on 26.04.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTAPIManager.h"
#import "NTSessionManager.h"
#import "NTMessage.h"
#import <NSHash/NSString+NSHash.h>
#import <AFNetworking.h>

@interface NTAPIManager ()

@property (nonatomic) NSString *baseUrl;
@property (nonatomic) AFHTTPSessionManager *manager;

@end

@implementation NTAPIManager

#pragma mark - NTAPIManager Singleton

+ (instancetype)manager {
    static NTAPIManager *sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [[self alloc] init];
    });
    return sessionManager;
}

- (instancetype)init {
    if (self = [super init]) {
        self.baseUrl = @"http://159.203.172.93/";
        self.manager = [AFHTTPSessionManager manager];

    }
    return self;
}

#pragma mark - NTAPIManager Methods

- (void)loginWithNickname:(NSString *)nickname completion:(void(^)(id object))completion {
    NSString *url = [self.baseUrl stringByAppendingString:@"login/"];
    
    [self.manager POST:url parameters:@{@"nickname":nickname} progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        completion(responseObject[@"user"]);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (void)getConversationsByUserID:(NSInteger)userID completion:(void (^)(id objects))completion {
    NSString *url = [self.baseUrl stringByAppendingString:@"conversations/"];
    
    [self.manager GET:url parameters:@{@"sender": [NSNumber numberWithInt:userID]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)getMessagesByConversationID:(NSInteger)conversationID completion:(void (^)(id objects))completion {
    NSString *url = [self.baseUrl stringByAppendingString:@"message/"];
    
    [self.manager GET:url parameters:@{@"conversation": [NSNumber numberWithInt:conversationID]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)sendMessage:(NTMessage *)message completion:(void (^)())completion {
    NSString *url = [self.baseUrl stringByAppendingString:@"message/"];

    [self.manager POST:url parameters:@{@"text":message.text,
                                        @"date":[NSNumber numberWithInt:[message.date timeIntervalSince1970]],
                                        @"conversation_id": [NSNumber numberWithInt:message.conversation.UID],
                                        @"sender_id": [NSNumber numberWithInt:message.sender.UID],
                                        @"checksum": [message.text MD5]}
              progress:nil
               success:^(NSURLSessionTask *task, id responseObject) {
                   completion();
               }
               failure:^(NSURLSessionTask *operation, NSError *error) {
                   NSLog(@"Error: %@", error);
    }];
}

@end
