//
//  Card_Game_ModelViewController.m
//  Card Game Model
//
//  Created by Chaya Nanavati on 6/15/13.
//  Copyright 2013 Stanford University. All rights reserved.
//

#import "Card_Game_ModelViewController.h"

@implementation Card_Game_ModelViewController
@synthesize brain = _brain;
@synthesize numberOfPlayers = _numberOfPlayers;
@synthesize playersArray = _playersArray;
@synthesize cardsPerPlayer = _cardsPerPlayer;
@synthesize playerWhoseTurnItIs = _playerWhoseTurnItIs;
@synthesize dealer = _dealer;
@synthesize promptLabel = _promptLabel;
@synthesize suitLabel = _suitLabel;
@synthesize valueLabel = _valueLabel;
@synthesize suitInputTextField = _suitInputTextField;
@synthesize playButton = _playButton;
@synthesize currentTrickLabel = _currentTrickLabel;
@synthesize valueInputTextField = _valueInputTextField;
@synthesize currentTrick = _currentTrick;
@synthesize trump = _trump;
@synthesize playersCards = _playersCards;
@synthesize currentTrickTabelView = _currentTrickTabelView;
@synthesize playerBidLabel = _playerBidLabel;
@synthesize playerTricksTakenLabel = _playerTricksTakenLabel;
@synthesize trumpIsLabel = _trumpIsLabel;
@synthesize playerWhoWonTrickLabel = _playerWhoWonTrickLabel;
@synthesize burstStartBidding = _burstStartBidding;
@synthesize bidArray = _bidArray;
@synthesize burstNumberOfCardsPerPersonInTheRound = _burstNumberOfCardsPerPersonInTheRound;
@synthesize haveTheCardsBeenDealtYetForTheRound = _haveTheCardsBeenDealtYetForTheRound;

- (Model *)brain {
    //lazy instantiation of brain
    if (_brain == nil) _brain = [[Model alloc] init];
    return _brain;
}

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

- (NSMutableArray *)cardsPerPlayer {
    //lazy instantiation of cardsperPlayer
    if (_cardsPerPlayer == nil) _cardsPerPlayer = [[NSMutableArray alloc] init];
    return _cardsPerPlayer;
}

- (NSMutableArray *)bidArray {
    //lazy instantiation of bidArray
    if (_bidArray == nil) _bidArray = [[NSMutableArray alloc] init];
    return _bidArray;
}

- (void) setPlayerWhoseTurnItIs:(int)playerWhoseTurnItIs {
    [self setPlayerWhoseTurnItIsNumberVersion:[NSNumber numberWithInt:playerWhoseTurnItIs]];
}


