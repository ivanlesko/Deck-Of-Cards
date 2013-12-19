//
//  main.m
//  DeckOfCards
//
//  Created by Ivan Lesko on 12/16/13.
//  Copyright (c) 2013 Ivan Lesko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Deck.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Deck *theDeck = [[Deck alloc] init];
        
        int rankCounter = 0;
        
        for (int ranks = 0; ranks < 13; ranks ++) {
                for (int suits = 0; suits < 4; suits++) {
                    Card *aCard = [[Card alloc] initWithRank:[theDeck.ranks objectAtIndex:rankCounter] andSuit:[theDeck.suits objectAtIndex:suits]];
            
                    [theDeck addCardToDeck:aCard];
                }
            
            rankCounter++;
        }
        
        NSLog(@"The Deck: %@", theDeck);
    }
    return 0;
}



