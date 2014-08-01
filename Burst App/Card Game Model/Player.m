//
//  Player.m
//  Card Game Model
//
//  Created by Chaya Nanavati on 6/15/13.
//  Copyright 2013 Stanford University. All rights reserved.
//

#import "Player.h"


@implementation Player
@synthesize name = _name;
@synthesize currentHand = _currentHand;
@synthesize tricksTaken = _tricksTaken;
//@synthesize numberOfCards = _numberOfCards;
@synthesize bid = _bid;
@synthesize score = _score;
@synthesize typeOfPlayer = _typeOfPlayer;
@synthesize haveIBidYetForTheNewRound = _haveIBidYetForTheNewRound;
@synthesize numberOfTricksTaken = _numberOfTricksTaken;
@synthesize haveIPlayedYetForTheNewTrick = _haveIPlayedYetForTheNewTrick;

- (NSString *)name {
    //lazy instantiation of name
    if (_name == nil) _name = [[NSString alloc] init];
    return _name;
}

- (NSMutableArray *)currentHand {
    //lazy instantiation of currentHand
    if (_currentHand == nil) _currentHand = [[NSMutableArray alloc] init];
    return _currentHand;
}

- (NSMutableArray *)tricksTaken {
    //lazy instantiation of tricksTaken
    if (_tricksTaken == nil) _tricksTaken = [[NSMutableArray alloc] init];
    return _tricksTaken;
}

- (void) setHaveIBidYetForTheNewRound:(BOOL)haveIBidYetForTheNewRound {
    _haveIBidYetForTheNewRound = haveIBidYetForTheNewRound;
    //NSLog(@"%@'s haveibidyetforthisround = %d", self.name, _haveIBidYetForTheNewRound);
}

- (BOOL) haveIBidYetForTheNewRound {
    //NSLog(@"%@'s haveibidyetforthisround = %d", self.name, _haveIBidYetForTheNewRound);
    return _haveIBidYetForTheNewRound;
}

- (id)initWithType:(PlayerType)type
{
    self = [super init];
    if (self) {
        self.typeOfPlayer = type;
        self.haveIBidYetForTheNewRound = NO;
        self.haveIPlayedYetForTheNewTrick = NO;
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Name: %@, Type:%d, Hand: %@", self.name, self.typeOfPlayer, self.currentHand];
}

- (void) arrangeBySuit {
    
    NSSortDescriptor *suitDescriptor = [[NSSortDescriptor alloc] initWithKey:@"suit" ascending:YES];
    NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"value" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:suitDescriptor, valueDescriptor, nil];
    self.currentHand = [NSMutableArray arrayWithArray:[self.currentHand sortedArrayUsingDescriptors:sortDescriptors]];
    
    [suitDescriptor release];
    [valueDescriptor release];
    
    NSLog(@"%@'s Current Hand = %@", self.name, self.currentHand);
}

- (void) arrangebyValue {
    NSSortDescriptor *suitDescriptor = [[NSSortDescriptor alloc] initWithKey:@"suit" ascending:YES];
    NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"value" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:valueDescriptor, suitDescriptor, nil];
    self.currentHand = [NSMutableArray arrayWithArray:[self.currentHand sortedArrayUsingDescriptors:sortDescriptors]];
    
    [suitDescriptor release];
    [valueDescriptor release];
    
    NSLog(@"%@'s Current Hand = %@", self.name, self.currentHand);
}

