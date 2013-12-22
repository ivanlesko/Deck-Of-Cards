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
    
    CGFloat cardWidth   = self.view.layer.bounds.size.width   * 0.8;
    CGFloat cardHeight  = self.view.layer.bounds.size.height  * 0.8;
    CGFloat cardXorigin = (self.view.layer.bounds.size.width  / 2.0) - (cardWidth  / 2.0);
    CGFloat cardYorigin = (self.view.layer.bounds.size.height / 2.0) - (cardHeight / 2.0);
    
    CGRect cardRect = CGRectMake(cardXorigin, cardYorigin, cardWidth, cardHeight);
    
    Card *aCard = [[Card alloc] initWithFrame:cardRect];
    
    [self.view addSubview:aCard];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return TRUE;
}

@end
