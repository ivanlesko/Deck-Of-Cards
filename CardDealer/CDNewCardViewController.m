//
//  CDNewCardViewController.m
//  CardDealer
//
//  Created by Ivan Lesko on 12/22/13.
//  Copyright (c) 2013 Ivan Lesko. All rights reserved.
//

#import "CDNewCardViewController.h"

@interface CDNewCardViewController ()

@end

@implementation CDNewCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureCardPositions];
    [self configureDeck];
    [self configureNewCardButtonWithFrame:self.view.bounds];
    
    cardCount.text = [NSString stringWithFormat:@"Cards: %d", deck.cards.count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureDeck
{
    // suitImages is a dictionary that contains key-value pairs of images for each suit.
    suitImages = @{@"Clubs"    : [UIImage imageNamed:@"rank_clubs.png"],
                   @"Diamonds" : [UIImage imageNamed:@"rank_diamonds"],
                   @"Hearts"   : [UIImage imageNamed:@"rank_hearts"],
                   @"Spades"   : [UIImage imageNamed:@"rank_spades"]};
    
    deck = [[Deck alloc] init];
    
    // A rank counter used to iterate the for loop.
    int rankCounter = 0;
    
    // This for loop runs 52 times.
    // 13 times for each rank (Ace - King).
    // 4 times for each suit (Clubs, Diamonds, Hearts, Spades).
    for (int ranks = 0; ranks < deck.ranks.count; ranks ++) {
        for (int suits = 0; suits < deck.suits.count; suits++) {
            Card *aCard = [[Card alloc] initWithRank:[deck.ranks objectAtIndex:rankCounter] andSuit:[deck.suits objectAtIndex:suits] andFrame:cardRect];
            aCard.rankLabel.text = aCard.rank;
            aCard.suitView.image = [suitImages objectForKey:aCard.suit];
            aCard.layer.anchorPoint = CGPointMake(0.5, 0.5);
            
            int firstCardRankIndex = [deck.ranks indexOfObjectIdenticalTo:aCard.rank];
            switch (firstCardRankIndex) {
                
                    // If the card is an Ace.
                case 0:
                    aCard.rankLabel.text = @"A";
                    break;
                    
                    // If the card is a Jack.
                case 10:
                    aCard.rankLabel.text = @"J";
                    break;
                    
                    // If the card is a Queen.
                case 11:
                    aCard.rankLabel.text = @"Q";
                    break;
                    
                    // If the card is a King.
                case 12:
                    aCard.rankLabel.text = @"K";
                    break;
                    
                default:
                    break;
            }
            
            int firstCardSuitIndex = [deck.suits indexOfObjectIdenticalTo:aCard.suit];
            if (firstCardSuitIndex == 0 || firstCardSuitIndex == 3) {
                // If the card's rank is a Club or Spade, the rank color should be black to match the suit.
                aCard.rankLabel.textColor = [UIColor blackColor];
            } else {
                // Otherwise, it should be red.
                aCard.rankLabel.textColor = [UIColor redColor];
            }
            
            aCard.layer.position = CGPointMake(aCard.layer.position.x + self.view.bounds.size.width,
                                               aCard.layer.position.y);
            
            [deck addCardToDeck:aCard];
        }
        rankCounter++;
    }
    
    newCardButton.enabled = YES;
    
    /******************************************************************
     *********** REMEMBER TO IMPLEMENT THE DISCARD PILE ***************
     *****************************************************************/
    
    // This discard pile will hold cards that are removed from the deck.
    discardPile = [[Deck alloc] init];
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
    
    newCardButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    newCardButton.frame = newCardRect;
    [newCardButton setTitle:@"Draw Card" forState:UIControlStateNormal];
    newCardButton.titleLabel.font = [UIFont systemFontOfSize:30];
    
    [newCardButton addTarget:self
                      action:@selector(newCard)
            forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:newCardButton];
}

- (void)configureCardPositions
{
    cardSize = 0.7; // This variable will determine how wide the card appears in the view.
    
    cardWidth           = self.view.layer.bounds.size.width   * cardSize;
    CGFloat cardHeight  = self.view.layer.bounds.size.height  * cardSize;
    CGFloat cardXorigin = (self.view.layer.bounds.size.width  / 2.0) - (cardWidth  / 2.0);
    CGFloat cardYorigin = (self.view.layer.bounds.size.height / 2.0) - (cardHeight / 2.0);
    
    cardRect = CGRectMake(cardXorigin,
                          cardYorigin,
                          cardWidth,
                          cardHeight);
}

- (void)newCard
{
    // Only display a new card if the deck is not empty.
    if (deck.cards.count != 0) {
        // If only the second card exists
        if (!firstCard && secondCard) {
            [self moveCardLeft:secondCard];
            secondCardMoves++;
            
            firstCard = [[deck cards] objectAtIndex:arc4random_uniform(deck.cards.count)];
            [[deck cards] removeObject:firstCard];
            
            [self.view addSubview:firstCard];
            [self moveCardLeft:firstCard];
            firstCardMoves++;
        }
    
        // If the first card exists, but the second one does not.
        // Create the second one
        if (firstCard && !secondCard) {
            secondCard = [[deck cards] objectAtIndex:arc4random_uniform(deck.cards.count)];
            [[deck cards] removeObject:secondCard];
            
            // Move the second card into view.
            [self.view addSubview:secondCard];
            [self moveCardLeft:secondCard];
            secondCardMoves++;
            
            // Also move the first rectangle out of view
            [self moveCardLeft:firstCard];
            firstCardMoves++;
        }
    
        // If no card exists on the screen yet
        // Create the first one and push it to the left.
        if (!firstCard && !secondCard) {
            firstCard = [[deck cards] objectAtIndex:arc4random_uniform(deck.cards.count)];
            [[deck cards] removeObject:firstCard];
            
            [self.view addSubview:firstCard];
            [self moveCardLeft:firstCard];
            firstCardMoves++;
        }
    }
    
    cardCount.text = [NSString stringWithFormat:@"Cards: %d", deck.cards.count];
    
    newCardButton.enabled = NO;
    
    if (deck.cards.count == 0) {
        [self configureDeck];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    newCardButton.enabled = YES;
    
    if (firstCardMoves == 2) {
        [firstCard removeFromSuperview];
        firstCard = nil;
        firstCardMoves = 0;
    }
    
    if (secondCardMoves == 2) {
        [secondCard removeFromSuperview];
        secondCard = nil;
        secondCardMoves = 0;
    }
}

- (void)moveCardLeft:(UIView *)theView
{
    CGPoint newPos = CGPointMake(theView.layer.position.x - self.view.bounds.size.width, theView.layer.position.y);
    
    CABasicAnimation *moveLeft = [CABasicAnimation animationWithKeyPath:@"position"];
    moveLeft.delegate  = self;
    moveLeft.fromValue = [NSValue valueWithCGPoint:theView.layer.position];
    moveLeft.toValue   = [NSValue valueWithCGPoint:newPos];
    moveLeft.beginTime = 0;
    moveLeft.duration  = 1;
    moveLeft.speed     = 3;
    moveLeft.fillMode  = kCAFillModeBackwards;
    moveLeft.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    moveLeft.removedOnCompletion = NO;
    
    [theView.layer addAnimation:moveLeft forKey:nil];
    
    theView.layer.position = newPos;
}

- (IBAction)done:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)moveLeft:(id)sender
{
    firstCard.layer.position = CGPointMake(firstCard.layer.position.x - 40, firstCard.layer.position.y);
}

@end















