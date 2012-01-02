//
//  Floor.h
//  tinytowers

#import <Foundation/Foundation.h>

@interface Floor : NSObject

@property (nonatomic, readonly) NSUInteger floorNumber;
@property (nonatomic, readonly) NSUInteger level;
@property (nonatomic, readonly) NSUInteger floorType;
@property (nonatomic, readonly) NSInteger awaitingStock;
@property (nonatomic, readonly) NSInteger ptValue;
@property (nonatomic, readonly) NSInteger prValue;
@property (nonatomic, retain, readonly) NSString *stValue;
@property (nonatomic, retain, readonly) NSString *stockLevel;
@property (nonatomic, retain, readonly) NSString *customName;

- (id)initWithDictionary:(NSDictionary *)dict;
- (NSString *)floorAsString;
- (NSDictionary *)objectAsDictionary;
+ (NSDictionary *)emptyFloor;

@end
