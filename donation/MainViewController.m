//
//  MainViewController.m
//  donation
//
//  Created by Leighton Kaina on 11/2/13.
//  Copyright (c) 2013 Leighton Kaina. All rights reserved.
//

#import <Parse/Parse.h>
#import "MainViewController.h"
#import "AppDelegate.h"
#import "OrgView.h"
#import "OrgDetail.h"
#import "OrgContact.h"
#import "OrgDonation.h"
#import "User.h"
#import "UserOrg.h"
#import "UserDonation.h"

@interface MainViewController ()

@end

@implementation MainViewController

{
    NSMutableArray *_images;
    BOOL _animationDone;
    int _counter;
    PFUser *_currentUser;
}

@synthesize charities;
@synthesize managedObjectContext;
//@synthesize fetchedResultsController = _fetchedResultsController;

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
    self.navigationController.navigationBarHidden = NO;
    _counter = 0;
    _currentUser = [PFUser currentUser];
    
    self.currentCharityView.layer.zPosition = 2;
    self.nextCharityView.layer.zPosition = 1;
    
    PFQuery *orgQuery = [PFQuery queryWithClassName:@"OrgView"];
    
    [orgQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d charities.", objects.count);
            self.charities = objects;
            for (PFObject *object in objects) {
                //NSLog(@"%@", object.objectId);
            }
            PFObject *orgView = [self.charities objectAtIndex:_counter];
            self.currentCharity = orgView;
            [self.currentCharityView orgView:orgView setData:self];
            _counter++;
            orgView = [self.charities objectAtIndex:_counter];
            self.nextCharity = orgView;
            [self.nextCharityView orgView:orgView setData:self];
            self.nextCharityView.alpha = 0.0;
            _animationDone = YES;
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    /*
    //fetch data
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"OrgView" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.charities = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    */
    
    //create swipe recognizers
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    
    self.currentCharityView.orgImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    tapRecognizer.delegate = self;
    tapRecognizer.numberOfTapsRequired = 2;
    [self.currentCharityView.orgImage addGestureRecognizer:tapRecognizer];
    
    //add images for testing
//    UIImage *reece01 = [UIImage imageNamed:@"Reece_Baseball01.jpg"];
//    UIImage *reece02 = [UIImage imageNamed:@"Reece_Baseball02.jpg"];
    /*
    NSURL * imageURL = [NSURL URLWithString:@"https://s3-us-west-1.amazonaws.com/leigimontestimg/testimg/Reece_Baseball01_small.jpg"];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *reece01 = [UIImage imageWithData:imageData];

    imageURL = [NSURL URLWithString:@"https://s3-us-west-1.amazonaws.com/leigimontestimg/testimg/Reece_Baseball02_small.jpg"];
    imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *reece02 = [UIImage imageWithData:imageData];
    
    _images = [NSMutableArray arrayWithObjects:reece01, reece02, nil];
    
    
    //set first view
    //OrgView *orgView = [self.charities objectAtIndex:_counter];
    PFObject *orgView = [self.charities objectAtIndex:_counter];
    [self.currentCharityView orgView:orgView setData:self];
    //self.currentCharityView.orgImage.image = _images[_counter];
    _counter++;
    
//    [self fetchNewResults];
    
    //set next view
    orgView = [self.charities objectAtIndex:_counter];
    [self.nextCharityView orgView:orgView setData:self];
    //self.nextCharityView.orgImage.image = _images[_counter];
    self.nextCharityView.alpha = 0.0;
    
    _animationDone = YES;
    */
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
/*
- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"OrgView" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:1];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:nil];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}
 
 - (void)fetchNewResults
 {
 NSError *error;
 if (![[self fetchedResultsController] performFetch:&error]) {
 // Update to handle the error appropriately.
 NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
 exit(-1);  // Fail
 }
 
 self.charities = [_fetchedResultsController fetchedObjects];
 
 }
*/
- (IBAction)swipeHandler:(UISwipeGestureRecognizer *)recognizer
{
    if (_animationDone) {
        _animationDone = NO;
        [self cycleView:recognizer];
    }
}

- (IBAction)tapHandler:(UITapGestureRecognizer *)recognizer
{
    DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailViewController.managedObjectContext = self.managedObjectContext;
    
    [detailViewController setCharity:self.currentCharityView.charity];
    [self.navigationController pushViewController:detailViewController animated:NO];
    [UIView transitionWithView:self.navigationController.view duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
}

- (void)cycleView:(UISwipeGestureRecognizer *)recognizer
{
    CGPoint location = self.currentCharityView.center;
    CGPoint initial = location;
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"left swipe");
        location.x -= 220.0;
    } else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"right swipe");
        [self addDonation];
        location.x += 220.0;
    }
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.currentCharityView.center = location;
                         self.currentCharityView.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.5
                                          animations:^{
                                              self.nextCharityView.alpha = 1.0;
                                          }
                                          completion:^(BOOL finished){
                                              //reposition hidden 'currentView'
                                              self.currentCharityView.center = initial;
                                              //swap data from nextView to currentView
                                              [self swapViewElements:self.nextCharityView toCharity:self.currentCharityView];
                                              self.currentCharity = self.nextCharity;
                                              self.nextCharityView.alpha = 0.0;
                                              self.currentCharityView.alpha = 1.0;
                                              
                                              _counter++;
                                              if (_counter > [self.charities count] - 1){
                                                  _counter = 0;
                                              }
                                              
                                              PFObject *orgView = [self.charities objectAtIndex:_counter];
                                              [self.nextCharityView orgView:orgView setData:self];
                                              self.nextCharity = orgView;
                                              _animationDone = YES;
                                          
                                          }];
                     }];

}

