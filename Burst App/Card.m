//
//  Card.m
//  Card Game Model
//
//  Created by Chaya Nanavati on 6/15/13.
//  Copyright 2013 Stanford University. All rights reserved.
//

#import "Card.h"
#import <QuartzCore/QuartzCore.h>

@implementation Card
@synthesize suit = _suit;
@synthesize value = _value;
@synthesize cardHasBeenPlayed = _cardHasBeenPlayed;
@synthesize whatPlayerTheCardBelongsTo = _whatPlayerTheCardBelongsTo;
@synthesize suitImage = _suitImage;
@synthesize valueLabel = _valueLabel;

int cardWidth = 46;

// 0 = diamond, 1 = clubs, 2 = hearts, 3 = spades.  for value, 1= ace (if acehigh = YES, ace = 14) , 11 = jack, 12 = queen, 13 = king

- (UIImageView *)suitImage {
    //lazy instantiation of suitImage
    if (_suitImage == nil) _suitImage = [[[UIImageView alloc] init] autorelease];
    return _suitImage;
}

- (UILabel *)valueLabel {
    //lazy instantiation of suitImage
    if (_valueLabel == nil) _valueLabel = [[[UILabel alloc] init] autorelease];
    return _valueLabel;
}

- (id) initWithSuit:(int)suit Value:(int)value {
    self = [super initWithFrame:CGRectMake(0, 0, cardWidth, cardWidth/2.25*3.5)];
    if (self) { 
        self.suit = suit;
        self.value = value;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1.0;
        
        switch (self.suit) {
            case 0:
                [self.suitImage setImage:[UIImage imageNamed:@"Diamond.png"]];
                [self.suitImage setFrame:CGRectMake((self.frame.size.width/2 - self.suitImage.image.size.width/11.2), (self.frame.size.height/2 - self.suitImage.image.size.height/11.2), self.suitImage.image.size.width/5.6, self.suitImage.image.size.height/5.6)];
                break;
            case 1:
                [self.suitImage setImage:[UIImage imageNamed:@"Club.png"]];
                [self.suitImage setFrame:CGRectMake((self.frame.size.width/2 - self.suitImage.image.size.width/11.2), (self.frame.size.height/2 - self.suitImage.image.size.height/11.2), self.suitImage.image.size.width/5.6, self.suitImage.image.size.height/5.6)];
                break;
            case 2:
                [self.suitImage setImage:[UIImage imageNamed:@"Heart.png"]];
                [self.suitImage setFrame:CGRectMake((self.frame.size.width/2 - self.suitImage.image.size.width/11.2), (self.frame.size.height/2 - self.suitImage.image.size.height/11.2), self.suitImage.image.size.width/5.6, self.suitImage.image.size.height/5.6)];
                break;
            case 3:
                [self.suitImage setImage:[UIImage imageNamed:@"Spade.png"]];
                [self.suitImage setFrame:CGRectMake((self.frame.size.width/2 - self.suitImage.image.size.width/11.2), (self.frame.size.height/2 - self.suitImage.image.size.height/11.2), self.suitImage.image.size.width/5.6, self.suitImage.image.size.height/5.6)];
                break;
            default:
                break;
        }
        [self addSubview:self.suitImage];
        self.valueLabel.backgroundColor = [UIColor clearColor];
        //self.valueLabel.font = [UIFont systemFontOfSize:24.0];
        self.valueLabel.textAlignment = UITextAlignmentCenter;
        self.valueLabel.adjustsFontSizeToFitWidth = YES;
        self.valueLabel.frame = CGRectMake(self.frame.size.width/5 - 17.25/2, self.frame.size.height/5 - 17.25/2, 17.25, 17.25);
        switch (self.value) {
            case 11:
                self.valueLabel.text = @"J";
                break;
            case 12:
                self.valueLabel.text = @"Q";
                break;
            case 13:
                self.valueLabel.text = @"K";
                break;
            case 14:
                self.valueLabel.text = @"A";
                break;
            default:
                self.valueLabel.text = [NSString stringWithFormat:@"%d", self.value];
                break;
        }
        [self addSubview:self.valueLabel];
        UILabel *secondValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(4*self.frame.size.width/5 - 17.25/2, 4*self.frame.size.height/5 - 17.25/2, 17.25, 17.25)];
        secondValueLabel.backgroundColor = [UIColor clearColor];
        //secondValueLabel.font = [UIFont systemFontOfSize:24.0];
        secondValueLabel.textAlignment = UITextAlignmentCenter;
        secondValueLabel.adjustsFontSizeToFitWidth = YES;
        secondValueLabel.text = self.valueLabel.text;
        [self addSubview:secondValueLabel];
        [secondValueLabel release];
    }
    return self;
}

- (void)dealloc
{
    [self setSuitImage:nil];
    [self setValueLabel:nil];
    [super dealloc];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", [NSValue valueWithCGPoint:CGPointMake(self.suit, self.value)]];
}

+ (Card *)cardWithSuit:(int)suit andValue:(int)value {
    Card *card = [[[self alloc] init] autorelease];
    card.suit = suit;
    card.value = value;
    NSLog(@"card = %@", card);
    return card;
}

-(BOOL) isEqual:(id)object {
    if (self.suit == [(Card *)object suit] && self.value == [(Card *)object value]) {
        return YES;
    } else {
        return NO;
    }
}

+ (int) cardWidth {
    return cardWidth;
}


@end
