//
//  LoginViewController.m
//  donation
//
//  Created by Leighton Kaina on 11/2/13.
//  Copyright (c) 2013 Leighton Kaina. All rights reserved.
//

#import <Parse/Parse.h>
#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = YES;
    self.inputUsername.delegate = self;
    self.inputPassword.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//go to next text field on return
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.inputUsername) {
        [self.inputPassword becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
        [self loginPressed:self];
    }
    return NO;
}

//hide keyboard if tapped outside
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UIView * txt in self.view.subviews){
        if ([txt isKindOfClass:[UITextField class]]) {
            [txt resignFirstResponder];
        }
    }
}

- (IBAction)loginPressed:(id)sender
{
    [PFUser logInWithUsernameInBackground:self.inputUsername.text password:self.inputPassword.text block:^(PFUser *user, NSError *error) {
        if (user) {
            [self.delegate loginViewController:self verifiedLogin:self.inputUsername.text];
        } else {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
}

- (void)registerViewController:(RegisterViewController *)controller verifiedRegister:(NSString *)username
{
    [self.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    [self.delegate loginViewController:self verifiedLogin:username];
}

- (void)returnToLogin:(RegisterViewController *)controller
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"loginToRegister"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

@end
