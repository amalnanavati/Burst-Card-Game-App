//
//  Model.h
//  Card Game Model
//
//  Created by Chaya Nanavati on 6/15/13.
//  Copyright 2013 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Player.h"


@interface Model : NSObject {
@private
    
}

@property (nonatomic, readwrite) BOOL aceHigh;
@property (nonatomic, readwrite) int numberOfPlayers;
@property (nonatomic) int playerWhoseTurnItIs;
@property (nonatomic) int dealer;
@property int numberOfCardsPerPersonInTheRound;
//same suit order as Card class except 4 = notrump

@property (nonatomic) int trump;
@property (nonatomic) int previousPlayerIndex;
@property (nonatomic) int playerWhoWinsCurrentTrickIndex;

@property (nonatomic) BOOL playersHaveBeenCreated;


@property (nonatomic, retain) NSMutableArray *playersArray;
@property (nonatomic, retain) NSMutableArray *gameDeck;
@property (nonatomic, retain) NSMutableArray *currentTrick;

- (void) createDeckWithCards:(NSArray *)cardsArray;
- (void)shuffle;
- (void) createPlayers;
- (void) deal;
- (void) startGame;
- (int) currentPlayerIndex;
- (int) nextPlayerIndex;
- (void) currentPlayerBids:(int)bid;
- (BOOL) isTheBidBetweenTheCorrectNumbers:(int)bid;
- (BOOL) doesTheBidNotMakeItAnEvenBidIfItIsTheLastPlayer:(int)bid;
- (BOOL) isTheBidOver;
//- (BOOL) haveAllThePlayersBidYetForThisRound;
- (int) numberOfPlayersThatHaveBidSoFar;
- (void) currentPlayerPlaysCardWithSuit:(int)suit andValue:(int)value;
- (BOOL) doesThePlayerHaveTheCard:(Card *)card;
- (BOOL) isTheCardLegal:(Card *)card;
- (BOOL) isTheTrickOver;
- (void) determineWhoTheTrickGoesTo;
- (void) endRound;
- (void) moveOnToNextRound;
- (void) endGame;

@end
