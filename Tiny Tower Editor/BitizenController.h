//
//  BitizenController.h
//  Tiny Tower Editor
//
//  Created by Adam Mclain on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BitizenController : NSObject

@property (nonatomic, readonly) NSArray *allBitizens;

- (id)initWithStrings:(NSArray *)strings;
- (id)initWithBitizens:(NSArray *)bitizens;
- (NSString *)bitizensAsString;

- (NSArray *)bitizensAtStory:(NSUInteger)story;

@end
