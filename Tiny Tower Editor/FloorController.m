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

@end
