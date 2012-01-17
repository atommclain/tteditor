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
- (id)initWithString:(NSString *)floorString;
- (id)initWithFloor:(Floor *)floor;
- (BOOL)performTransformOnFloor:(FloorTransform *)transform;

@end
