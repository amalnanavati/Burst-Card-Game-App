//
//  Card.h
//  Card Game Model
//
//  Created by Chaya Nanavati on 6/15/13.
//  Copyright 2013 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Card : UIView {
@private
    
}
// 0 = diamond, 1 = clubs, 2 = hearts, 3 = spades.  for value, 1= ace (if acehigh = YES, ace = 14) , 11 = jack, 12 = queen, 13 = king
@property (nonatomic) int suit;
@property (nonatomic) int value;
@property (nonatomic) BOOL cardHasBeenPlayed;
@property (nonatomic) int whatPlayerTheCardBelongsTo;
@property (nonatomic, retain) UIImageView *suitImage;
@property(nonatomic, retain) UILabel *valueLabel;

- (id) initWithSuit:(int)suit Value:(int)value;
+ (Card *)cardWithSuit:(int)suit andValue:(int)value;
+ (int) cardWidth;

@end
