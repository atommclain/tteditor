//
//  Tower.h

#import <Foundation/Foundation.h>

@interface Tower : NSObject
@property (nonatomic, readonly) NSUInteger coins;
@property (nonatomic, readonly) NSUInteger bux;
@property (nonatomic, readonly) NSUInteger paint;
@property (nonatomic, readonly) NSUInteger elevatorSpeed;
@property (nonatomic, readonly) NSUInteger tip;
@property (nonatomic, retain, readonly) NSArray *achievements;
@property (nonatomic, retain, readonly) NSArray *costumes;
@property (nonatomic, retain, readonly) NSArray *missions;

- (id)initWithDictionary:(NSDictionary *)dict;
- (id)initWithString:(NSString *)str;
- (NSString *)towerAsString;
@end
