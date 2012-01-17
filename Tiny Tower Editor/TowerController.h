//
//  TowerController.h

#import <Foundation/Foundation.h>

@class Tower;
@class Floor;

@interface TowerController : NSObject

@property (nonatomic, retain, readonly) Tower *tower;

- (id)initWithString:(NSString *)str;
- (NSUInteger)numberOfFloors;
- (Floor *)floorAtStory:(NSUInteger)story;
@end
