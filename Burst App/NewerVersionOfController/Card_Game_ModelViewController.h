//
//  Card_Game_ModelViewController.h
//  Card Game Model
//
//  Created by Chaya Nanavati on 6/15/13.
//  Copyright 2013 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "Player.h"
#import "Card.h"

@interface Card_Game_ModelViewController: UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    UILabel *_promptLabel;
    UILabel *_suitLabel;
    UILabel *_valueLabel;
    UITextField *_suitInputTextField;
    UIButton *_playButton;
    UILabel *_currentTrickLabel;
    UITextField *_valueInputTextField;
    
    
    /*UILabel *biddingPromptLabel;
    UITextField *biddingInputTextField;
    UIButton *bidButton;*/
    
    NSArray *arrayData;
	
    UITableView *_playersCards;
    UITableView *_currentTrickTabelView;
    UILabel *_playerBidLabel;
    UILabel *_playerTricksTakenLabel;
    UILabel *_trumpIsLabel;
    UILabel *_playerWhoWonRoundLabel;
    UILabel *_biddingPromptLabel;
    UITextField *_bidInputTextField;
    UIButton *_bidbutton;
    UIButton *_bidAction;
}

@property (nonatomic, retain) Model *brain;
@property int numberOfPlayers;
@property (nonatomic, retain) NSMutableArray *playersArray;
@property (nonatomic, retain) NSMutableArray *cardsPerPlayer;
@property (nonatomic, retain) NSMutableArray *bidArray;

@property (nonatomic) int playerWhoseTurnItIs;
@property (nonatomic) int dealer;
@property int burstNumberOfCardsPerPersonInTheRound;
//@property (nonatomic) BOOL burstStartBidding;
//@property (nonatomic) BOOL haveTheCardsBeenDealtYetForTheRound;


@property (nonatomic, retain) NSMutableArray *currentTrick;


//same suit order as Card class except 4 = notrump
@property (nonatomic) int trump;
@property (nonatomic, retain) IBOutlet UITextField *bidInputTextField;
@property (nonatomic, retain) IBOutlet UIButton *bidButton;

@property (nonatomic, retain) IBOutlet UILabel *bidPromptLabel;

@property (nonatomic, retain) IBOutlet UILabel *promptLabel;
@property (nonatomic, retain) IBOutlet UILabel *suitLabel;
@property (nonatomic, retain) IBOutlet UILabel *valueLabel;
@property (nonatomic, retain) IBOutlet UITextField *suitInputTextField;
@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) IBOutlet UILabel *currentTrickLabel;
@property (nonatomic, retain) IBOutlet UITextField *valueInputTextField;
@property (nonatomic, retain) IBOutlet UITableView *playersCards;
@property (nonatomic, retain) IBOutlet UITableView *currentTrickTabelView;
@property (nonatomic, retain) IBOutlet UILabel *playerBidLabel;
@property (nonatomic, retain) IBOutlet UILabel *playerTricksTakenLabel;
@property (nonatomic, retain) IBOutlet UILabel *trumpIsLabel;
@property (nonatomic, retain) IBOutlet UILabel *playerWhoWonTrickLabel;


- (IBAction)tempPlayButton:(id)sender;
- (void) createPlayers;
- (void) deal;
- (void) equalCardsPerPlayer:(int)numberOfCardsPerPlayer;
- (void) playerAtIndex:(int)playerIndex playsCardWithSuit:(int)suit andValue:(int)value;
- (void) determineWhoTheTrickGoesTo;
- (BOOL) isTheTrickOver;
- (BOOL) tempAreTheTextFieldsFilledWithNumbers;
- (BOOL) tempDoesThePlayerHaveTheCard;
- (BOOL) isTheCardLegal;
//- (void) bidAction;
- (void) burstRoundOver;
//- (void) bidOver;
- (void) playerAtIndex:(int)playerIndex bids:(int)bid;

//- (void) setPlayerWhoseTurnItIsNumberVersion:(NSNumber *)playerWhoseTurnItIs;

- (IBAction)bidAction:(id)sender;
//- (void) bid;
//- (void) play;



@end
