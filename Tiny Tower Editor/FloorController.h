//
//  FloorController.h

#import <Foundation/Foundation.h>

@class Floor;
@class FloorTransform;

@interface FloorController : NSObject

@property (nonatomic, retain, readonly) Floor *floor;
- (id)initWithString:(NSString *)floorString;
- (id)initWithFloor:(Floor *)floor;

@end
