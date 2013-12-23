//
//  Card.h
//  DeckOfCards
//
//  Created by Ivan Lesko on 12/16/13.
//  Copyright (c) 2013 Ivan Lesko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : UIView

@property (nonatomic, strong) NSString *suit;
@property (nonatomic, strong) NSString *rank;

@property (nonatomic, strong) UILabel *rankLabel;
@property (nonatomic, strong) UIImageView *suitView;

- (id)initWithRank:(NSString *)theRank andSuit:(NSString *)theSuit andFrame:(CGRect)frame;

@end