- (void) setPlayerWhoseTurnItIsNumberVersion:(NSNumber *)playerWhoseTurnItIs {
    NSLog(@"PlayerWhoseTurnItIs =  %@", playerWhoseTurnItIs);
    _playerWhoseTurnItIs = [playerWhoseTurnItIs intValue];
    if (self.haveTheCardsBeenDealtYetForTheRound == YES) {
    [self.playersCards reloadData];
    if ([[self.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman) {
        // [self.playersCards reloadData];
        if ([self.bidArray count] < self.numberOfPlayers) {
            biddingPromptLabel.text = [NSString stringWithFormat:@"What would %@ like to bid?", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
        } else if ([self.bidArray count] == self.numberOfPlayers) {
            self.playerBidLabel.text = [NSString stringWithFormat:@"%@'s bid is %@", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name], [self.bidArray objectAtIndex:([playerWhoseTurnItIs intValue]%self.numberOfPlayers)]];
            self.playerTricksTakenLabel.text = [NSString stringWithFormat:@"%@ has taken %d tricks.", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name], [[[self.playersArray objectAtIndex:([playerWhoseTurnItIs intValue]%self.numberOfPlayers)] tricksTaken] count]];
        }
    } else {
        NSLog(@"%@ is not human", [[self.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] name]);
        if ([self.bidArray count] < self.numberOfPlayers) {
            biddingInputTextField.enabled = NO;
            //biddingPromptLabel.text = [NSString stringWithFormat:@"%@ is bidding...", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
            [self playerAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers bids:[[self.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] playersBidWithTrump:self.trump arrayOfBids:self.bidArray andNumberOfPlayers:self.numberOfPlayers]];
            NSLog(@"%@'s bid is %d", [[self.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] name], [[self.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] bid]);
            
            
            
        } else if ([self.bidArray count] == self.numberOfPlayers) {
            ////////////////////perhap remove bidArray because it is not necessary?  i cud always use valueforkeypath...
            
            self.playerBidLabel.text = [NSString stringWithFormat:@"%@'s bid is %@", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name], [self.bidArray objectAtIndex:([playerWhoseTurnItIs intValue]%self.numberOfPlayers)]];
            self.playerTricksTakenLabel.text = [NSString stringWithFormat:@"%@ has taken %d tricks.", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name], [[[self.playersArray objectAtIndex:([playerWhoseTurnItIs intValue]%self.numberOfPlayers)] tricksTaken] count]];
            
            
            [self playerAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers playsCardWithSuit:[[[self.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] cardToBePlayedWithStartingSuit:self.currentTrick andTrump:self.trump andtricksTakenPerPlayer:[self.playersArray valueForKeyPath:@"@unionOfObjects.tricksTaken"] andBidArray:self.bidArray] suit] andValue:[[[self.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] cardToBePlayedWithStartingSuit:self.currentTrick andTrump:self.trump andtricksTakenPerPlayer:[self.playersArray valueForKeyPath:@"@unionOfObjects.tricksTaken"] andBidArray:self.bidArray] value]];
        }
    }
    }
}

- (void) setTrump:(int)trump {
    [self.trumpIsLabel setText:[NSString stringWithFormat:@"Trump is %d", trump]];
    _trump = trump;
}



