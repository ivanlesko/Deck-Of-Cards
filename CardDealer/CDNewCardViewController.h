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
}

- (void)configureSuitImages;
- (void)configureNewCardButtonWithFrame:(CGRect)frame;

- (void)newCard;

- (void)hideCard;

- (IBAction)done:(id)sender;

@end
