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


@protocol Card_Game_ModelViewControllerDelegate;
#import "MainMenu_ViewController.h"

@interface Card_Game_ModelViewController: UIViewController <MainMenu_ViewControllerDelegate, UIAlertViewDelegate, UIGestureRecognizerDelegate> {
    
    UILabel *_promptLabel;
    UILabel *_playerBidLabel;
    UILabel *_playerTricksTakenLabel;
    UILabel *_biddingPromptLabel;
    UITextField *_bidInputTextField;
    UIButton *_bidbutton;
}

@property (nonatomic, assign) id <Card_Game_ModelViewControllerDelegate> delegate;
@property (nonatomic, retain) Model *brain;
/*@property int numberOfPlayers;
@property (nonatomic, retain) NSMutableArray *playersArray;
@property (nonatomic, retain) NSMutableArray *cardsPerPlayer;
@property (nonatomic, retain) NSMutableArray *bidArray;

@property (nonatomic) int playerWhoseTurnItIs;
@property (nonatomic) int dealer;
@property int burstNumberOfCardsPerPersonInTheRound;
//@property (nonatomic) BOOL burstStartBidding;
//@property (nonatomic) BOOL haveTheCardsBeenDealtYetForTheRound;


@property (nonatomic, retain) NSMutableArray *currentTrick;*/
@property (retain, nonatomic) IBOutlet UILabel *playerWhoWonTrickLabel;

@property (retain, nonatomic) IBOutlet UILabel *currentTrickLabel;
@property (nonatomic, retain) IBOutlet UITextField *bidInputTextField;
@property (nonatomic, retain) IBOutlet UIButton *bidButton;
@property (nonatomic, retain) IBOutlet UILabel *bidPromptLabel;
@property (nonatomic, retain) IBOutlet UILabel *promptLabel;
@property (nonatomic, retain) IBOutlet UILabel *playerBidLabel;
@property (nonatomic, retain) IBOutlet UILabel *playerTricksTakenLabel;
@property (nonatomic, retain) NSMutableArray *arrayOfViablePoints;



- (void)playAction:(id)sender;
//- (void) createPlayers;
//- (void) deal;
//- (void) equalCardsPerPlayer:(int)numberOfCardsPerPlayer;
//- (void) playerAtIndex:(int)playerIndex playsCardWithSuit:(int)suit andValue:(int)value;
//- (void) determineWhoTheTrickGoesTo;
//- (BOOL) isTheTrickOver;
//- (BOOL) tempAreTheTextFieldsFilledWithNumbers;
//- (BOOL) tempDoesThePlayerHaveTheCard;
//- (BOOL) isTheCardLegal;
//- (void) bidAction;
//- (void) burstRoundOver;
//- (void) bidOver;
//- (void) playerAtIndex:(int)playerIndex bids:(int)bid;

//- (void) setPlayerWhoseTurnItIsNumberVersion:(NSNumber *)playerWhoseTurnItIs;

- (IBAction)bidAction:(id)sender;
- (void) updatePlayersHand;
- (void)userTouchedScreen:(UITapGestureRecognizer *)recognizer;
//- (void) bid;
//- (void) play;

//- (void) gameOver;
- (NSMutableArray *) viablePointsToMoveACardTo;

@end

@protocol Card_Game_ModelViewControllerDelegate
- (void)playViewControllerDidFinish:(Card_Game_ModelViewController *)controller;
@end




