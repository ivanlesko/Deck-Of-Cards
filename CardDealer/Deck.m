//
//  Deck.m
//  DeckOfCards
//
//  Created by Ivan Lesko on 12/16/13.
//  Copyright (c) 2013 Ivan Lesko. All rights reserved.
//

#import "Deck.h"

@implementation Deck

- (id)init
{
    self = [super init];
    if (self) {
        self.ranks = @[@"Ace",
                       @"2",
                       @"3",
                       @"4",
                       @"5",
                       @"6",
                       @"7",
                       @"8",
                       @"9",
                       @"10",
                       @"Jack",
                       @"Queen",
                       @"King"];
        
        self.suits = @[@"Clubs",
                       @"Diamonds",
                       @"Hearts",
                       @"Spades"];
        
        self.cards = [NSMutableArray array];
    }
    
    return self;
}

- (void)addCardToDeck:(Card *)theCard
{
    [self.cards addObject:theCard];
}

- (NSString *)description
{
    return self.cards.description;
}

@end
