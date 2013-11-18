//
//  RootViewController.h
//  donation
//
//  Created by Leighton Kaina on 11/2/13.
//  Copyright (c) 2013 Leighton Kaina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "MainViewController.h"

@class RootViewController;

@protocol RootViewControllerDelegate <NSObject>

- (void)rootViewController:(RootViewController *)controller didLogIn:(NSString *)user;

@end

@interface RootViewController : UIViewController <LoginViewControllerDelegate, MainViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
