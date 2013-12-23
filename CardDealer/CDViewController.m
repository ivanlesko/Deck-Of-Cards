//
//  CDViewController.m
//  CardDealer
//
//  Created by Ivan Lesko on 12/21/13.
//  Copyright (c) 2013 Ivan Lesko. All rights reserved.
//

#import "CDViewController.h"

@interface CDViewController ()

@end

@implementation CDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    deck = [[Deck alloc] init];
    
    [self configureSuitImages];
    [self configureNewCardButtonWithFrame:self.view.bounds];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureSuitImages
{
        // suitImages is a dictionary that contains key-value pairs of images for each suit.
    
    suitImages = @{@"Clubs"    : [UIImage imageNamed:@"rank_clubs.png"],
                   @"Diamonds" : [UIImage imageNamed:@"rank_diamonds"],
                   @"Hearts"   : [UIImage imageNamed:@"rank_hearts"],
                   @"Spades"   : [UIImage imageNamed:@"rank_spades"]};
}

- (BOOL)prefersStatusBarHidden
{
    return TRUE;
}

- (void)configureNewCardButtonWithFrame:(CGRect)frame
{
        // Creates the "New Card" button and places it on the screen.
    
    CGRect newCardRect = CGRectMake(frame.size.width / 2.0 - (frame.size.width / 4.0),
                                    frame.size.height * 0.03,
                                    frame.size.width / 2.0,
                                    50);
    
    UIButton *newCardButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    newCardButton.frame = newCardRect;
    [newCardButton setTitle:@"New Card" forState:UIControlStateNormal];
    newCardButton.titleLabel.font = [UIFont systemFontOfSize:30];
    
    [newCardButton addTarget:self
                action:@selector(newCard)
      forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:newCardButton];
}

- (void)newCard
{
    NSString *newRank = [deck.ranks objectAtIndex:arc4random_uniform([deck.ranks count])];
    NSString *newSuit = [deck.suits objectAtIndex:arc4random_uniform([deck.suits count])];
    
    [currentCard removeFromSuperview];
    currentCard = nil;
    
    // Define some constants for the card frame.
    CGFloat cardWidth   = self.view.layer.bounds.size.width   * 0.7;
    CGFloat cardHeight  = self.view.layer.bounds.size.height  * 0.7;
    CGFloat cardXorigin = (self.view.layer.bounds.size.width  / 2.0) - (cardWidth  / 2.0);
    CGFloat cardYorigin = (self.view.layer.bounds.size.height / 2.0) - (cardHeight / 2.0);
    
    CGRect cardRect = CGRectMake(cardXorigin, cardYorigin, cardWidth, cardHeight);
    
    currentCard = [[Card alloc] initWithRank:newRank andSuit:newSuit andFrame:cardRect];
    currentCard.rankLabel.text = currentCard.rank;
    
    int rankIndex = [deck.ranks indexOfObjectIdenticalTo:currentCard.rank];
    switch (rankIndex) {
            
            // If the card is an Ace.
        case 0:
            currentCard.rankLabel.text = @"A";
            break;
            
            // If the card is a Jack.
        case 10:
            currentCard.rankLabel.text = @"J";
            break;
            
            // If the card is a Queen.
        case 11:
            currentCard.rankLabel.text = @"Q";
            break;
            
            // If the card is a King.
        case 12:
            currentCard.rankLabel.text = @"K";
            break;
            
        default:
            break;
    }
    
    int suitIndex = [deck.suits indexOfObjectIdenticalTo:currentCard.suit];
    if (suitIndex == 0 || suitIndex == 3) {
        // If the card's rank is a Club or Spade, the rank color should be black to match the suit.
        currentCard.rankLabel.textColor = [UIColor blackColor];
    } else {
        // Otherwise, it should be red.
        currentCard.rankLabel.textColor = [UIColor redColor];
    }
    
    currentCard.suitView.image = [suitImages objectForKey:currentCard.suit];
    
    [self.view addSubview:currentCard];
}


@end












