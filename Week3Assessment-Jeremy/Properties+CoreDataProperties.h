//
//  Properties+CoreDataProperties.h
//  Week3Assessment-Jeremy
//
//  Created by Jeremy Ong on 15/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Properties.h"

NS_ASSUME_NONNULL_BEGIN

@interface Properties (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *price;
@property (nullable, nonatomic, retain) NSString *location;
@property (nullable, nonatomic, retain) NSManagedObject *owner;

@end

NS_ASSUME_NONNULL_END
