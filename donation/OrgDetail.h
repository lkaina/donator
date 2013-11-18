//
//  OrgDetail.h
//  donation
//
//  Created by Leighton Kaina on 11/10/13.
//  Copyright (c) 2013 Leighton Kaina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OrgContact, OrgView;

@interface OrgDetail : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * donateLink;
@property (nonatomic, retain) NSString * siteLink;
@property (nonatomic, retain) NSString * textLong;
@property (nonatomic, retain) OrgContact *detailToContact;
@property (nonatomic, retain) NSManagedObject *detailToDonation;
@property (nonatomic, retain) OrgView *detailToView;

@end
