//
//  Model.m
//  Card Game Model
//
//  Created by Chaya Nanavati on 6/15/13.
//  Copyright 2013 Stanford University. All rights reserved.
//

#import "Model.h"


@implementation Model
@synthesize aceHigh = _aceHigh;
@synthesize gameDeck = _gameDeck;
@synthesize numberOfPlayers = _numberOfPlayers;
@synthesize playerWhoseTurnItIs = _playerWhoseTurnItIs;
@synthesize dealer = _dealer;
@synthesize trump = _trump;
@synthesize numberOfCardsPerPersonInTheRound = _numberOfCardsPerPersonInTheRound;
@synthesize playersHaveBeenCreated = _playersHaveBeenCreated;
@synthesize playerWhoWinsCurrentTrickIndex = _playerWhoWinsCurrentTrickIndex;
@synthesize previousPlayerIndex = _previousPlayerIndex;

@synthesize currentTrick = _currentTrick;
@synthesize playersArray = _playersArray;

- (NSMutableArray *)playersArray {
    //lazy instantiation of playersdictionary
    if (_playersArray == nil) _playersArray = [[NSMutableArray alloc] initWithCapacity:self.numberOfPlayers];
    return _playersArray;
}

- (NSMutableArray *)currentTrick {
    //lazy instantiation of currenttrick
    if (_currentTrick == nil) _currentTrick = [[NSMutableArray alloc] init];
    return _currentTrick;
}

