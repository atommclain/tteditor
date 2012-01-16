//
//  FloorTransform.h

#import <Foundation/Foundation.h>

@class Floor;
@class TransformValue;

@interface FloorTransform : NSObject

@property (nonatomic, retain, readonly) Floor *floor;
@property (nonatomic, retain, readonly) TransformValue *oldValue;
@property (nonatomic, retain, readonly) TransformValue *requestedValue; //can't use 'newVlaue'

- (id)initWithFloor:(Floor *)floor newFloorNumberTransform:(NSUInteger)newFloorNumber;

@end
