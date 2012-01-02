//
//  FloorController.h
//  Tiny Tower Editor
//
//  Created by Adam Mclain on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Floor;

@interface FloorController : NSObject

- (id)initWithStrings:(NSArray *)floorStrings;
- (id)initWithFloors:(NSArray *)floors;
- (NSString *)floorsAsString;

- (NSArray *)allFloors;
- (NSUInteger)count;
- (Floor *)floorAtStory:(NSUInteger)story;
- (BOOL)buildNewFloor;
- (BOOL)clearFloorAtStory:(NSUInteger)story;
- (BOOL)moveFloor:(Floor *)floor toStory:(NSUInteger)story;

@end
