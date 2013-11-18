//
//  DetailViewController.h
//  donation
//
//  Created by Leighton Kaina on 11/13/13.
//  Copyright (c) 2013 Leighton Kaina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "CharityView.h"

@interface DetailViewController : UIViewController


@property (weak, nonatomic) IBOutlet CharityView *charityView;
@property (weak, nonatomic) PFObject *charity;

@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end
