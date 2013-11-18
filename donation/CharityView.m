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
        self.orgDescription.layer.borderWidth = 1.0f;
        self.orgDescription.layer.backgroundColor = [[UIColor grayColor] CGColor];
        self.orgDescription.layer.cornerRadius = 5.0f;
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
    self.orgName.layer.borderWidth = 1.0f;
    self.orgName.layer.borderColor = [[UIColor colorWithWhite:0.5f alpha:0.8f] CGColor];
    self.orgName.layer.backgroundColor  = [[UIColor colorWithWhite:1.0f alpha:0.8f] CGColor];
    self.orgName.layer.cornerRadius = 5;
   
    self.orgLocation.layer.borderWidth = 1.0f;
    self.orgLocation.layer.borderColor = [[UIColor colorWithWhite:0.5f alpha:0.8f] CGColor];
    self.orgLocation.layer.backgroundColor = [[UIColor colorWithWhite:1.0f alpha:0.8f] CGColor];
    self.orgLocation.layer.cornerRadius = 5;
                                           
   self.orgDescription.layer.borderWidth = 1.0f;
   self.orgDescription.layer.borderColor = [[UIColor colorWithWhite:0.5f alpha:0.8f] CGColor];
   self.orgDescription.layer.backgroundColor  = [[UIColor colorWithWhite:1.0f alpha:0.8f] CGColor];
   self.orgDescription.layer.cornerRadius = 5;
    
    self.charity = charity;
    self.orgName.text = charity[@"name"];
    self.orgLocation.text = [NSString stringWithFormat:@"%@, %@", charity[@"city"], charity[@"state"]];
    self.orgDescription.text  = charity[@"textShort"];
    NSURL * imageURL = [NSURL URLWithString:charity[@"image"]];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    self.orgImage.image = image;
}

- (void)setDetailData:(DetailViewController *)controller
{
    self.detDescription.layer.borderWidth = 1.0f;
    self.detDescription.layer.borderColor = [[UIColor grayColor] CGColor];
    
    
    self.orgName.text = self.charity[@"name"];
    self.orgLocation.text = [NSString stringWithFormat:@"%@, %@", self.charity[@"city"], self.charity[@"state"]];
    
    [self.siteLink setTitle:self.charity[@"siteLink"] forState:UIControlStateNormal];
    [self.donateLink setTitle:@"Donate directly" forState:UIControlStateNormal];
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
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.charity[@"donateLink"]]];
}

- (void)configureCharityView
{

}

- (void)configureDetailView
{
    
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
