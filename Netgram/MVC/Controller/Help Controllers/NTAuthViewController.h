//
//  NTAuthViewController.h
//  Netgram
//
//  Created by Maxim Pedchenko on 07.03.16.
//  Copyright © 2016 MP. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class NTAuthViewController;

@protocol NTAuthViewControllerDelegate

@optional
- (void)authViewController:(NTAuthViewController *)controller didFinishWithName:(NSString *)name;

@end

@interface NTAuthViewController : NSViewController<NSTextFieldDelegate>

@property (nonatomic) id<NTAuthViewControllerDelegate>authDelegate;
- (void)presentInViewController:(NSViewController *)viewController withDelegate:(id<NTAuthViewControllerDelegate>)delegate;
- (void)dismissAuthViewController;

@end
