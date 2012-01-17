//
//  BitizenController.h

#import <Foundation/Foundation.h>

@interface BitizenController : NSObject

@property (nonatomic, retain, readonly) NSArray *allBitizens;

- (id)initWithStrings:(NSArray *)strings;
- (id)initWithBitizens:(NSArray *)bitizens;

//- (NSArray *)bitizensAtStory:(NSUInteger)story;

@end
