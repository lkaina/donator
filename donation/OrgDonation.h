//
//  OrgDonation.h
//  donation
//
//  Created by Leighton Kaina on 11/10/13.
//  Copyright (c) 2013 Leighton Kaina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OrgContact, OrgDetail, OrgView;

@interface OrgDonation : NSManagedObject

@property (nonatomic, retain) NSDate * firstDonation;
@property (nonatomic, retain) NSDate * latestDonation;
@property (nonatomic, retain) NSNumber * totalAmount;
@property (nonatomic, retain) OrgContact *donationToContact;
@property (nonatomic, retain) OrgDetail *donationToDetail;
@property (nonatomic, retain) OrgView *donationToView;

@end
