//
//  OrgView.h
//  donation
//
//  Created by Leighton Kaina on 11/10/13.
//  Copyright (c) 2013 Leighton Kaina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface OrgView : NSManagedObject

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * textShort;
@property (nonatomic, retain) NSManagedObject *viewToContact;
@property (nonatomic, retain) NSManagedObject *viewToDetail;
@property (nonatomic, retain) NSManagedObject *viewToDonation;
@property (nonatomic, retain) NSSet *viewToUserOrg;
@end

@interface OrgView (CoreDataGeneratedAccessors)

- (void)addViewToUserOrgObject:(NSManagedObject *)value;
- (void)removeViewToUserOrgObject:(NSManagedObject *)value;
- (void)addViewToUserOrg:(NSSet *)values;
- (void)removeViewToUserOrg:(NSSet *)values;

@end
