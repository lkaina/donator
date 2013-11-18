//
//  OrgContact.h
//  donation
//
//  Created by Leighton Kaina on 11/10/13.
//  Copyright (c) 2013 Leighton Kaina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OrgView;

@interface OrgContact : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSManagedObject *contactToDetail;
@property (nonatomic, retain) NSManagedObject *contactToDonation;
@property (nonatomic, retain) OrgView *contactToView;

@end
