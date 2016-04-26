//
//  NTAuthViewController.m
//  Netgram
//
//  Created by Maxim Pedchenko on 07.03.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import "NTAuthViewController.h"
#import "NTAPIManager.h"
#import <QuartzCore/QuartzCore.h>

@interface NTAuthViewController ()

@property (weak) IBOutlet NSTextField *nicknameTextField;
@property (weak) IBOutlet NSProgressIndicator *activityIndicator;

@end

@implementation NTAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setWantsLayer:YES];
    self.view.layer.backgroundColor = [NSColor colorWithCalibratedWhite:1 alpha:1].CGColor;
    self.nicknameTextField.delegate = self;
}

#pragma mark - NTAuthViewController Presenting

- (void)presentInViewController:(NSViewController *)viewController withDelegate:(id<NTAuthViewControllerDelegate>)delegate {
    self.authDelegate = delegate;
    
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    self.view.autoresizingMask = NSViewHeightSizable | NSViewWidthSizable;
    self.view.frame = viewController.view.frame;
    
    [viewController.view addSubview:self.view];
    [viewController addChildViewController:self];
}

- (void)dismissAuthViewController {
    self.authDelegate = nil;
    
    __weak NSView *view = self.view;
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 0.3;
        context.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        view.animator.alphaValue = 0;
    }
    completionHandler:^{
        [view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

- (void)showActivityIndicator {
    self.activityIndicator.hidden = false;
    [self.activityIndicator startAnimation:nil];
}

#pragma mark - NSTextField Delegate

- (void)controlTextDidEndEditing:(NSNotification *)notification {
    if ([[[notification userInfo] objectForKey:@"NSTextMovement"] intValue] == NSReturnTextMovement) {
        NSString *nickname = self.nicknameTextField.stringValue;
        if (nickname.length > 0) {
            [[NTAPIManager manager]loginWithNickname:nickname completion:^(id object){
                [self.authDelegate authViewController:self didFinishWithObject:object];
            }];
            [self showActivityIndicator];
        }
    }
}

@end
