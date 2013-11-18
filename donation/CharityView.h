//
//  CharityView.h
//  donation
//
//  Created by Leighton Kaina on 11/13/13.
//  Copyright (c) 2013 Leighton Kaina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@class MainViewController;
@class DetailViewController;
@class OrgView;

@interface CharityView : UIView
//main view elements
@property (weak, nonatomic) IBOutlet UILabel *orgName;
@property (weak, nonatomic) IBOutlet UILabel *orgLocation;
@property (weak, nonatomic) IBOutlet UITextView *orgDescription;
@property (weak, nonatomic) IBOutlet UIImageView *orgImage;

@property (weak, nonatomic) IBOutlet UIButton *siteLink;
@property (weak, nonatomic) IBOutlet UIButton *donateLink;
@property (weak, nonatomic) IBOutlet UITextView *detDescription;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) PFObject *charity;
//@property (weak, nonatomic) OrgView *charity;
//detail view elements

//- (void)orgView:(OrgView *)charity setData:(MainViewController *)controller;
- (void)orgView:(PFObject *)charity setData:(MainViewController *)controller;
- (void)setDetailData:(DetailViewController *)controller;
- (void)configureCharityView;
- (void)configureDetailView;

- (IBAction)siteLinkPressed:(id)sender;
- (IBAction)donateLinkPressed:(id)sender;

@end
