//
//  FloorController.m
//  Tiny Tower Editor
//
//  Created by Adam Mclain on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FloorController.h"
#import "Floor.h"
#import "FloorTransform.h"
#import "TransformValue.h"

@interface FloorController ()
@property (nonatomic, retain, readwrite) Floor *floor;
@end

@implementation FloorController

@synthesize floor = m_floor;

- (id)initWithString:(NSString *)floorString {
    self = [super init];
    if (self) {
        NSArray *(^removeLastObject)(NSArray *) = ^(NSArray *anArray){  //TODO put this somewhere reuseable
            NSMutableArray *tempArray = [NSMutableArray arrayWithArray:anArray];
            [tempArray removeObject:[tempArray lastObject]];
            return tempArray;
        };
        
        NSArray *floorAttributesArray = removeLastObject([floorString componentsSeparatedByString:@";"]);
        
        NSMutableDictionary *attributes = [[[NSMutableDictionary alloc] init] autorelease];
        for (NSString *attribute in floorAttributesArray) {
            NSArray *temp = [attribute componentsSeparatedByString:@"="];
            [attributes addEntriesFromDictionary:[NSDictionary dictionaryWithObject:[temp objectAtIndex:1] forKey:[temp objectAtIndex:0]]];
        }
        
        Floor *floor = [[[Floor alloc] initWithDictionary:attributes] autorelease];
        
        if (floor == nil) {
            [super release];
            return nil;
        }
        
        self.floor = floor;
    }
    return self;
}

- (id)initWithFloor:(Floor *)floor {
    
    if (floor == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.floor = floor;
    }
    return self;
}

- (void)dealloc {
    self.floor = nil;
    [super dealloc];
}

- (BOOL)performTransformOnFloor:(FloorTransform *)transform {
    if (transform.floor != self.floor) {
        return NO;
    }
    
    NSDictionary *newFloorDict = [self.floor objectAsDictionary];
    [newFloorDict setValue:transform.requestedValue.value forKey:transform.requestedValue.key];
    Floor *newFloor = [[[Floor alloc] initWithDictionary:newFloorDict] autorelease];
    if (newFloor == nil) {
        return NO;
    }
    
    self.floor = newFloor;
    return YES;
    
}

/*
 - (id)initWithStrings:(NSArray *)floorStrings {
 self = [super init];
 if (self) {
 
 NSArray *(^removeLastObject)(NSArray *) = ^(NSArray *anArray){  //TODO put this somewhere reuseable
 NSMutableArray *tempArray = [NSMutableArray arrayWithArray:anArray];
 [tempArray removeObject:[tempArray lastObject]];
 return tempArray;
 };
 
 NSMutableArray *floors = [[NSMutableArray alloc] init];
 for (NSString *floorString in floorStrings) {
 
 NSArray *floorAttributesArray = [floorString componentsSeparatedByString:@";"];
 floorAttributesArray = removeLastObject(floorAttributesArray);
 
 NSMutableDictionary *attributes = [[[NSMutableDictionary alloc] init] autorelease];
 for (NSString *attribute in floorAttributesArray) {
 NSArray *temp = [attribute componentsSeparatedByString:@"="];
 [attributes addEntriesFromDictionary:[NSDictionary dictionaryWithObject:[temp objectAtIndex:1] forKey:[temp objectAtIndex:0]]];
 }
 
 Floor *floor = [[Floor alloc] initWithDictionary:attributes];
 [floors addObject:floor];
 [floor release];
 }
 
 self.currentFloors = floors;
 [floors release];
 }
 return self;
 }
 */

/*
 - (id)initWithFloors:(NSArray *)floors {
 
 for (id obj in floors) {
 if (![obj isKindOfClass:[Floor class]]) {
 return nil;
 }
 }
 
 self = [super init];
 if (self) {
 self.currentFloors = floors;
 }
 
 return self;
 }
 */


/*


-(BOOL)repplaceFloor:(Floor *)oldFloor withFloor:(Floor *)newFloor {
    if (oldFloor == nil || newFloor == nil) {
        return NO;
    }
    
    NSMutableArray *floors = [NSMutableArray arrayWithArray:self.currentFloors];
    [floors removeObject:oldFloor];
    [floors addObject:newFloor];
    self.currentFloors = floors;
    
    return YES;
}
*/

/*
#warning fix the manual key
#warning should send a message
- (BOOL)buildNewFloor {
    NSNumber *newFloorNumber = [NSNumber numberWithUnsignedInteger:self.count + 1];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[Floor emptyFloor]];
    [dict setValue:newFloorNumber forKey:@"s"];
    Floor *newFloor = [[Floor alloc] initWithDictionary:dict];
    
    NSMutableArray *floors = [NSMutableArray arrayWithArray:self.currentFloors];
    [floors addObject:newFloor];
    self.currentFloors = floors;
    [newFloor release];
    
    return YES;
}

#warning need to check if floor is an appartment
#warning fix the manual key
#warning should send a message
- (BOOL)clearFloorAtStory:(NSUInteger)story {
    Floor *oldFloor = [self floorAtStory:story];
    if (oldFloor == nil) {
        return NO;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[Floor emptyFloor]];
    [dict setValue:[NSNumber numberWithUnsignedInteger:story] forKey:@"s"];
    Floor *newFloor = [[Floor alloc] initWithDictionary:dict];
    
    [self repplaceFloor:oldFloor withFloor:newFloor];
    [newFloor release];
    
    return YES;
}

- (BOOL)moveFloor:(Floor *)floor toStory:(NSUInteger)story {
    if (story > self.currentFloors.count || story == 1) {
        return NO;
    }
    
    if (![self.currentFloors containsObject:floor]) {
        return NO;
    }
    
    if (floor.level == story) {
        return YES;
    }
    
    int intStart = floor.floorNumber;
    int intEnd = story;
    int increment = intEnd > intStart ? -1 : 1;
    int smallStory = MIN(intStart, intEnd);
    int bigStory = MAX(intStart, intEnd);
    
    //make the new floor we're moving
    NSMutableDictionary *newFloorDict = [NSMutableDictionary dictionaryWithDictionary:[floor objectAsDictionary]];
    [newFloorDict setValue:[NSNumber numberWithUnsignedInteger:story] forKey:@"s"];
    Floor *newFloor = [[Floor alloc] initWithDictionary:newFloorDict];
    
    //create the array we'll iterate through
    NSMutableArray *floors = [NSMutableArray arrayWithArray:self.currentFloors];
    [floors removeObject:floor];
    //can't change a mutable array we're iteraing through so set up another array
    NSArray *tempFloors = [NSArray arrayWithArray:floors];
    for (Floor *tempFloor in tempFloors) {
        if (tempFloor.floorNumber >= smallStory && tempFloor.floorNumber <= bigStory) {
            NSMutableDictionary *tempFloorDict = [NSMutableDictionary dictionaryWithDictionary:[tempFloor objectAsDictionary]];
            [tempFloorDict setValue:[NSNumber numberWithUnsignedInteger:tempFloor.floorNumber + increment] forKey:@"s"];
            Floor *newTempFloor = [[Floor alloc] initWithDictionary:tempFloorDict];
            [self repplaceFloor:tempFloor withFloor:newTempFloor];
            [newTempFloor release];
        }
    }
    
    [self repplaceFloor:floor withFloor:newFloor];
    [newFloor release];
    
    return YES;
    
}
*/

@end
