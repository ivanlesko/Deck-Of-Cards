//
//  Card.h
//  DeckOfCards
//
//  Created by Ivan Lesko on 12/16/13.
//  Copyright (c) 2013 Ivan Lesko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic, strong) NSString *suit;
@property (nonatomic, strong) NSString *rank;

- (id)initWithRank:(NSString *)theRank andSuit:(NSString *)theSuit;

@end
