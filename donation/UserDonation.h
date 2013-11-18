//
//  UserDonation.h
//  donation
//
//  Created by Leighton Kaina on 11/10/13.
//  Copyright (c) 2013 Leighton Kaina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface UserDonation : NSManagedObject

@property (nonatomic, retain) NSDate * firstDonation;
@property (nonatomic, retain) NSDate * latestDonation;
@property (nonatomic, retain) NSNumber * totalAmount;
@property (nonatomic, retain) User *donationToUser;

@end
