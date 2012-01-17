//
//  BitizenController.h

#import <Foundation/Foundation.h>

@interface BitizenController : NSObject

@property (nonatomic, readonly) NSArray *allBitizens;

- (id)initWithStrings:(NSArray *)strings;
- (id)initWithBitizens:(NSArray *)bitizens;
- (NSString *)bitizensAsString;

- (NSArray *)bitizensAtStory:(NSUInteger)story;

@end
