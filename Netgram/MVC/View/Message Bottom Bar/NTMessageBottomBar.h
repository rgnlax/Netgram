//
//  NTBottomBar.h
//  Netgram
//
//  Created by Maxim Pedchenko on 03.03.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTFooterView.h"
@class NTMessageBottomBar;

@protocol NTMessageBottomBarSendDelegate

@optional
- (void)messageBottomBar:(NTMessageBottomBar *)bottomBar sendActionWithMessage:(NSString *)message;

@end

@interface NTMessageBottomBar : NTFooterView

@property (nonatomic) id<NTMessageBottomBarSendDelegate>sendDelegate;

- (void)trim;
- (NSString *)messageText;

@end
