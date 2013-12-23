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
    
    deck = [[Deck alloc] init];
    
    [self configureSuitImages];
    [self configureNewCardButtonWithFrame:self.view.bounds];
    
    CGFloat cardWidth   = self.view.layer.bounds.size.width   * 0.7;
    CGFloat cardHeight  = self.view.layer.bounds.size.height  * 0.7;
    CGFloat cardXorigin = (self.view.layer.bounds.size.width  / 2.0) - (cardWidth  / 2.0);
    CGFloat cardYorigin = (self.view.layer.bounds.size.height / 2.0) - (cardHeight / 2.0);
    
    cardRect = CGRectMake(cardXorigin,
                          cardYorigin,
                          cardWidth,
                          cardHeight);
    
    offScreenLeftPosition  = CGPointMake(cardXorigin - cardWidth, cardYorigin);
    offScreenRightPosition = CGPointMake(cardXorigin + cardWidth, cardYorigin);
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
    [self hideCard];
    
    // Define some constants for the card frame.
    CGFloat cardWidth   = self.view.layer.bounds.size.width   * 0.7;
    CGFloat cardHeight  = self.view.layer.bounds.size.height  * 0.7;
    CGFloat cardXorigin = (self.view.layer.bounds.size.width  / 2.0) - (cardWidth  / 2.0);
    CGFloat cardYorigin = (self.view.layer.bounds.size.height / 2.0) - (cardHeight / 2.0);
    
    CGRect cardRect = CGRectMake(cardXorigin, cardYorigin, cardWidth, cardHeight);
    
    NSString *newRank = [deck.ranks objectAtIndex:arc4random_uniform([deck.ranks count])];
    NSString *newSuit = [deck.suits objectAtIndex:arc4random_uniform([deck.suits count])];
    
    NSLog(@"step 4");
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

- (void)hideCard
{
    if (currentCard) {
        
        CABasicAnimation *hide = [CABasicAnimation animationWithKeyPath:@"position"];
        hide.fromValue = [NSValue valueWithCGPoint:currentCard.layer.position];
        hide.toValue   = [NSValue valueWithCGPoint:offScreenLeftPosition];
        
        CAAnimationGroup *anims = [CAAnimationGroup animation];
        anims.animations = [NSArray arrayWithObjects:hide, nil];
        anims.duration   = 1;
        anims.speed      = 2;
        anims.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        anims.fillMode   = kCAFillModeForwards;
        anims.removedOnCompletion = NO;
        
        [currentCard.layer addAnimation:anims forKey:nil];
        
        currentCard.layer.position = hiddenPosition;
        
        CGPoint offScreenPositionRight = CGPointMake(self.view.bounds.size.width + currentCard.layer.bounds.size.width, currentCard.layer.position.y);
        
        CABasicAnimation *reveal = [CABasicAnimation animationWithKeyPath:@"position"];
        reveal.fromValue = [NSValue valueWithCGPoint:offScreenPositionRight];
        reveal.toValue   = [NSValue valueWithCGPoint:currentCard.layer.position];
        
        CAAnimationGroup *revealAnims = [CAAnimationGroup animation];
        revealAnims.duration = 3;
        revealAnims.fillMode = kCAFillModeForwards;
        revealAnims.removedOnCompletion = NO;
        
        [currentCard.layer addAnimation:revealAnims forKey:nil];
        
        currentCard.layer.position = hiddenPosition;
        currentCard = nil;
        
        NSLog(@"step 4");
        
    } else {
        return;
    }
}

- (void)showCard
{
    CGPoint hiddenPosition = CGPointMake(self.view.bounds.size.width + currentCard.layer.bounds.size.width, currentCard.layer.position.y);
    
    CABasicAnimation *reveal = [CABasicAnimation animationWithKeyPath:@"position"];
    reveal.fromValue = [NSValue valueWithCGPoint:hiddenPosition];
    reveal.toValue   = [NSValue valueWithCGPoint:currentCard.layer.position];
    
    CAAnimationGroup *anims = [CAAnimationGroup animation];
    anims.duration = 3;
    anims.fillMode = kCAFillModeForwards;
    anims.removedOnCompletion = NO;
    
    [currentCard.layer addAnimation:anims forKey:nil];
    
    currentCard.layer.position = hiddenPosition;
}

- (IBAction)done:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end















