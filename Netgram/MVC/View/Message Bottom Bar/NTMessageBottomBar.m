//
//  NTMessageBottomBar.m
//  Netgram
//
//  Created by Maxim Pedchenko on 03.03.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTMessageBottomBar.h"
#import "NTTextField.h"

@interface NTMessageBottomBar()

@property (nonatomic, weak) IBOutlet NSButton *sendButton;
@property (nonatomic, weak) IBOutlet NTTextField *messageTextField;

@end

@implementation NTMessageBottomBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.sendButton.enabled = false;
}

- (NSString *)messageText {
    return self.messageTextField.stringValue;
}

#pragma mark - NTMessageBottomBar Lifecycle

- (void)controlTextDidChange:(NSNotification *)obj {
    self.sendButton.enabled = [self messageText].length > 0 ? true : false;
}

- (IBAction)onSendButton:(id)sender {
    [self.sendDelegate messageBottomBar:self sendActionWithMessage:[self messageText]];
    [self messageDidSend];

}

- (void)controlTextDidEndEditing:(NSNotification *)notification {
    if ([[[notification userInfo] objectForKey:@"NSTextMovement"] intValue] == NSReturnTextMovement) {
        [self.sendDelegate messageBottomBar:self sendActionWithMessage:[self messageText]];
        [self messageDidSend];
    }
}

- (void)messageDidSend {
    [self trim];
    [[NSSound soundNamed:@"Pop"]play];
}

- (void)trim {
    [self.messageTextField clear];
    self.sendButton.enabled = false;
}


@end