- (void) setPlayerWhoseTurnItIs:(int)playerWhoseTurnItIs {
    self.previousPlayerIndex = _playerWhoseTurnItIs%self.numberOfPlayers;
    //update prompt stuff here (aka for human)
    [self willChangeValueForKey:@"playerWhoseTurnItIs"];
    _playerWhoseTurnItIs = playerWhoseTurnItIs;
    [self didChangeValueForKey:@"playerWhoseTurnItIs"]; 
    
    NSLog(@"It Is %@'s Turn.", [[self.playersArray objectAtIndex:[self currentPlayerIndex]] name]);
    if ([self numberOfPlayersThatHaveBidSoFar] < self.numberOfPlayers) {
        
        if ([[self.playersArray objectAtIndex:[self currentPlayerIndex]] typeOfPlayer] != PlayerTypeHuman) {
            
            [self currentPlayerBids:[[self.playersArray objectAtIndex:[self currentPlayerIndex]] playersBidWithTrump:self.trump arrayOfBids:[self.playersArray valueForKeyPath:@"@unionOfObjects.bid"] playersWhoHaveBidSoFar:[self numberOfPlayersThatHaveBidSoFar] andNumberOfPlayers:self.numberOfPlayers]];
            
        }
    } else if ([self numberOfPlayersThatHaveBidSoFar] == self.numberOfPlayers) {
        
        if ([[self.playersArray objectAtIndex:[self currentPlayerIndex]] typeOfPlayer] != PlayerTypeHuman) {
            
            [self currentPlayerPlaysCardWithSuit:[[[self.playersArray objectAtIndex:[self currentPlayerIndex]] cardToBePlayedWithStartingSuit:self.currentTrick andTrump:self.trump andtricksTakenPerPlayer:[self.playersArray valueForKeyPath:@"@unionOfObjects.tricksTaken"] andBidArray:[self.playersArray valueForKeyPath:@"@unionOfObjects.bid"]] suit] andValue:[[[self.playersArray objectAtIndex:[self currentPlayerIndex]] cardToBePlayedWithStartingSuit:self.currentTrick andTrump:self.trump andtricksTakenPerPlayer:[self.playersArray valueForKeyPath:@"@unionOfObjects.tricksTaken"] andBidArray:[self.playersArray valueForKeyPath:@"@unionOfObjects.bid"]] value]];

        }
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        self.aceHigh = YES;
        self.playersHaveBeenCreated = NO;
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void) createDeckWithCards:(NSArray *)cardsArray {
    if (self.gameDeck == nil) _gameDeck = [[NSMutableArray alloc] init];
        [self.gameDeck removeAllObjects];
    for (int i = 0; i < [cardsArray count]; i++) {
        /*NSValue *v = [NSValue valueWithCGPoint:CGPointMake(1, 2)];
         CGPoint hi = [v CGPointValue];
         NSLog(@"%@", NSStringFromCGPoint(hi));*/
        
        NSValue *temp = [cardsArray objectAtIndex:i];
        CGPoint cardPoint = [temp CGPointValue];
        //NSLog(@"%@", NSStringFromCGPoint(cardPoint));
        Card *tempCard = [[Card alloc] initWithSuit:(int)cardPoint.x Value:(int)cardPoint.y];
        [self.gameDeck addObject:tempCard];
        [tempCard release];
    }
    
    NSLog(@"%@", self.gameDeck);
    NSLog(@"Total Number of Cards in Deck: %i", [self.gameDeck count]);
    
}

- (void)shuffle
{
    NSUInteger count = [self.gameDeck count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        [self.gameDeck exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    NSLog(@"%@", self.gameDeck);
    NSLog(@"Total Number of Cards in Deck: %i", [self.gameDeck count]);
}

#pragma-mark START GAME

- (void) createPlayers {
    for (int i = 0; i < self.numberOfPlayers; i++) {
        if (i == 0) {
         Player *tempPlayer = [[Player alloc] initWithType:PlayerTypeHuman];
         [tempPlayer setName:[NSString stringWithFormat:@"Player%d", i]];
         [tempPlayer setScore:0];
         [self.playersArray addObject:tempPlayer];
         [tempPlayer release];
         }
        if (i == 2 || i == 4) {
            Player *tempPlayer = [[Player alloc] initWithType:PlayerTypeAICardPlayToWinHand];
            [tempPlayer setName:[NSString stringWithFormat:@"Player%d", i]];
            [tempPlayer setScore:0];
            [self.playersArray addObject:tempPlayer];
            [tempPlayer release];
        }
        if (i == 3 || i == 1) {
            Player *tempPlayer = [[Player alloc] initWithType:PlayerTypeAIPlayFirstPlayableCard];
            [tempPlayer setName:[NSString stringWithFormat:@"Player%d", i]];
            [tempPlayer setScore:0];
            [self.playersArray addObject:tempPlayer];
            [tempPlayer release];
        }
    }
    self.playersHaveBeenCreated = YES;
    NSLog(@"%@", self.playersArray);
}

- (void) deal {
    for (int i = 0; i < self.numberOfPlayers; i++) {
        [[[self.playersArray objectAtIndex:i] currentHand] removeAllObjects];
    }
    
    int totalNumberOfCardsDealt = 0;
    for (int n = 0; n < self.numberOfPlayers; n++) {
        
        totalNumberOfCardsDealt = totalNumberOfCardsDealt + self.numberOfCardsPerPersonInTheRound;
    }
    NSLog(@"Total Number Of Cards Dealt Is %d", totalNumberOfCardsDealt);
    
    for (int i = 0; i < totalNumberOfCardsDealt; i++) {
        [[self.gameDeck objectAtIndex:0] setWhatPlayerTheCardBelongsTo:(i%self.numberOfPlayers)];
        [[[self.playersArray objectAtIndex:(i%self.numberOfPlayers)] currentHand] addObject:[self.gameDeck objectAtIndex:0]];
        [self.gameDeck removeObjectAtIndex:0];
    }
    NSLog(@"%@", self.playersArray);
    NSLog(@"Game Deck  = %@", self.gameDeck);
}

- (void) startGame {
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    
    for (int s = 0; s <= 3; s++) {
        if (self.aceHigh == NO) {
            for (int n = 1; n <= 13; n++) {
                [cards addObject:[NSValue valueWithCGPoint:CGPointMake((float)s, (float)n)]];
            }
        } else {
            for (int n = 2; n <= 14; n++) {
                [cards addObject:[NSValue valueWithCGPoint:CGPointMake((float)s, (float)n)]];
            }
        }
    }
    [self createDeckWithCards:cards];
    [cards release];
    self.numberOfPlayers = 5;
    [self shuffle];
    [self createPlayers];
    self.trump = 2;
    
    self.numberOfCardsPerPersonInTheRound = round(self.gameDeck.count / self.numberOfPlayers - 0.5);
    
    self.dealer = 4;
    
    [self deal];
    
    for (Player *p in self.playersArray) {
        [p arrangeBySuit];
    }
    
    self.playerWhoseTurnItIs = self.dealer + 1;
}

- (int) currentPlayerIndex {
    int currentPlayer = self.playerWhoseTurnItIs%self.numberOfPlayers;
    return currentPlayer;
}
//note: this ignores the next player at the end of the trick
- (int) nextPlayerIndex {
    int nextPlayer = (self.playerWhoseTurnItIs + 1)%self.numberOfPlayers;
    return nextPlayer;
}

#pragma-mark BIDDING

- (void) currentPlayerBids:(int)bid {
    
    //BID IN PROGRESS
    [[self.playersArray objectAtIndex:[self currentPlayerIndex]] setBid:bid];
    [[self.playersArray objectAtIndex:[self currentPlayerIndex]] setHaveIBidYetForTheNewRound:YES];
    //[self.bidArray addObject:[NSNumber numberWithInt:bid]];
    
    NSLog(@"BidArray = %@", [self.playersArray valueForKeyPath:@"@unionOfObjects.bid"]);
    
    if ([[self.playersArray objectAtIndex:[self currentPlayerIndex]] typeOfPlayer] == PlayerTypeHuman && [[self.playersArray objectAtIndex:[self nextPlayerIndex]] typeOfPlayer] == PlayerTypeHuman) {
        //do not wait only if it is a human followed by a human.  if it is an ai next, you want a break
        self.playerWhoseTurnItIs++;
    } else {
        //waits one second
        int nextPlayer = self.playerWhoseTurnItIs + 1;
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:@selector(setPlayerWhoseTurnItIs:)]];
        [invocation setTarget:self];
        [invocation setSelector:@selector(setPlayerWhoseTurnItIs:)];
        [invocation setArgument:&nextPlayer atIndex:2];
        [invocation performSelector:@selector(invoke) withObject:nil afterDelay:1.0];
        
    }
}

- (BOOL) isTheBidBetweenTheCorrectNumbers:(int)bid {
    if (bid >= 0 && bid <= self.numberOfCardsPerPersonInTheRound) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL) doesTheBidNotMakeItAnEvenBidIfItIsTheLastPlayer:(int)bid {
    //if it is the last player to bid
    if ([[self.playersArray valueForKeyPath:@"@unionOfObjects.bid"] count] == self.numberOfPlayers - 1) {
        if ((bid + [[[self.playersArray valueForKeyPath:@"@unionOfObjects.bid"] valueForKeyPath:@"@sum.self"] intValue]) != self.numberOfCardsPerPersonInTheRound) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return YES;
    }
}

- (BOOL) isTheBidOver {
    //makes sure all the players have bid
    int numberOfPlayersThatHaveBid = 0;
    for (Player *p in self.playersArray) {
        if (p.haveIBidYetForTheNewRound == YES) {
            numberOfPlayersThatHaveBid++;
        }
    }
    if (numberOfPlayersThatHaveBid == self.numberOfPlayers) {
        return YES;
    } else {
        return NO;
    }
}

/*- (BOOL) haveAllThePlayersBidYetForThisRound {
    int numberOfPlayersThatHaveBidYetForThisRound = 0;
    for (Player *p in self.playersArray) {
        if (p.haveIBidYetForTheNewRound == YES) {
            numberOfPlayersThatHaveBidYetForThisRound++;
        }
    }
    if (numberOfPlayersThatHaveBidYetForThisRound == self.numberOfPlayers) {
        return YES;
    } else {
        return NO;
    }
}*/

- (int) numberOfPlayersThatHaveBidSoFar {
    int numberOfPlayersThatHaveBidYetForThisRound = 0;
    for (Player *p in self.playersArray) {
        if (p.haveIBidYetForTheNewRound == YES) {
            numberOfPlayersThatHaveBidYetForThisRound++;
        }
    }
    return numberOfPlayersThatHaveBidYetForThisRound;
}

#pragma-mark GAMEPLAY

- (void) currentPlayerPlaysCardWithSuit:(int)suit andValue:(int)value {
    
    //PLAY IN PROGRESS
    //adds the currently played card to the trick
    [self.currentTrick addObject:[[[[self.playersArray objectAtIndex:[self currentPlayerIndex]] currentHand] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d AND value == %d", suit, value]] objectAtIndex:0]];
    
    //removes the currently played card from that player's hand
    [[[self.playersArray objectAtIndex:[self currentPlayerIndex]] currentHand] removeObject:[[[[self.playersArray objectAtIndex:[self currentPlayerIndex]] currentHand] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d AND value == %d", suit, value]] objectAtIndex:0]];
    
    //Logs both the player's hand and the current trick
    NSLog(@"Curent Trick = %@, %@'s Hand = %@", self.currentTrick, [[self.playersArray objectAtIndex:[self currentPlayerIndex]] name], [[self.playersArray objectAtIndex:[self currentPlayerIndex]] currentHand]);
    
    [[self.playersArray objectAtIndex:[self currentPlayerIndex]] setHaveIPlayedYetForTheNewTrick:YES];
    
    //moves on to the next player
    if ([self isTheTrickOver] == NO) {
        if ([[self.playersArray objectAtIndex:[self currentPlayerIndex]] typeOfPlayer] == PlayerTypeHuman && [[self.playersArray objectAtIndex:[self nextPlayerIndex]] typeOfPlayer] == PlayerTypeHuman) {
            //do not wait only if it is a human followed by a human.  if it is an ai next, you want break
            self.playerWhoseTurnItIs++;
        } else {
            //waits one second
            int nextPlayer = self.playerWhoseTurnItIs + 1;
            
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:@selector(setPlayerWhoseTurnItIs:)]];
            [invocation setTarget:self];
            [invocation setSelector:@selector(setPlayerWhoseTurnItIs:)];
            [invocation setArgument:&nextPlayer atIndex:2];
            [invocation performSelector:@selector(invoke) withObject:nil afterDelay:1.0];
        }
    } else {
        if ([[self.playersArray objectAtIndex:[self currentPlayerIndex]] typeOfPlayer] == PlayerTypeHuman && [[self.playersArray objectAtIndex:[self nextPlayerIndex]] typeOfPlayer] == PlayerTypeHuman) {
            [self determineWhoTheTrickGoesTo];
        } else {
            //waits one second if current player and/or next layer is AI
            
            [self performSelector:@selector(determineWhoTheTrickGoesTo) withObject:nil afterDelay:1.0];
        }
    }
    
    
    /*if ([self isTheTrickOver] == YES) {
     NSLog(@"Trick Complete!");
     [self determineWhoTheTrickGoesTo];
     }*/
    
}

- (BOOL) doesThePlayerHaveTheCard:(Card *)card {
    if ([[[[self.playersArray objectAtIndex:[self currentPlayerIndex]] currentHand] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d AND value == %d", card.suit, card.value]] count] != 0) {
        return YES;
    } else {
        return NO;
    }
}

//based on whether the player has the leading suit
- (BOOL) isTheCardLegal:(Card *)card {
    if ([self.currentTrick count] != 0) {
        if (card.suit == [[self.currentTrick objectAtIndex:0] suit]) {
            return YES;
        } else {
            if ([[[[self.playersArray objectAtIndex:[self currentPlayerIndex]] currentHand] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d", [[self.currentTrick objectAtIndex:0] suit]]] count] == 0) {
                return YES;
            } else {
                return NO;
            }
        }
    } else {
        return YES;
    }
}

- (BOOL) isTheTrickOver {
    if ([self.currentTrick count] < self.numberOfPlayers) {
        return NO;
    } else return YES;
}

- (void) determineWhoTheTrickGoesTo {
    NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"value" ascending:NO];
    
    //if there is no trump or no trump in the trick
    if (self.trump == 4 || [[self.currentTrick filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d", self.trump]] count] == 0) {
        self.playerWhoWinsCurrentTrickIndex = [[[[self.currentTrick filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d", [[self.currentTrick objectAtIndex:0] suit]]] sortedArrayUsingDescriptors:[NSArray arrayWithObject:valueDescriptor]] objectAtIndex:0] whatPlayerTheCardBelongsTo];
        [[[self.playersArray objectAtIndex:self.playerWhoWinsCurrentTrickIndex] tricksTaken] addObject:[NSArray arrayWithArray:self.currentTrick]];
        [[self.playersArray objectAtIndex:self.playerWhoWinsCurrentTrickIndex] setNumberOfTricksTaken:[[[self.playersArray objectAtIndex:self.playerWhoWinsCurrentTrickIndex] tricksTaken] count]];
        [self.currentTrick removeAllObjects];
    } else {
        self.playerWhoWinsCurrentTrickIndex = [[[[self.currentTrick filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d", self.trump]] sortedArrayUsingDescriptors:[NSArray arrayWithObject:valueDescriptor]] objectAtIndex:0] whatPlayerTheCardBelongsTo];
        [[[self.playersArray objectAtIndex:self.playerWhoWinsCurrentTrickIndex] tricksTaken] addObject:[NSArray arrayWithArray:self.currentTrick]];
        [[self.playersArray objectAtIndex:self.playerWhoWinsCurrentTrickIndex] setNumberOfTricksTaken:[[[self.playersArray objectAtIndex:self.playerWhoWinsCurrentTrickIndex] tricksTaken] count]];
        [self.currentTrick removeAllObjects];
    }
    
    for (Player *p in self.playersArray) {
        p.haveIPlayedYetForTheNewTrick = NO;
    }
    
    [valueDescriptor release];
    
    NSLog(@"%@ Gets The Trick!!!", [[self.playersArray objectAtIndex:self.playerWhoWinsCurrentTrickIndex] name]);
    NSLog(@"%@'s Trick's Taken Are: %@", [[self.playersArray objectAtIndex:self.playerWhoWinsCurrentTrickIndex] name], [[self.playersArray objectAtIndex:self.playerWhoWinsCurrentTrickIndex] tricksTaken]);
    
    
    int numberOFTotalTricksTaken = 0;
    for (Player *p in self.playersArray) {
        numberOFTotalTricksTaken = numberOFTotalTricksTaken + [p.tricksTaken count];
    }
    
    if (self.numberOfCardsPerPersonInTheRound == numberOFTotalTricksTaken) {
        NSLog(@"Round is Over!");
        if ([[self.playersArray objectAtIndex:[self currentPlayerIndex]] typeOfPlayer] == PlayerTypeHuman) {
            [self endRound];
        } else {
            //waits one second
            [self performSelector:@selector(endRound) withObject:nil afterDelay:1.0];
        }
    } else {
        if ([[self.playersArray objectAtIndex:[self currentPlayerIndex]] typeOfPlayer] == PlayerTypeHuman && [[self.playersArray objectAtIndex:[self nextPlayerIndex]] typeOfPlayer] == PlayerTypeHuman) {
            self.playerWhoseTurnItIs = self.playerWhoWinsCurrentTrickIndex;
        } else {
            //waits one second if current player and/or next player is AI
            int nextPlayer = self.playerWhoWinsCurrentTrickIndex;
            
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:@selector(setPlayerWhoseTurnItIs:)]];
            [invocation setTarget:self];
            [invocation setSelector:@selector(setPlayerWhoseTurnItIs:)];
            [invocation setArgument:&nextPlayer atIndex:2];
            [invocation performSelector:@selector(invoke) withObject:nil afterDelay:1.0];
        }
    }
}

- (void) endRound {
    //self.haveTheCardsBeenDealtYetForTheRound = NO;
    
    for (Player *p in self.playersArray) {
        if ([p bid] == [[p tricksTaken] count]) {
            p.score = p.score + 11*p.bid + 10;
        }
        for (NSMutableArray *tempTrick in p.tricksTaken) {
            [self.gameDeck addObjectsFromArray:tempTrick];
        }
        [p.tricksTaken removeAllObjects];
        NSLog(@"%@'s score is %d", p.name, p.score);
        NSLog(@"Deck has %d cards", [self.gameDeck count]);
    }
    
    self.numberOfCardsPerPersonInTheRound--;
    
    
    //rest of endRound stuff happens in alertview's buttonclick event (see below)
}

- (void) moveOnToNextRound {
    //END OF ROUND AND BEGINNING OF NEW ROUND
    if (self.numberOfCardsPerPersonInTheRound > 0) {
    for (Player*p in self.playersArray) {
        p.haveIBidYetForTheNewRound = NO;
    }
    
    [self shuffle];
    
    self.dealer++;
    
    
    
    [self deal];
    for (Player *p in self.playersArray) {
        [p arrangeBySuit];
    }
    
    //player who starts is the player after the dealer
    self.playerWhoseTurnItIs = self.dealer%self.numberOfPlayers + 1;
} else {
    [self endGame];
}
}

#pragma-mark END GAME

- (void) endGame {
    
}

#pragma-mark KVO

+ (BOOL) automaticallyNotifiesObserversForKey:(NSString *)key {
    BOOL automatic = NO;
    if ([key isEqualToString:@"playerWhoseTurnItIs"] == YES) {
        automatic = NO;
    } else {
        automatic = [super automaticallyNotifiesObserversForKey:key];
    }
    return automatic;
}



@end