- (void)addDonation
{
    //update join table
    PFQuery *query = [PFQuery queryWithClassName:@"UserOrg"];
    [query whereKey:@"user" equalTo:_currentUser];
    [query whereKey:@"org" equalTo:self.currentCharity];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (error) {
            //create new join entry
            PFObject *object = [PFObject objectWithClassName:@"UserOrg"];
            object[@"user"] = _currentUser;
            object[@"org"] = self.currentCharity;
            [object incrementKey:@"donation" byAmount:@2];
            
            //update charity
            [self.currentCharity incrementKey:@"orgDonation" byAmount:@2];
            
            //update currentUser
            [_currentUser incrementKey:@"userDonation" byAmount:@2];
            
            [self.currentCharity saveInBackground];
            [_currentUser saveInBackground];
            [object saveInBackground];

            NSLog(@"Successfully created new record.");
        } else {
            //update join table
            [object incrementKey:@"donation" byAmount:@2];
            
            //update charity
            [self.currentCharity incrementKey:@"orgDonation" byAmount:@2];
            
            //update currentUser
            [_currentUser incrementKey:@"userDonation" byAmount:@2];
            
            [self.currentCharity saveInBackground];
            [_currentUser saveInBackground];
            [object saveInBackground];
                            
            NSLog(@"Successfully retrieved the object.");
        }
    }];
}

- (void)swapViewElements:(CharityView *)fromCharity toCharity:(CharityView *)toCharity
{
    toCharity.charity = fromCharity.charity;
    toCharity.orgName.text = fromCharity.orgName.text;
    toCharity.orgLocation.text = fromCharity.orgLocation.text;
    toCharity.orgDescription.text = fromCharity.orgDescription.text;
    toCharity.orgImage.image = fromCharity.orgImage.image;
}

- (IBAction)logoutPressed:(id)sender
{
    [PFUser logOut];
    [self.delegate mainViewControllerLoggedOut:self];    
}

- (IBAction)settingsPressed:(id)sender
{
    //TODO implement settings
}

/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"mainToData"]) {

    }
}
*/

@end
