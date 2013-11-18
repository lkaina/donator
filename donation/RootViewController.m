//
//  RootViewController.m
//  donation
//
//  Created by Leighton Kaina on 11/2/13.
//  Copyright (c) 2013 Leighton Kaina. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "RegisterViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

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
     self.navigationController.navigationBarHidden = YES;
    LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    loginViewController.delegate = self;
    [self.navigationController pushViewController:loginViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    /*
    PFUser *user = [PFUser currentUser];
    if (!user) {
        LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        loginViewController.delegate = self;
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginViewController:(LoginViewController *)controller verifiedLogin:(NSString *)username
{
    [self.navigationController popViewControllerAnimated:NO];
    MainViewController *mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    mainViewController.managedObjectContext = self.managedObjectContext;
    mainViewController.delegate = self;
    [self.navigationController pushViewController:mainViewController animated:YES];
}

- (void)mainViewControllerLoggedOut:(MainViewController *)controller
{
    [self.navigationController popViewControllerAnimated:NO];
    self.navigationController.navigationBarHidden = YES;
    LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    loginViewController.delegate = self;
    [self.navigationController pushViewController:loginViewController animated:YES];
}

@end
