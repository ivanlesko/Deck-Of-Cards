//
//  Card.m
//  DeckOfCards
//
//  Created by Ivan Lesko on 12/16/13.
//  Copyright (c) 2013 Ivan Lesko. All rights reserved.
//

#import "Card.h"

@implementation Card

- (id)init
{
    self = [super init];
    if (self) {
        self.rank = @"Rank";
        self.suit = @"Suit";
    }
    
    return self;
}

- (id)initWithRank:(NSString *)theRank andSuit:(NSString *)theSuit
{
    self = [super init];
    if (self) {
        self.rank = theRank;
        self.suit = theSuit;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ of %@", self.rank, self.suit];
}

@end
