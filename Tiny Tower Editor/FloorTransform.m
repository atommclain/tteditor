//
//  FloorTransform.m

#import "FloorTransform.h"
#import "Floor.h"
#import "TransformValue.h"

@interface FloorTransform ()
@property (nonatomic, retain, readwrite) Floor *floor;
@property (nonatomic, retain, readwrite) TransformValue *oldValue;
@property (nonatomic, retain, readwrite) TransformValue *requestedValue;
@end

@implementation FloorTransform
@synthesize floor = m_floor;
@synthesize oldValue = m_oldValue;
@synthesize requestedValue = m_requestedValue;

- (id)initWithFloor:(Floor *)floor newFloorNumberTransform:(NSUInteger)newFloorNumber {
    
    if ([self init]) {
        self.floor = floor;
        TransformValue *oldValue = [[[TransformValue alloc] initWithKey:@"l" value:[NSNumber numberWithUnsignedInteger:floor.floorNumber]] autorelease];

        self.oldValue = oldValue;
        TransformValue *requestedValue = [[[TransformValue alloc] initWithKey:@"l" value:[NSNumber numberWithUnsignedInteger:newFloorNumber]] autorelease];
        self.requestedValue = requestedValue;
    }
    return self;
}

- (void)dealloc {
    self.floor = nil;
    self.oldValue = nil;
    self.requestedValue = nil;
    [super dealloc];
}


@end
