//
//  OrgDataViewController.h
//  donation
//
//  Created by Leighton Kaina on 11/2/13.
//  Copyright (c) 2013 Leighton Kaina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface OrgDataViewController : UIViewController <CPTBarPlotDataSource, CPTBarPlotDelegate>

@property (weak, nonatomic) IBOutlet UILabel *noDataLabel;

@property (weak, nonatomic) IBOutlet UILabel *loadLabelOrg;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadSpinOrg;

@property (weak, nonatomic) IBOutlet UILabel *orgName;
@property (weak, nonatomic) IBOutlet UILabel *orgDonationAmount;
@property (weak, nonatomic) IBOutlet UILabel *colorBox;

- (IBAction)donePressed:(id)sender;

@end
