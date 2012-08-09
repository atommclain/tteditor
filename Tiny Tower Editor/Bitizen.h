//
//  Bitzen.h


#import <Foundation/Foundation.h>

@interface Bitizen : NSObject
@property (nonatomic, readonly) NSUInteger homeFloor;
@property (nonatomic, readonly) NSInteger workFloor;
@property (nonatomic, readonly) NSUInteger dreamJobID;
@property (nonatomic) NSUInteger sValue; //serial?
@property (nonatomic) NSUInteger vsValue;
@property (nonatomic, retain, readonly) NSString *costume;

- (id)initWithDictionary:(NSDictionary *)dict;
- (id)initWithString:(NSString *)str;
- (NSDictionary *)objectAsDictionary;
- (NSString *)bitizenAsString;

@end
