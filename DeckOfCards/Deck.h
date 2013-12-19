//
//  Deck.h
//  DeckOfCards
//
//  Created by Ivan Lesko on 12/16/13.
//  Copyright (c) 2013 Ivan Lesko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

@interface Deck : NSObject

@property (nonatomic, strong) NSMutableArray *cards;

@property (nonatomic, strong) NSArray *ranks;
@property (nonatomic, strong) NSArray *suits;

- (void)addCardToDeck:(Card *)theCard;

@end
