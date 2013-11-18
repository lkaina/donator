//
//  RegisterViewController.h
//  donation
//
//  Created by Leighton Kaina on 11/2/13.
//  Copyright (c) 2013 Leighton Kaina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@class RegisterViewController;

@protocol RegisterViewControllerDelegate <NSObject>

- (void)registerViewController:(RegisterViewController *)controller verifiedRegister:(NSString *)username;
- (void)returnToLogin:(RegisterViewController *)controller;

@end

@interface RegisterViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *toLoginButton;

@property (weak, nonatomic) id<RegisterViewControllerDelegate> delegate;

- (IBAction)signUpPressed:(id)sender;
- (IBAction)toLoginPressed:(id)sender;

@end
