//
//  Owner+CoreDataProperties.h
//  Week3Assessment-Jeremy
//
//  Created by Jeremy Ong on 15/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Owner.h"

NS_ASSUME_NONNULL_BEGIN

@interface Owner (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Properties *> *properties;

@end

@interface Owner (CoreDataGeneratedAccessors)

- (void)addPropertiesObject:(Properties *)value;
- (void)removePropertiesObject:(Properties *)value;
- (void)addProperties:(NSSet<Properties *> *)values;
- (void)removeProperties:(NSSet<Properties *> *)values;

@end

NS_ASSUME_NONNULL_END
