//
//  UserOrg.h
//  donation
//
//  Created by Leighton Kaina on 11/10/13.
//  Copyright (c) 2013 Leighton Kaina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OrgView, User;

@interface UserOrg : NSManagedObject

@property (nonatomic, retain) NSNumber * count;
@property (nonatomic, retain) NSNumber * totalAmt;
@property (nonatomic, retain) OrgView *userOrgToOrg;
@property (nonatomic, retain) User *userOrgToUser;

@end
