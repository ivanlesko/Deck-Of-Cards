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

- (id)initWithRank:(NSString *)theRank andSuit:(NSString *)theSuit andFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.rank = theRank;
        self.suit = theSuit;
        
        self.backgroundColor = [UIColor whiteColor];
        
            // You only need to adjust the
        
        // Create the frame for the suit label and alloc/init it.
        CGFloat suitLabelXorigin = 0;
        CGFloat suitLabelYorigin = frame.size.height * 0.15;
        CGFloat suitLabelWidth   = frame.size.width;
        CGFloat suitLabelHeight  = frame.size.height * 0.35;
        
        CGRect suitFrame = CGRectMake(suitLabelXorigin,
                                      suitLabelYorigin,
                                      suitLabelWidth,
                                      suitLabelHeight);
        
        self.rankLabel = [[UILabel alloc] initWithFrame:suitFrame];
        self.rankLabel.backgroundColor = [UIColor clearColor];
        self.rankLabel.textColor       = [UIColor redColor];
        self.rankLabel.textAlignment   = NSTextAlignmentCenter;
        self.rankLabel.font            = [UIFont systemFontOfSize:suitLabelHeight];
        
        // Create the frame for the rank label and alloc/init it.
        
        CGFloat rankLabelWidth   = suitLabelWidth;
        CGFloat rankLabelHeight  = suitLabelHeight;
        CGFloat rankLabelXorigin = suitLabelXorigin;
        CGFloat rankLabelYorigin = suitLabelYorigin + suitLabelHeight;
        
        CGRect rankFrame = CGRectMake(rankLabelXorigin,
                                      rankLabelYorigin,
                                      rankLabelWidth,
                                      rankLabelHeight);
        
        self.suitView = [[UIImageView alloc] initWithFrame:rankFrame];
        self.suitView.backgroundColor = [UIColor clearColor];
        self.suitView.contentMode = UIViewContentModeScaleAspectFit;
        
        
        [self addSubview:self.rankLabel];
        [self addSubview:self.suitView];
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
    
    CGContextStrokeRectWithWidth(context, rect, 4.0);
}

@end