- (Card *) cardToBePlayedWithStartingSuit:(NSMutableArray *)currentTrick andTrump:(int)trump andtricksTakenPerPlayer:(NSArray *)tricksTakenPerPlayer andBidArray:(NSMutableArray *)bidsArray {
    Card *tempCard = [[[Card alloc] init] autorelease];
    if (self.typeOfPlayer == PlayerTypeAICardPlayToWinHand) {
        // add into this AI, if cannot win hand, play lowest playable card
        
        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"value" ascending:NO];
        if ([currentTrick count] > 0) {
        if ([[self.currentHand filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d", [[currentTrick objectAtIndex:0] suit]]] count] != 0) {
            
            tempCard = [[[self.currentHand filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d", [[currentTrick objectAtIndex:0] suit]]] sortedArrayUsingDescriptors:[NSArray arrayWithObject:valueDescriptor]] objectAtIndex:0];
        } else {
        
            if ([[self.currentHand filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d", trump]] count] != 0) {    
            
                tempCard = [[[self.currentHand filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d", trump]] sortedArrayUsingDescriptors:[NSArray arrayWithObject:valueDescriptor]] objectAtIndex:0];
            } else {
                tempCard = [[self.currentHand sortedArrayUsingDescriptors:[NSArray arrayWithObject:valueDescriptor]] objectAtIndex:([self.currentHand count] - 1)];
                }
            }
        } else {
            tempCard = [[self.currentHand sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"value" ascending:NO]]] objectAtIndex:0];
        }
        
        [valueDescriptor release];
        
    }
    if (self.typeOfPlayer == PlayerTypeAIPlayFirstPlayableCard) {
        if ([currentTrick count] > 0) {
            if ([[self.currentHand filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:    @"suit == %d", [[currentTrick objectAtIndex:0] suit]]] count] != 0) {
                tempCard = [[[self.currentHand filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d", [[currentTrick objectAtIndex:0] suit]]] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"value" ascending:YES]]] objectAtIndex:0];
            } else {
                tempCard = [self.currentHand objectAtIndex:0];
            }
        } else {
            tempCard = [[self.currentHand sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"value" ascending:YES]]] objectAtIndex:0];
        }
    } 
    return tempCard;
}

- (int) playersBidWithTrump:(int)trump arrayOfBids:(NSArray *)bidArray playersWhoHaveBidSoFar:(int)numberOfPlayersWhoHaveBid andNumberOfPlayers:(int)numberOfPlayers {
    int bid;
    if (self.typeOfPlayer == PlayerTypeAICardPlayToWinHand) {
        bid = round([[self.currentHand filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"value == %d", 14]] count] + 0.5*[[self.currentHand filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"value == %d", 13]] count] + 0.25*[[self.currentHand filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"value == %d", 12]] count]);
    }
    if (self.typeOfPlayer == PlayerTypeAIPlayFirstPlayableCard) {
        //bids based on number of trumps
        bid = [[self.currentHand filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d", trump]] count];
    }
    if (self.typeOfPlayer == PlayerTypeAIKunaal) {
        //bids based on Kunaal's algorithm
        bid = [[self.currentHand filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d", trump]] count];
    }
    if (numberOfPlayersWhoHaveBid < numberOfPlayers - 1) {
        return bid;
    } 
    if (numberOfPlayersWhoHaveBid == numberOfPlayers - 1) {
        NSLog(@"Sum of bids = %d, cards in hand = %d", (bid + [[bidArray valueForKeyPath:@"@sum.self"]intValue]), [[self currentHand] count]);
        if ((bid + [[bidArray valueForKeyPath:@"@sum.self"]intValue]) == [self.currentHand count]) {
            if (bid == 0) {
                bid++;
            } else {
                int randomNumber = arc4random()%2;
                NSLog(@"randome number = %d", randomNumber);
                switch (randomNumber) {
                    case 0:
                        bid--;
                        break;
                    case 1:
                        bid++;
                        break;
                    default:
                        break;
                }
            }
        }
    }
    return bid;
}

- (BOOL) isEqual:(id)object {
    if ([self.name isEqualToString:[object name]] && self.typeOfPlayer == [object typeOfPlayer] && self.bid == [object bid] && [self.tricksTaken isEqual:[object tricksTaken]] && [self.currentHand isEqual:[object currentHand]] && self.score == [object score]) {
        return YES;
    } else {
        return NO;
    }
}

@end
