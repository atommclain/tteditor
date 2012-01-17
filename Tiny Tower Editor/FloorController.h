//
//  FloorController.h
//  Tiny Tower Editor
//
//  Created by Adam Mclain on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Floor;
@class FloorTransform;

@interface FloorController : NSObject

@property (nonatomic, retain, readonly) Floor *floor;
//- (id)initWithStrings:(NSArray *)floorStrings;
- (id)initWithString:(NSString *)floorString;
//- (id)initWithFloors:(NSArray *)floors;
- (id)initWithFloor:(Floor *)floor;
//- (NSString *)floorsAsString;


//- (Floor *)floorAtStory:(NSUInteger)story;
//- (BOOL)buildNewFloor;
//- (BOOL)clearFloorAtStory:(NSUInteger)story;
- (BOOL)clearFloor;
//- (BOOL)moveFloor:(Floor *)floor toStory:(NSUInteger)story;
- (BOOL)performTransformOnFloor:(FloorTransform *)transform;

@end
