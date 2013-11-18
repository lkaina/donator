//
//  User.h
//  donation
//
//  Created by Leighton Kaina on 11/10/13.
//  Copyright (c) 2013 Leighton Kaina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSManagedObject *userToDonation;
@property (nonatomic, retain) NSSet *userToUserOrg;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addUserToUserOrgObject:(NSManagedObject *)value;
- (void)removeUserToUserOrgObject:(NSManagedObject *)value;
- (void)addUserToUserOrg:(NSSet *)values;
- (void)removeUserToUserOrg:(NSSet *)values;

@end
