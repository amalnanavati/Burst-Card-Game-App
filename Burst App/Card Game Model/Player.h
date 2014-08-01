//
//  Player.h
//  Card Game Model
//
//  Created by Chaya Nanavati on 6/15/13.
//  Copyright 2013 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

typedef enum {
    PlayerTypeHuman = 0,
    PlayerTypeAICardPlayToWinHand,
    PlayerTypeAIPlayFirstPlayableCard,
    PlayerTypeAIKunaal
} PlayerType;

@interface Player : NSObject {
@private
    
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSMutableArray *currentHand;
@property (nonatomic, retain) NSMutableArray *tricksTaken;
@property (nonatomic, readwrite) PlayerType typeOfPlayer;
//@property int numberOfCards;
@property int bid;
@property int score;
@property (nonatomic) BOOL haveIBidYetForTheNewRound;
@property (nonatomic) BOOL haveIPlayedYetForTheNewTrick;
@property (nonatomic) BOOL numberOfTricksTaken;

- (id)initWithType:(PlayerType)type;
- (void) arrangeBySuit;
- (void) arrangebyValue;
- (Card *) cardToBePlayedWithStartingSuit:(NSMutableArray *)currentTrick andTrump:(int)trump andtricksTakenPerPlayer:(NSArray *)tricksTakenPerPlayer andBidArray:(NSMutableArray *)bidsArray;
- (int) playersBidWithTrump:(int)trump arrayOfBids:(NSArray *)bidArray playersWhoHaveBidSoFar:(int)numberOfPlayersWhoHaveBid andNumberOfPlayers:(int)numberOfPlayers;

@end