- (void)dealloc
{
    [_promptLabel release];
    [_suitInputTextField release];
    [_valueInputTextField release];
    [_playersCards release];
    [_playerBidLabel release];
    [_playerTricksTakenLabel release];
    [_trumpIsLabel release];
    [_suitLabel release];
    [_valueLabel release];
    [_playButton release];
    [_currentTrickLabel release];
    [_currentTrickTabelView release];
    [_playerWhoWonTrickLabel release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    self.haveTheCardsBeenDealtYetForTheRound = NO;
    
    self.suitInputTextField.inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    self.valueInputTextField.inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    
    self.promptLabel.adjustsFontSizeToFitWidth = YES;
    
    self.playerBidLabel.text = @"";
    self.playerTricksTakenLabel.text = @"";
    self.playerWhoWonTrickLabel.text = @"";
    
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    if (self.brain.aceHigh == NO) {
        for (int s = 0; s <= 3; s++) {
            for (int n = 1; n <= 13; n++) {
                [cards addObject:[NSValue valueWithCGPoint:CGPointMake((float)s, (float)n)]];
            }
        }
    } else {
        for (int s = 0; s <= 3; s++) {
            for (int n = 2; n <= 14; n++) {
                [cards addObject:[NSValue valueWithCGPoint:CGPointMake((float)s, (float)n)]];
            }
        }
    }
    [self.brain createDeckWithCards:cards];
    [cards release];
    self.numberOfPlayers = 5;
    [self.brain shuffle];
    [self createPlayers];
    self.trump = 2;
    
    self.burstNumberOfCardsPerPersonInTheRound = round(self.brain.gameDeck.count / self.numberOfPlayers - 0.5);
    [self equalCardsPerPlayer:self.burstNumberOfCardsPerPersonInTheRound];
    
    
    
    self.dealer = 4;
    
    [self deal];
    
    for (Player *p in self.playersArray) {
        [p arrangeBySuit];
    }
    
    self.playerWhoseTurnItIs = self.dealer + 1;
    
    self.burstStartBidding = YES;
    
    
    
    biddingPromptLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 20, 317, 21)];
    biddingPromptLabel.textAlignment = UITextAlignmentCenter;
    biddingPromptLabel.text = [NSString stringWithFormat:@"What would %@ like to bid?", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
    biddingPromptLabel.backgroundColor = [UIColor clearColor];
    biddingPromptLabel.adjustsFontSizeToFitWidth = YES;
    biddingInputTextField = [[UITextField alloc] initWithFrame:CGRectMake(120, 40, 80, 30)];
    biddingInputTextField.borderStyle = UITextBorderStyleRoundedRect;
    [biddingInputTextField setEnabled:YES];
    biddingInputTextField.inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    //biddingInputTextField.keyboardType = UIKeyboardTypeNumberPad;
    bidButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    bidButton.frame = CGRectMake(120, 75, 80, 30);
    [bidButton setTitle:@"Bid" forState:UIControlStateNormal];
    [bidButton addTarget:self action:@selector(bidAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:biddingPromptLabel];
    [self.view addSubview:biddingInputTextField];
    [self.view addSubview:bidButton];
    
    
    
    [super viewDidLoad];
    
}


- (void)viewDidUnload
{
    [self setPromptLabel:nil];
    [self setSuitInputTextField:nil];
    [self setValueInputTextField:nil];
    [self setPlayersCards:nil];
    [self setPlayerBidLabel:nil];
    [self setPlayerTricksTakenLabel:nil];
    [self setTrumpIsLabel:nil];
    [self setSuitLabel:nil];
    [self setValueLabel:nil];
    [self setPlayButton:nil];
    [self setCurrentTrickLabel:nil];
    [self setCurrentTrickTabelView:nil];
    [self setPlayerWhoWonTrickLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) createPlayers {
    for (int i = 0; i < self.numberOfPlayers; i++) {
        /*if (i == 0 || i == 1) {
                Player *tempPlayer = [[Player alloc] initWithType:PlayerTypeHuman];
                [tempPlayer setName:[NSString stringWithFormat:@"Player%d", i]];
                [tempPlayer setScore:0];
                [self.playersArray addObject:tempPlayer];
                [tempPlayer release];
        }*/
        if (i == 2 || i == 4 || i == 0) {
            Player *tempPlayer = [[Player alloc] initWithType:PlayerTypeAICardPlayToWinHand];
            [tempPlayer setName:[NSString stringWithFormat:@"Player%d", i]];
            [tempPlayer setScore:0];
            [self.playersArray addObject:tempPlayer];
            [tempPlayer release];
        }
        if (i == 3 || i == 1 ) {
            Player *tempPlayer = [[Player alloc] initWithType:PlayerTypeAIPlayFirstPlayableCard];
            [tempPlayer setName:[NSString stringWithFormat:@"Player%d", i]];
            [tempPlayer setScore:0];
            [self.playersArray addObject:tempPlayer];
            [tempPlayer release];
        }
    }
    NSLog(@"%@", self.playersArray);
}

- (void) deal {
    for (int i = 0; i < self.numberOfPlayers; i++) {
        [[[self.playersArray objectAtIndex:i] currentHand] removeAllObjects];
    }
    
    int totalNumberOfCardsDealt = 0;
    for (int n = 0; n < self.numberOfPlayers; n++) {

        totalNumberOfCardsDealt = totalNumberOfCardsDealt + [[self.cardsPerPlayer objectAtIndex:n] intValue];
    }
    NSLog(@"Total Number Of Cards Dealt Is %d", totalNumberOfCardsDealt);
    
    for (int i = 0; i < totalNumberOfCardsDealt; i++) {
            [[self.brain.gameDeck objectAtIndex:0] setWhatPlayerTheCardBelongsTo:(i%self.numberOfPlayers)];
            [[[self.playersArray objectAtIndex:(i%self.numberOfPlayers)] currentHand] addObject:[self.brain.gameDeck objectAtIndex:0]];
            [self.brain.gameDeck removeObjectAtIndex:0];
    }
    NSLog(@"%@", self.playersArray);
    NSLog(@"Game Deck  = %@", self.brain.gameDeck);
    
    self.promptLabel.text = [NSString stringWithFormat:@"What Card Would %@ Like To Play?", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
    self.haveTheCardsBeenDealtYetForTheRound = YES;
}

- (void) equalCardsPerPlayer:(int)numberOfCardsPerPlayer {
    [self.cardsPerPlayer removeAllObjects];
    for (int i = 0; i < self.numberOfPlayers; i++) {
        [self.cardsPerPlayer addObject:[NSNumber numberWithInt:numberOfCardsPerPlayer]];
    }
    NSLog(@"Cards Per Player = %@", self.cardsPerPlayer);
}

//add a deal all cards method.  however, for that we must know who the deal stats on!!!


#pragma mark - Burst Bidding
- (void) setBurstStartBidding:(BOOL)burstStartBidding {
    if (burstStartBidding == YES) {
        
        //sets all the stuff related to actual gameplay as hidden
        self.playerBidLabel.hidden = YES;
        self.playerTricksTakenLabel.hidden = YES;
        self.playerWhoWonTrickLabel.hidden = YES;
        self.suitLabel.hidden = YES;
        self.valueLabel.hidden = YES;
        self.suitInputTextField.hidden = YES;
        self.valueInputTextField.hidden = YES;
        self.suitInputTextField.enabled = NO;
        self.valueInputTextField.enabled = NO;
        self.promptLabel.hidden = YES;
        self.playButton.hidden = YES;
        self.currentTrickLabel.text = @"";
        self.currentTrickTabelView.hidden = YES;
        biddingPromptLabel.hidden = NO;
        biddingInputTextField.hidden = NO;
        bidButton.hidden = NO;
        biddingInputTextField.enabled = YES;
        
        
    }
    
    _burstStartBidding = burstStartBidding;
}

- (void) bidAction {
    if ([self.bidArray count] != self.numberOfPlayers) {

    if ([biddingInputTextField.text length] > 0 && biddingInputTextField.text != nil && [[biddingInputTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] length] == 0) {
        if ([biddingInputTextField.text intValue] >= 0 && [biddingInputTextField.text intValue] <= [[self.cardsPerPlayer objectAtIndex:0] intValue]) {
            if ([self.bidArray count] == self.numberOfPlayers - 1) {
                if (([biddingInputTextField.text intValue] + [[self.bidArray valueForKeyPath:@"@sum.self"]intValue]) != [[self.cardsPerPlayer objectAtIndex:0] intValue]) {
                    [self playerAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers) bids:[biddingInputTextField.text intValue]];
                } else {
                    biddingPromptLabel.text = [NSString stringWithFormat:@"Sorry, %@'s bid cannot make it an even bid.", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
                }
            } else {
                [self playerAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers) bids:[biddingInputTextField.text intValue]];
            }
        } else {
            biddingPromptLabel.text = [NSString stringWithFormat:@"Sorry, %@'s must bid between 0 & %d, inclusive.", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name], [[self.cardsPerPlayer objectAtIndex:0] intValue]];
        }
    } else {
        biddingPromptLabel.text = [NSString stringWithFormat:@"Sorry, %@'s must type in only a number.", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
    }
    }
    self.currentTrickLabel.text = [NSString stringWithFormat:@"Sum of Bids = %d", [[self.bidArray valueForKeyPath:@"@sum.self"] intValue]];
    NSLog(@"Sum of Bids = %d", [[self.bidArray valueForKeyPath:@"@sum.self"] intValue]);
}

- (void) playerAtIndex:(int)playerIndex bids:(int)bid {
    [[self.playersArray objectAtIndex:playerIndex] setBid:bid];
    [self.bidArray addObject:[NSNumber numberWithInt:bid]];
    biddingInputTextField.text = @"";
    
    biddingPromptLabel.text = [NSString stringWithFormat:@"%@ bid %d", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name], [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] bid]];
    self.currentTrickLabel.text = [NSString stringWithFormat:@"Sum of Bids = %d", [[self.bidArray valueForKeyPath:@"@sum.self"] intValue]];
    
    if ([self.bidArray count] < self.numberOfPlayers) {
        if ([[self.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] typeOfPlayer] != PlayerTypeHuman) {
            //[self performSelector:@selector(setPlayerWhoseTurnItIsNumberVersion:) withObject:([NSNumber numberWithInt:(self.playerWhoseTurnItIs++)]) afterDelay:1.0];
            self.playerWhoseTurnItIs++;
        } else self.playerWhoseTurnItIs++;
    } else if ([self.bidArray count] == self.numberOfPlayers) {
        if ([[self.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman) {
            [self bidOver];
        } else {
           //[self performSelector:@selector(bidOver) withObject:nil afterDelay:1.0]; 
            [self bidOver];
        }
    }
    NSLog(@"BidArray = %@", self.bidArray);
}

- (void) bidOver {
    biddingPromptLabel.hidden = YES;
    biddingInputTextField.hidden = YES;
    bidButton.hidden = YES;
    self.burstStartBidding = NO;
    //sets all the stuff related to actual gameplay as not hidden
    self.playerBidLabel.hidden = NO;
    self.playerTricksTakenLabel.hidden = NO;
    self.playerWhoWonTrickLabel.hidden = NO;
    self.suitLabel.hidden = NO;
    self.valueLabel.hidden = NO;
    self.suitInputTextField.hidden = NO;
    self.valueInputTextField.hidden = NO;
    self.suitInputTextField.enabled = YES;
    self.valueInputTextField.enabled = YES;
    self.promptLabel.hidden = NO;
    self.playButton.hidden = NO;
    self.currentTrickLabel.text = @"Current Trick:";
    self.currentTrickTabelView.hidden = NO;
    biddingPromptLabel.hidden = YES;
    biddingInputTextField.hidden = YES;
    bidButton.hidden = YES;
    biddingInputTextField.enabled = NO;
    
}


#pragma mark - Gameplay
- (IBAction)tempPlayButton:(id)sender {
    
    if ([self.bidArray count] == self.numberOfPlayers) {
    
        if ([self tempAreTheTextFieldsFilledWithNumbers] == YES && [self tempDoesThePlayerHaveTheCard] == YES && [self isTheCardLegal] == YES) {
            /* this long block returns the Card object from the player's hand that corresponds to the suit and value entered
             [[[[self.playersDictionary objectForKey:[NSString stringWithFormat:@"Player%d", self.playerWhoseTurnItIs%self.numberOfPlayers]] currentHand] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d AND value == %d", [[self.suitInputTextField text] intValue], [[self.valueInputTextField text] intValue]]] objectAtIndex:0];*/
            if ([[self.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman) {
                [self playerAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers playsCardWithSuit:[self.suitInputTextField.text intValue] andValue:[self.valueInputTextField.text intValue]];
                
                self.suitInputTextField.text = @"";
                self.valueInputTextField.text = @"";
            }
                
                
            }
        
    
    }
}

- (BOOL) isTheTrickOver {
    if ([self.currentTrick count] < self.numberOfPlayers) {
        return NO;
    } else return YES;
}

- (BOOL) tempAreTheTextFieldsFilledWithNumbers {
    //NSLog(@"%d, %@, %d, %@, %d, %d", [self.valueInputTextField.text length], self.suitInputTextField.text, [self.suitInputTextField.text length],self.valueInputTextField.text, [[self.suitInputTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] length], [[self.valueInputTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] length]);
    if ([self.valueInputTextField.text length] > 0 && self.suitInputTextField.text != nil && [self.suitInputTextField.text length] > 0 && self.valueInputTextField.text != nil && [[self.suitInputTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] length] == 0 && [[self.valueInputTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] length] == 0) {
        return YES;
    } else {
        self.promptLabel.text = [NSString stringWithFormat:@"Sorry, %@ Must Fill The Text Fields With Only Numbers.", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
        return NO;
    }
}

- (BOOL) tempDoesThePlayerHaveTheCard {
    if ([[[[self.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] currentHand] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d AND value == %d", [[self.suitInputTextField text] intValue], [[self.valueInputTextField text] intValue]]] count] != 0) {
        return YES;
    } else {
        self.promptLabel.text = [NSString stringWithFormat:@"Sorry, %@ Does Not Have That Card.", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
        return NO;
    }
}

//based on whether the player has the leading suit
- (BOOL) isTheCardLegal {
    if ([self.currentTrick count] != 0) {
    if ([self.suitInputTextField.text intValue] == [[self.currentTrick objectAtIndex:0] suit]) {
        return YES;
    } else {
        if ([[[[self.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] currentHand] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d", [[self.currentTrick objectAtIndex:0] suit]]] count] == 0) {
            return YES;
        } else {
            self.promptLabel.text = [NSString stringWithFormat:@"Sorry, %@ Must Follow The Leading Suit.", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
            return NO;
        }
    }
    } else {
        return YES;
    }
}



- (void) playerAtIndex:(int)playerIndex playsCardWithSuit:(int)suit andValue:(int)value {
    //adds the currently played card to the trick
    [self.currentTrick addObject:[[[[self.playersArray objectAtIndex:playerIndex] currentHand] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d AND value == %d", suit, value]] objectAtIndex:0]];
    
    //removes the currently played card from that player's hand
    [[[self.playersArray objectAtIndex:playerIndex] currentHand] removeObject:[[[[self.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] currentHand] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d AND value == %d", suit, value]] objectAtIndex:0]];
    
    //Logs both the player's hand and the current trick
    NSLog(@"Curent Trick = %@, %@'s Hand = %@", self.currentTrick, [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name], [[self.playersArray objectAtIndex:playerIndex] currentHand]);
    
    [self.currentTrickTabelView reloadData];
    
    //moves on to the next player
    if ([self isTheTrickOver] == NO) {
        if ([[self.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] typeOfPlayer] != PlayerTypeHuman) {
            [self performSelector:@selector(setPlayerWhoseTurnItIsNumberVersion:) withObject:([NSNumber numberWithInt:(self.playerWhoseTurnItIs++)]) afterDelay:1.0];
        } else self.playerWhoseTurnItIs++;
    } else {
        if ([[self.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] typeOfPlayer] != PlayerTypeHuman) {
            [self performSelector:@selector(determineWhoTheTrickGoesTo) withObject:nil afterDelay:1.0];
        } else [self determineWhoTheTrickGoesTo];
    }
    
    NSLog(@"It Is %@'s Turn.", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]);
    
    //changes prompt
    if ([[self.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman) {
        self.promptLabel.text = [NSString stringWithFormat:@"What Card Would %@ Like To Play?", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
    } else {
        self.promptLabel.text = [NSString stringWithFormat:@"%@ is playing...?", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
    }
    
    /*if ([self isTheTrickOver] == YES) {
        NSLog(@"Trick Complete!");
        [self determineWhoTheTrickGoesTo];
    }*/
    
}




- (void) determineWhoTheTrickGoesTo {
    int playerWhoGetsCurrentTrick;
    NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"value" ascending:NO];
    
    //if there is no trump or no trump in the trick
    if (self.trump == 4 || [[self.currentTrick filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d", self.trump]] count] == 0) {
        playerWhoGetsCurrentTrick = [[[[self.currentTrick filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d", [[self.currentTrick objectAtIndex:0] suit]]] sortedArrayUsingDescriptors:[NSArray arrayWithObject:valueDescriptor]] objectAtIndex:0] whatPlayerTheCardBelongsTo];
        [[[self.playersArray objectAtIndex:playerWhoGetsCurrentTrick] tricksTaken] addObject:[NSArray arrayWithArray:self.currentTrick]];
        [self.currentTrick removeAllObjects];
    } else {
        playerWhoGetsCurrentTrick = [[[[self.currentTrick filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d", self.trump]] sortedArrayUsingDescriptors:[NSArray arrayWithObject:valueDescriptor]] objectAtIndex:0] whatPlayerTheCardBelongsTo];
        [[[self.playersArray objectAtIndex:playerWhoGetsCurrentTrick] tricksTaken] addObject:[NSArray arrayWithArray:self.currentTrick]];
        [self.currentTrick removeAllObjects];
    }
    [self.currentTrickTabelView reloadData];
    
    [valueDescriptor release];
    
    //change prompt so it is the currently took player's turn
    self.playerWhoseTurnItIs = playerWhoGetsCurrentTrick;
    self.promptLabel.text = [NSString stringWithFormat:@"What Card Would %@ Like To Play?", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
    
    NSLog(@"%@ Gets The Trick!!!", [[self.playersArray objectAtIndex:playerWhoGetsCurrentTrick] name]);
    NSLog(@"%@'s Trick's Taken Are: %@", [[self.playersArray objectAtIndex:playerWhoGetsCurrentTrick] name], [[self.playersArray objectAtIndex:playerWhoGetsCurrentTrick] tricksTaken]);
    if ([[self.playersArray objectAtIndex:playerWhoGetsCurrentTrick] typeOfPlayer] == PlayerTypeHuman) {
        self.playerWhoWonTrickLabel.text = [NSString stringWithFormat:@"%@ Won the Trick!", [[self.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] name]];
    } else {
        
    }
    
    
    int numberOFTotalTricksTaken = 0;
    for (Player *p in self.playersArray) {
        numberOFTotalTricksTaken = numberOFTotalTricksTaken + [p.tricksTaken count];
    }
    
    if (self.burstNumberOfCardsPerPersonInTheRound == numberOFTotalTricksTaken) {
        NSLog(@"Round is Over!");
        [self burstRoundOver];
    }
}

- (void) burstRoundOver {
    self.haveTheCardsBeenDealtYetForTheRound = NO;
    NSString *endOfRoundMessage = [[[NSString alloc] init] autorelease];
    for (Player *p in self.playersArray) {
        if ([p bid] == [[p tricksTaken] count]) {
            p.score = p.score + 11*p.bid + 10;
        }
        for (NSMutableArray *tempTrick in p.tricksTaken) {
            [self.brain.gameDeck addObjectsFromArray:tempTrick];
        }
        [p.tricksTaken removeAllObjects];
        NSLog(@"%@'s score is %d", p.name, p.score);
        NSLog(@"Deck has %d cards", [self.brain.gameDeck count]);
        endOfRoundMessage = [endOfRoundMessage stringByAppendingFormat:@"%@'s score is %d \n", p.name, p.score];
    }
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Round Over!"
                                                      message:endOfRoundMessage
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    [message release];
    
    
    [self.bidArray removeAllObjects];
    
    self.burstNumberOfCardsPerPersonInTheRound--;
    
    [self equalCardsPerPlayer:self.burstNumberOfCardsPerPersonInTheRound];
    [self.brain shuffle];
    
    self.dealer++;
    
    //player who starts is the player after the dealer
    self.playerWhoseTurnItIs = self.dealer%self.numberOfPlayers + 1;
    
    [self deal];
    for (Player *p in self.playersArray) {
        [p arrangeBySuit];
    }
    self.burstStartBidding = YES;
}

#pragma mark - UITableViewStuff

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((int)tableView.frame.size.height / 30);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;
    if (tableView.frame.size.height == 300) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    if (tableView.frame.size.height == 150) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
    }
    
    // Configure the cell...
    
    
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    cell.backgroundColor = [UIColor whiteColor];
    //[cell setFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, 30)];
    cell.textLabel.textColor = [UIColor blackColor];
    
    if (tableView.frame.size.height == 300) {
        if (indexPath.row < [[[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] currentHand] count]) {
        cell.textLabel.text = [NSString stringWithFormat:@"{%d, %d)", [[[[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] currentHand] objectAtIndex:indexPath.row] suit], [[[[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] currentHand] objectAtIndex:indexPath.row] value]];
        } else {
            cell.textLabel.text = @"";
        }
    }
    
    if (tableView.frame.size.height == 150) {
        if (indexPath.row < [self.currentTrick count]) {
        cell.textLabel.text = [NSString stringWithFormat:@"%d: {%d, %d)", [[self.currentTrick objectAtIndex:indexPath.row] whatPlayerTheCardBelongsTo],[[self.currentTrick objectAtIndex:indexPath.row] suit], [[self.currentTrick objectAtIndex:indexPath.row] value]];
        } else {
            cell.textLabel.text = @"";
        }
    }
    
    //cell.textLabel.text = @"hi";
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
    
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName = @"";
    if (tableView.frame.size.height == (CGFloat)300) {
        sectionName = [sectionName stringByAppendingFormat:@"%@", [[self.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
    }
    if (tableView.frame.size.height == (CGFloat)150) {
        sectionName = [sectionName stringByAppendingFormat:@"CurrentTrick"];
    }
    return sectionName;
}
                                       
@end
