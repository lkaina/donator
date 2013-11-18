//
//  CharityView.m
//  donation
//
//  Created by Leighton Kaina on 11/13/13.
//  Copyright (c) 2013 Leighton Kaina. All rights reserved.
//
#import "OrgView.h"
#import "OrgDetail.h"
#import "CharityView.h"
#import "MainViewController.h"

@implementation CharityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
/*
- (void)orgView:(OrgView *)charity setData:(MainViewController *)controller
{
    self.charity = charity;
    self.orgName.text = charity.name;
    self.orgLocation.text = [NSString stringWithFormat:@"%@, %@", charity.city, charity.state];
    self.orgDescription.text  = charity.textShort;
}

- (void)setDetailData:(DetailViewController *)controller
{
    OrgDetail *charityDetail = self.charity.viewToDetail;
    
    self.orgName.text = self.charity.name;
    self.orgLocation.text = [NSString stringWithFormat:@"%@, %@", self.charity.city, self.charity.state];
    
//    self.siteLink.text = charityDetail.siteLink;
    [self.siteLink setTitle:charityDetail.siteLink forState:UIControlStateNormal];
    [self.donateLink setTitle:charityDetail.donateLink forState:UIControlStateNormal];
    self.detDescription.text = charityDetail.textLong;
}
*/

- (void)orgView:(PFObject *)charity setData:(MainViewController *)controller
{
    self.charity = charity;
    self.orgName.text = charity[@"name"];
    self.orgLocation.text = [NSString stringWithFormat:@"%@, %@", charity[@"city"], charity[@"state"]];
    self.orgDescription.text  = charity[@"textShort"];
    NSURL * imageURL = [NSURL URLWithString:charity[@"icon"]];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    self.orgImage.image = image;
}

- (void)setDetailData:(DetailViewController *)controller
{
    self.orgName.text = self.charity[@"name"];
    self.orgLocation.text = [NSString stringWithFormat:@"%@, %@", self.charity[@"city"], self.charity[@"state"]];
    
    [self.siteLink setTitle:self.charity[@"siteLink"] forState:UIControlStateNormal];
    [self.donateLink setTitle:self.charity[@"donateLink"] forState:UIControlStateNormal];
    self.detDescription.text = self.charity[@"textLong"];
    NSURL * imageURL = [NSURL URLWithString:self.charity[@"icon"]];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    self.icon.image = image;
}

- (IBAction)siteLinkPressed:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.siteLink.currentTitle]];
}

- (IBAction)donateLinkPressed:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.donateLink.currentTitle]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
