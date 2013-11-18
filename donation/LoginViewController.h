//
//  LoginViewController.h
//  donation
//
//  Created by Leighton Kaina on 11/2/13.
//  Copyright (c) 2013 Leighton Kaina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "RegisterViewController.h"

@class LoginViewController;

@protocol LoginViewControllerDelegate <NSObject>

- (void)loginViewController:(LoginViewController *)controller verifiedLogin:(NSString *)username;

@end

@interface LoginViewController : UIViewController <RegisterViewControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *myTitle;
@property (weak, nonatomic) IBOutlet UITextField *inputUsername;
@property (weak, nonatomic) IBOutlet UITextField *inputPassword;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) id<LoginViewControllerDelegate> delegate;

- (IBAction)loginPressed:(id)sender;

@end
