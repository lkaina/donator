//
//  MainViewController.h
//  donation
//
//  Created by Leighton Kaina on 11/2/13.
//  Copyright (c) 2013 Leighton Kaina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharityView.h"
#import "DetailViewController.h"
@class MainViewController;

@protocol MainViewControllerDelegate <NSObject>

- (void)mainViewControllerLoggedOut:(MainViewController *)controller;

@end

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet CharityView  *currentCharityView;
@property (weak, nonatomic) IBOutlet CharityView *nextCharityView;

@property (weak, nonatomic) PFObject *currentCharity;
@property (weak, nonatomic) PFObject *nextCharity;

@property (strong, nonatomic) NSArray *charities;

@property (strong, nonatomic) UISwipeGestureRecognizer *swipeRecognizer;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (weak, nonatomic) IBOutlet UIButton *dataPressed;

@property (weak, nonatomic) id<MainViewControllerDelegate> delegate;

- (IBAction)logoutPressed:(id)sender;
- (IBAction)settingsPressed:(id)sender;
- (IBAction)dataPressed:(id)sender;

@end
