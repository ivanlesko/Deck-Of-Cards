//
//  CDViewController.h
//  CardDealer
//
//  Created by Ivan Lesko on 12/21/13.
//  Copyright (c) 2013 Ivan Lesko. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Deck.h"
#import "Card.h"

@interface CDViewController : UIViewController
{
    NSDictionary *suitImages;
    Card *currentCard;
    Deck *deck;
}

- (void)configureSuitImages;
- (void)configureNewCardButtonWithFrame:(CGRect)frame;

- (void)newCard;

@end
