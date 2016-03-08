//
//  NTUser.h
//  Netgram
//
//  Created by Maxim Pedchenko on 28.02.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTUser : NSObject

@property (nonatomic) NSInteger UID;
@property (nonatomic) NSString *nickname;

- (instancetype)initWithNickname:(NSString *)nickname;

@end
