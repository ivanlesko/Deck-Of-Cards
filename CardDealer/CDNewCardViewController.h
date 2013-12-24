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
    Card *currentCard;
    Deck *deck;
    
    CGRect  cardRect;
    CGPoint offScreenRightPosition;
    CGPoint offScreenLeftPosition;
    
    CGFloat cardSize;
}

- (void)configureSuitImages;
- (void)configureNewCardButtonWithFrame:(CGRect)frame;
- (void)configureCardPositions;

- (void)newCard;

- (void)revealCard;
- (void)hideCard;

- (IBAction)done:(id)sender;

- (IBAction)moveLeft:(id)sender;

@end
