//
//  Card.m
//  DeckOfCards
//
//  Created by Ivan Lesko on 12/16/13.
//  Copyright (c) 2013 Ivan Lesko. All rights reserved.
//

#import "Card.h"

@implementation Card

- (id)init
{
    self = [super init];
    if (self) {
        self.rank = @"Rank";
        self.suit = @"Suit";
    }
    
    return self;
}

- (id)initWithRank:(NSString *)theRank andSuit:(NSString *)theSuit
{
    self = [super init];
    if (self) {
        self.rank = theRank;
        self.suit = theSuit;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
            // Create the frame for the suit label and alloc/init it.
        CGFloat labelWidth   = 100;
        CGFloat labelHeight  = 175;
        CGFloat labelXorigin = (frame.size.width  / 2.0) - (labelWidth  / 2.0);
        CGFloat suitRectYorigin = frame.size.height * .1;
        
        CGRect suitFrame = CGRectMake(labelXorigin,
                                     suitRectYorigin,
                                     labelWidth,
                                     labelHeight);
        
        self.suitLabel = [[UILabel alloc] initWithFrame:suitFrame];
        self.suitLabel.backgroundColor = [UIColor clearColor];
        self.suitLabel.textColor       = [UIColor redColor];
        self.suitLabel.textAlignment   = NSTextAlignmentCenter;
        self.suitLabel.font            = [UIFont systemFontOfSize:140];
        self.suitLabel.text = @"A";
        
            // Create the frame for the rank label and alloc/init it.
        
        CGFloat rankRectYorigin = frame.size.height * 0.9 - labelHeight;
        
        CGRect rankFrame = CGRectMake(labelXorigin,
                                       rankRectYorigin,
                                       labelWidth,
                                       labelHeight);
        
        self.rankView = [[UIImageView alloc] initWithFrame:rankFrame];
        self.rankView.backgroundColor = [UIColor redColor];
        
        [self addSubview:self.suitLabel];
        [self addSubview:self.rankView];
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ of %@", self.rank, self.suit];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *whiteColor = [UIColor whiteColor];
    UIColor *blackColor = [UIColor blackColor];
    
    CGContextSetFillColorWithColor(context, whiteColor.CGColor);
    CGContextSetStrokeColorWithColor(context, blackColor.CGColor);

    CGContextFillRect(context, rect);
    CGContextStrokeRectWithWidth(context, rect, 4);
}

@end
