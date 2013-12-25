//
//  CDNewCardViewController.h
//  CardDealer
//
//  Created by Ivan Lesko on 12/22/13.
//  Copyright (c) 2013 Ivan Lesko. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Card.h"
#import "Deck.h"

@interface CDNewCardViewController : UIViewController
{
    NSDictionary *suitImages;
    Deck *deck;
    
    Deck *discardPile;
    
    CGRect  cardRect;
    CGFloat cardSize;
    CGFloat cardWidth;
    
    Card *firstCard;
    int firstCardMoves;
    
    Card *secondCard;
    int secondCardMoves;
    
    UIButton *newCardButton;
    
    __weak IBOutlet UILabel *cardCount;
}

- (void)configureDeck;
- (void)configureNewCardButtonWithFrame:(CGRect)frame;
- (void)configureCardPositions;

- (void)newCard;

- (IBAction)done:(id)sender;

- (IBAction)moveLeft:(id)sender;

@end
