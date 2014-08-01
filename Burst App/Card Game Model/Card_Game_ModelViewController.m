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
//@synthesize numberOfPlayers = _numberOfPlayers;
//@synthesize playersArray = _playersArray;
//@synthesize cardsPerPlayer = _cardsPerPlayer;
//@synthesize playerWhoseTurnItIs = _playerWhoseTurnItIs;
//@synthesize dealer = _dealer;
@synthesize promptLabel = _promptLabel;
//@synthesize currentTrick = _currentTrick;
@synthesize bidInputTextField = _bidInputTextField;
@synthesize bidButton = _bidButton;
@synthesize bidPromptLabel = _bidPromptLabel;
@synthesize playerBidLabel = _playerBidLabel;
@synthesize playerTricksTakenLabel = _playerTricksTakenLabel;
@synthesize arrayOfViablePoints =_arrayOfViablePoints;
//@synthesize burstStartBidding = _burstStartBidding;
//@synthesize bidArray = _bidArray;
//@synthesize burstNumberOfCardsPerPersonInTheRound = _burstNumberOfCardsPerPersonInTheRound;
//@synthesize haveTheCardsBeenDealtYetForTheRound = _haveTheCardsBeenDealtYetForTheRound;
@synthesize delegate = _delegate;

- (Model *)brain {
    //lazy instantiation of brain
    if (_brain == nil) _brain = [[Model alloc] init];
    return _brain;
}

- (NSMutableArray *)arrayOfViablePoints {
    //lazy instantiation of arrayOfViablePoints
    if (_arrayOfViablePoints == nil) _arrayOfViablePoints = [[NSMutableArray alloc] init];
    return _arrayOfViablePoints;
}

/*- (void) setPlayerWhoseTurnItIs:(int)playerWhoseTurnItIs {
    int previousPlayer = _playerWhoseTurnItIs;
    _playerWhoseTurnItIs = playerWhoseTurnItIs;
    NSLog(@"It Is %@'s Turn.", [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]);
    [self.playersCards reloadData];
    if ([[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"] count] < self.numberOfPlayers) {
        
        //BID START
        if (self.playerBidLabel.hidden != YES || self.playerTricksTakenLabel.hidden != YES || self.playerWhoWonTrickLabel.hidden != YES || self.suitLabel.hidden != YES || self.valueLabel.hidden != YES || self.suitInputTextField.hidden != YES || self.valueInputTextField.hidden != YES || self.suitInputTextField.enabled != NO || self.valueInputTextField.enabled != NO || self.promptLabel.hidden != YES || self.playButton.hidden != YES || [self.currentTrickLabel.text isEqualToString:@""] == NO || self.currentTrickTabelView.hidden != YES || self.bidPromptLabel.hidden != NO || self.bidInputTextField.hidden != NO || self.bidButton.hidden != NO || self.bidInputTextField.enabled != YES) {
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
            self.bidPromptLabel.hidden = NO;
            self.bidInputTextField.hidden = NO;
            self.bidButton.hidden = NO;
        }
        
        if ([[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman) {
            
            
            
            if ([[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs-1)%self.numberOfPlayers] typeOfPlayer] != PlayerTypeHuman) {
                bool yes = YES;
                //wait one second if last player was AI
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[self.bidInputTextField class] instanceMethodSignatureForSelector:@selector(setEnabled:)]];
                [invocation setTarget:self.bidInputTextField];
                [invocation setSelector:@selector(setEnabled:)];
                [invocation setArgument:&yes atIndex:2];
                [invocation performSelector:@selector(invoke) withObject:nil afterDelay:1.0];
                
                invocation = [NSInvocation invocationWithMethodSignature:[[self.bidButton class] instanceMethodSignatureForSelector:@selector(setEnabled:)]];
                [invocation setTarget:self.bidButton];
                [invocation setSelector:@selector(setEnabled:)];
                [invocation setArgument:&yes atIndex:2];
                [invocation performSelector:@selector(invoke) withObject:nil afterDelay:1.0];
                
                
                [self.bidPromptLabel performSelector:@selector(setText:) withObject:[NSString stringWithFormat:@"What would %@ like to bid?", [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]] afterDelay:1.0];
            } else {
                self.bidInputTextField.enabled = YES;
                self.bidButton.enabled = YES;
        
                NSLog(@"player is human");
        
                self.bidPromptLabel.text = [NSString stringWithFormat:@"What would %@ like to bid?", [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
            //}
        
        
        } else {
            self.bidInputTextField.enabled = NO;
            self.bidButton.enabled = NO;
        
            //if previous player was human, still wait one second
            if ([[self.brain.playersArray objectAtIndex:previousPlayer%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman) {
                
                int index = self.playerWhoseTurnItIs%self.numberOfPlayers;
                int bid = [[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] playersBidWithTrump:self.brain.trump arrayOfBids:[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"] andNumberOfPlayers:self.numberOfPlayers];
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:@selector(playerAtIndex:bids:)]];
                [invocation setTarget:self];
                [invocation setSelector:@selector(playerAtIndex:bids:)];
                [invocation setArgument:&index atIndex:2];
                [invocation setArgument:&bid atIndex:3];
                [invocation performSelector:@selector(invoke) withObject:nil afterDelay:1.0];
            } else {
                [self playerAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers bids:[[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] playersBidWithTrump:self.brain.trump arrayOfBids:[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"] andNumberOfPlayers:self.numberOfPlayers]];
            }
        }
    } else if ([[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"] count] == self.numberOfPlayers) {
        
        //PLAY START
        if (self.bidPromptLabel.hidden != YES || self.bidInputTextField.hidden != YES || self.bidButton.hidden != YES || self.playerBidLabel.hidden != NO || self.playerTricksTakenLabel.hidden != NO || self.playerWhoWonTrickLabel.hidden != NO || self.suitLabel.hidden != NO || self.valueLabel.hidden != NO || self.suitInputTextField.hidden != NO || self.valueInputTextField.hidden != NO || self.suitInputTextField.enabled != YES || self.valueInputTextField.enabled != YES || self.promptLabel.hidden != NO || self.playButton.hidden != NO || [self.currentTrickLabel.text isEqualToString:@"Current Trick:"] == NO || self.currentTrickTabelView.hidden != NO || self.bidPromptLabel.hidden != YES || self.bidInputTextField.hidden != YES || self.bidButton.hidden != YES || self.bidInputTextField.enabled != NO) {
            self.bidPromptLabel.hidden = YES;
            self.bidInputTextField.hidden = YES;
            self.bidButton.hidden = YES;
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
            self.bidPromptLabel.hidden = YES;
            self.bidInputTextField.hidden = YES;
            self.bidButton.hidden = YES;
            self.bidInputTextField.enabled = NO;
            
        }
        
        self.playerBidLabel.text = [NSString stringWithFormat:@"%@'s bid is %@", [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name], [[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"] objectAtIndex:(playerWhoseTurnItIs%self.numberOfPlayers)]];
        self.playerTricksTakenLabel.text = [NSString stringWithFormat:@"%@ has taken %d tricks.", [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name], [[[self.brain.playersArray objectAtIndex:(playerWhoseTurnItIs%self.numberOfPlayers)] tricksTaken] count]];
        
        //changes prompt
        if ([[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman) {
            self.playButton.enabled = YES;
            self.suitInputTextField.enabled = YES;
            self.valueInputTextField.enabled = YES;
            self.promptLabel.text = [NSString stringWithFormat:@"What Card Would %@ Like To Play?", [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
        } else {
            self.playButton.enabled = NO;
            self.suitInputTextField.enabled = NO;
            self.valueInputTextField.enabled = NO;
            self.promptLabel.text = [NSString stringWithFormat:@"%@ is playing...", [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
            
            //if previous player was human, still wait one second
            if ([[self.brain.playersArray objectAtIndex:previousPlayer%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman) {
                
                int index = self.playerWhoseTurnItIs%self.numberOfPlayers;
                int suit = [[[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] cardToBePlayedWithStartingSuit:self.currentTrick andTrump:self.brain.trump andtricksTakenPerPlayer:[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.tricksTaken"] andBidArray:[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"]] suit];
                int value = [[[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] cardToBePlayedWithStartingSuit:self.currentTrick andTrump:self.brain.trump andtricksTakenPerPlayer:[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.tricksTaken"] andBidArray:[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"]] value];
                
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:@selector(playerAtIndex:bids:)]];
                [invocation setTarget:self];
                [invocation setSelector:@selector(playerAtIndex:playsCardWithSuit:andValue:)];
                [invocation setArgument:&index atIndex:2];
                [invocation setArgument:&suit atIndex:3];
                [invocation setArgument:&value atIndex:4];
                [invocation performSelector:@selector(invoke) withObject:nil afterDelay:1.0];
            } else {
                [self playerAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers playsCardWithSuit:[[[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] cardToBePlayedWithStartingSuit:self.currentTrick andTrump:self.brain.trump andtricksTakenPerPlayer:[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.tricksTaken"] andBidArray:[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"]] suit] andValue:[[[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] cardToBePlayedWithStartingSuit:self.currentTrick andTrump:self.brain.trump andtricksTakenPerPlayer:[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.tricksTaken"] andBidArray:[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"]] value]];
            }
        }
    }
}*/


- (void)dealloc
{
    [_promptLabel release];
    [_playerBidLabel release];
    [_playerTricksTakenLabel release];
    [_bidPromptLabel release];
    [_bidInputTextField release];
    [_bidButton release];
    [_arrayOfViablePoints release];
    [_currentTrickLabel release];
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
    //register for keys from the model
    [self.brain addObserver:self forKeyPath:@"trump" options:NSKeyValueObservingOptionNew context:nil];
    [self.brain addObserver:self forKeyPath:@"playersArray" options:NSKeyValueObservingOptionNew context:nil];
    [self.brain addObserver:self forKeyPath:@"numberOfCardsPerPersonInTheRound" options:NSKeyValueObservingOptionOld context:nil];
    [self.brain addObserver:self forKeyPath:@"playersHaveBeenCreated" options:NSKeyValueObservingOptionNew context:nil];
    [self.brain addObserver:self forKeyPath:@"playerWhoseTurnItIs" options:NSKeyValueObservingOptionNew context:nil];
    
    self.playerWhoWonTrickLabel.text = @"";
    
    
    self.bidInputTextField.inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
     
    self.promptLabel.adjustsFontSizeToFitWidth = YES;
    
    self.playerBidLabel.text = @"";
    self.playerTricksTakenLabel.text = @"";
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTouchedScreen:)];
    tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [tapGestureRecognizer release];
    
    [super viewDidLoad];
    [self.brain startGame];
    for (Card *c in self.brain.gameDeck) {
        c.transform = CGAffineTransformIdentity;
    }
    //[self updatePlayersHand];
    //[self.view addSubview:[self.brain.gameDeck objectAtIndex:0]];
    
}


- (void)viewDidUnload
{
    [self setPromptLabel:nil];
    [self setPlayerBidLabel:nil];
    [self setPlayerTricksTakenLabel:nil];
    [self setBidPromptLabel:nil];
    [self setBidInputTextField:nil];
    [self setBidButton:nil];
    [self setArrayOfViablePoints:nil];
    [self setCurrentTrickLabel:nil];
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

/*- (void) createPlayers {
    for (int i = 0; i < self.numberOfPlayers; i++) {
        if (i == 0) {
                Player *tempPlayer = [[Player alloc] initWithType:PlayerTypeHuman];
                [tempPlayer setName:[NSString stringWithFormat:@"Player%d", i]];
                [tempPlayer setScore:0];
                [self.brain.playersArray addObject:tempPlayer];
                [tempPlayer release];
        }
        if (i == 0 || i == 2 || i == 4) {
            Player *tempPlayer = [[Player alloc] initWithType:PlayerTypeAICardPlayToWinHand];
            [tempPlayer setName:[NSString stringWithFormat:@"Player%d", i]];
            [tempPlayer setScore:0];
            [self.brain.playersArray addObject:tempPlayer];
            [tempPlayer release];
        }
        if (i == 3 || i == 1) {
            Player *tempPlayer = [[Player alloc] initWithType:PlayerTypeAIPlayFirstPlayableCard];
            [tempPlayer setName:[NSString stringWithFormat:@"Player%d", i]];
            [tempPlayer setScore:0];
            [self.brain.playersArray addObject:tempPlayer];
            [tempPlayer release];
        }
    }
    NSLog(@"%@", self.brain.playersArray);
}

- (void) deal {
    for (int i = 0; i < self.numberOfPlayers; i++) {
        [[[self.brain.playersArray objectAtIndex:i] currentHand] removeAllObjects];
    }
    
    int totalNumberOfCardsDealt = 0;
    for (int n = 0; n < self.numberOfPlayers; n++) {

        totalNumberOfCardsDealt = totalNumberOfCardsDealt + [[self.cardsPerPlayer objectAtIndex:n] intValue];
    }
    NSLog(@"Total Number Of Cards Dealt Is %d", totalNumberOfCardsDealt);
    
    for (int i = 0; i < totalNumberOfCardsDealt; i++) {
            [[self.brain.gameDeck objectAtIndex:0] setWhatPlayerTheCardBelongsTo:(i%self.numberOfPlayers)];
            [[[self.brain.playersArray objectAtIndex:(i%self.numberOfPlayers)] currentHand] addObject:[self.brain.gameDeck objectAtIndex:0]];
            [self.brain.gameDeck removeObjectAtIndex:0];
    }
    NSLog(@"%@", self.brain.playersArray);
    NSLog(@"Game Deck  = %@", self.brain.gameDeck);
    
    self.promptLabel.text = [NSString stringWithFormat:@"What Card Would %@ Like To Play?", [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
    //self.haveTheCardsBeenDealtYetForTheRound = YES;
}

- (void) equalCardsPerPlayer:(int)numberOfCardsPerPlayer {
    [self.cardsPerPlayer removeAllObjects];
    for (int i = 0; i < self.numberOfPlayers; i++) {
        [self.cardsPerPlayer addObject:[NSNumber numberWithInt:numberOfCardsPerPlayer]];
    }
    NSLog(@"Cards Per Player = %@", self.cardsPerPlayer);
}

//add a deal all cards method.  however, for that we must kdate who the deal stats on!!!*/

- (void)userTouchedScreen:(UITapGestureRecognizer *)recognizer {
    int width;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        width = 320;
    } else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        width = 460;
    }
    for (Card *c in [[[self.brain playersArray] objectAtIndex:[self.brain currentPlayerIndex]] currentHand]) {
        
        CGPoint location = [recognizer locationInView:c];
        NSLog(@"location position in card %@ x = %f, y = %f", c, location.x, location.y);
        float interval = width / [[[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] currentHand] count];
        if ([[[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] currentHand] count]*[Card cardWidth] >= width) {
            
            if (location.x >= 0 && location.x <= interval && location.y >= 0 && location.y <= c.frame.size.height) {
                [self playAction:c];
                break;
            }
        } else {
            if (location.x >= 0 && location.x <= c.frame.size.width && location.y >= 0 && location.y <= c.frame.size.height) {
                [self playAction:c];
                break;
            }
        }
    }
}

#pragma mark - Burst Bidding

- (IBAction)bidAction:(id)sender {
    if ([self.brain isTheBidOver] == NO) {
    if ([[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] typeOfPlayer] == PlayerTypeHuman) {
    if ([self.brain numberOfPlayersThatHaveBidSoFar] < self.brain.numberOfPlayers) {
        
        if ([self.bidInputTextField.text length] > 0 && self.bidInputTextField.text != nil && [[self.bidInputTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] length] == 0) {
            if ([self.brain isTheBidBetweenTheCorrectNumbers:[self.bidInputTextField.text intValue]] == YES) {
                if ([self.brain doesTheBidNotMakeItAnEvenBidIfItIsTheLastPlayer:[self.bidInputTextField.text intValue]] == YES) {
                    [self.brain currentPlayerBids:[self.bidInputTextField.text intValue]];
                } else {
                    self.bidPromptLabel.text = [NSString stringWithFormat:@"Sorry, %@'s bid cannot make it an even bid.", [[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] name]];
                }
            } else {
                self.bidPromptLabel.text = [NSString stringWithFormat:@"Sorry, %@'s must bid between 0 & %d, inclusive.", [[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] name], self.brain.numberOfCardsPerPersonInTheRound];
            }
        } else {
            self.bidPromptLabel.text = [NSString stringWithFormat:@"Sorry, %@'s must type in only a number.", [[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] name]];
        }
    }
    }
    }
}

/*- (void) playerAtIndex:(int)playerIndex bids:(int)bid {
    
   
    
    //BID IN PROGRESS
    [[self.brain.playersArray objectAtIndex:playerIndex] setBid:bid];
    [[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"] addObject:[NSNumber numberWithInt:bid]];
    self.bidInputTextField.text = @"";
    
    self.bidPromptLabel.text = [NSString stringWithFormat:@"%@ bid %d", [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name], [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] bid]];
    self.currentTrickLabel.text = [NSString stringWithFormat:@"Sum of Bids = %d", [[[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"] valueForKeyPath:@"@sum.self"] intValue]];
    NSLog(@"BidArray = %@", [self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"]);
    
    if ([[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman && [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs + 1)%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman) {
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
}*/

/*- (void) bid {
    //BID START
    if (self.playerBidLabel.hidden != YES || self.playerTricksTakenLabel.hidden != YES || self.playerWhoWonTrickLabel.hidden != YES || self.suitLabel.hidden != YES || self.valueLabel.hidden != YES || self.suitInputTextField.hidden != YES || self.valueInputTextField.hidden != YES || self.suitInputTextField.enabled != NO || self.valueInputTextField.enabled != NO || self.promptLabel.hidden != YES || self.playButton.hidden != YES || [self.currentTrickLabel.text isEqualToString:@""] == NO || self.currentTrickTabelView.hidden != YES || self.bidPromptLabel.hidden != NO || self.bidInputTextField.hidden != NO || self.bidButton.hidden != NO || self.bidInputTextField.enabled != YES) {
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
    }
    
    //BID IN PROGRESS
    if ([[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman) {
        
        biddingInputTextField.enabled = YES;
        bidButton.enabled = YES;
        
        NSLog(@"player is human");
        
        biddingPromptLabel.text = [NSString stringWithFormat:@"What would %@ like to bid?", [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
        
        
        [[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] setBid:[biddingInputTextField.text intValue]];
        [[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"] addObject:[NSNumber numberWithInt:[biddingInputTextField.text intValue]]];
        
        self.currentTrickLabel.text = [NSString stringWithFormat:@"Sum of Bids = %d", [[[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"] valueForKeyPath:@"@sum.self"] intValue]];
        NSLog(@"Sum of Bids = %d", [[[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"] valueForKeyPath:@"@sum.self"] intValue]);
        
        NSLog(@"bidArray = %@", [self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"]);
        
        self.bidInputTextField.text = @"";
        
        
        self.bidButtonHasBeenClicked = NO;
        self.playerWhoseTurnItIs++;  
        
        } else {
            
            self.bidInputTextField.enabled = NO;
            self.bidButton.enabled = NO;
        
            int bid = [[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] playersBidWithTrump:self.brain.trump arrayOfBids:[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"] andNumberOfPlayers:self.numberOfPlayers];
            
            NSLog(@"%@ bids %d.", [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name], bid);

            biddingPromptLabel.text = [NSString stringWithFormat:@"%@ bids %d.", [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name], bid];
            
            [[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] setBid:bid];
            [[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"] addObject:[NSNumber numberWithInt:bid]];
            
            self.bidInputTextField.text = @"";
            
            self.currentTrickLabel.text = [NSString stringWithFormat:@"Sum of Bids = %d", [[[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"] valueForKeyPath:@"@sum.self"] intValue]];
            NSLog(@"Sum of Bids = %d", [[[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"] valueForKeyPath:@"@sum.self"] intValue]);
            
            NSLog(@"bidArray = %@", [self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"]);
        
            
            //self.playerWhoseTurnItIs++;
        
    }

    if ([[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"] count] < self.numberOfPlayers) {
        //recursively calls this method, with a break if it is AI
        if ([[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs-1)%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman) {
            [self bid];
        } else {
            [self performSelector:@selector(bid) withObject:nil afterDelay:1.0];
        }
    } else {
        //BID END Note: graphical elements get removed in playStart
        if ([[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs-1)%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman) {
            [self play];
        } else {
            [self performSelector:@selector(play) withObject:nil afterDelay:1.0];
        }
    
    }
}*/

#pragma mark - Gameplay
- (void)playAction:(Card *)sender {
    if ([self.brain isTheBidOver] == YES) {
    if ([[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] typeOfPlayer] == PlayerTypeHuman && [self.brain isTheBidOver] == YES) {
            
            if ([self.brain doesThePlayerHaveTheCard:sender] == YES) {
                
                if ([self.brain isTheCardLegal:sender] == YES) {
                    [self.brain currentPlayerPlaysCardWithSuit:[(Card *)sender suit] andValue:[(Card *)sender value]];                    
                } else {
                    self.promptLabel.text = [NSString stringWithFormat:@"Sorry, %@ Must Follow The Leading Suit.", [[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] name]];
                }
                
            } else {
                self.promptLabel.text = [NSString stringWithFormat:@"Sorry, %@ Does Not Have That Card.", [[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] name]];
            }
    }
            
    }
}

/*- (IBAction)playAction:(id)sender {
    if ([[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] typeOfPlayer] == PlayerTypeHuman) {
        if ([self.valueInputTextField.text length] > 0 && self.suitInputTextField.text != nil && [self.suitInputTextField.text length] > 0 && self.valueInputTextField.text != nil && [[self.suitInputTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] length] == 0 && [[self.valueInputTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] length] == 0) {
            
            if ([self.brain doesThePlayerHaveTheCard:[Card cardWithSuit:[[self.suitInputTextField text] intValue] andValue:[[self.valueInputTextField text] intValue]]] == YES) {
                
                if ([self.brain isTheCardLegal:[Card cardWithSuit:[[self.suitInputTextField text] intValue] andValue:[[self.valueInputTextField text] intValue]]] == YES) {
                    [self.brain currentPlayerPlaysCardWithSuit:[[self.suitInputTextField text] intValue] andValue:[[self.valueInputTextField text] intValue]];
                    
                    self.suitInputTextField.text = @"";
                    self.valueInputTextField.text = @"";
                    
                } else {
                    self.promptLabel.text = [NSString stringWithFormat:@"Sorry, %@ Must Follow The Leading Suit.", [[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] name]];
                }
                
            } else {
                self.promptLabel.text = [NSString stringWithFormat:@"Sorry, %@ Does Not Have That Card.", [[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] name]];
            }
            
        } else {
            self.promptLabel.text = [NSString stringWithFormat:@"Sorry, %@ Must Fill The Text Fields With Only Numbers.", [[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] name]];
        }
    }
}*/

/*- (BOOL) isTheTrickOver {
    if ([self.currentTrick count] < self.numberOfPlayers) {
        return NO;
    } else return YES;
}*/

/*- (BOOL) tempDoesThePlayerHaveTheCard {
    if ([[[[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] currentHand] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d AND value == %d", [[self.suitInputTextField text] intValue], [[self.valueInputTextField text] intValue]]] count] != 0) {
        return YES;
    } else {
        self.promptLabel.text = [NSString stringWithFormat:@"Sorry, %@ Does Not Have That Card.", [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
        return NO;
    }
}

//based on whether the player has the leading suit
- (BOOL) isTheCardLegal {
    if ([self.currentTrick count] != 0) {
    if ([self.suitInputTextField.text intValue] == [[self.currentTrick objectAtIndex:0] suit]) {
        return YES;
    } else {
        if ([[[[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] currentHand] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d", [[self.currentTrick objectAtIndex:0] suit]]] count] == 0) {
            return YES;
        } else {
            self.promptLabel.text = [NSString stringWithFormat:@"Sorry, %@ Must Follow The Leading Suit.", [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
            return NO;
        }
    }
    } else {
        return YES;
    }
}
               

- (void) playerAtIndex:(int)playerIndex playsCardWithSuit:(int)suit andValue:(int)value {
    
    
    //PLAY IN PROGRESS
    //adds the currently played card to the trick
    [self.currentTrick addObject:[[[[self.brain.playersArray objectAtIndex:playerIndex] currentHand] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d AND value == %d", suit, value]] objectAtIndex:0]];
                   
    //removes the currently played card from that player's hand
    [[[self.brain.playersArray objectAtIndex:playerIndex] currentHand] removeObject:[[[[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] currentHand] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d AND value == %d", suit, value]] objectAtIndex:0]];
                   
    //Logs both the player's hand and the current trick
    NSLog(@"Curent Trick = %@, %@'s Hand = %@", self.currentTrick, [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name], [[self.brain.playersArray objectAtIndex:playerIndex] currentHand]);
                   
    [self.currentTrickTabelView reloadData];
                   
    //moves on to the next player
    if ([self isTheTrickOver] == NO) {
    if ([[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman) {
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
        if ([[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman && [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs + 1)%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman) {
            [self determineWhoTheTrickGoesTo];
        } else {
            //waits one second if current player and/or next layer is AI
            
            [self performSelector:@selector(determineWhoTheTrickGoesTo) withObject:nil afterDelay:1.0];
        }
    }
                   
                   
    //if ([self isTheTrickOver] == YES) {
    //NSLog(@"Trick Complete!");
    //self determineWhoTheTrickGoesTo];
    //}
                   
}*/

/*- (void) play {
    //PLAY START
    if (self.bidPromptLabel.hidden != YES || self.bidInputTextField.hidden != YES || self.bidButton.hidden != YES || self.playerBidLabel.hidden != NO || self.playerTricksTakenLabel.hidden != NO || self.playerWhoWonTrickLabel.hidden != NO || self.suitLabel.hidden != NO || self.valueLabel.hidden != NO || self.suitInputTextField.hidden != NO || self.valueInputTextField.hidden != NO || self.suitInputTextField.enabled != YES || self.valueInputTextField.enabled != YES || self.promptLabel.hidden != NO || self.playButton.hidden != NO || [self.currentTrickLabel.text isEqualToString:@"Current Trick:"] == NO || self.currentTrickTabelView.hidden != NO || self.bidPromptLabel.hidden != YES || self.bidInputTextField.hidden != YES || self.bidButton.hidden != YES || self.bidInputTextField.enabled != NO) {
        self.bidPromptLabel.hidden = YES;
        self.bidInputTextField.hidden = YES;
        self.bidButton.hidden = YES;
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
        self.bidPromptLabel.hidden = YES;
        self.bidInputTextField.hidden = YES;
        self.bidButton.hidden = YES;
        self.bidInputTextField.enabled = NO;
        
    }
    
    if ([[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman) {
        self.playButton.enabled = YES;
        
        self.promptLabel.text = [NSString stringWithFormat:@"What Card Would %@ Like To Play?", [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name]];
        
        //waits for user input
        while (self.playButtonHasBeenClicked == NO) {
        }
        
        //adds the currently played card to the trick
        [self.currentTrick addObject:[[[[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] currentHand] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d AND value == %d", [self.suitInputTextField.text intValue], [self.valueInputTextField.text intValue]]] objectAtIndex:0]];
        
        //removes the currently played card from that player's hand
        [[[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] currentHand] removeObject:[[[[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] currentHand] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d AND value == %d", [self.suitInputTextField.text intValue], [self.valueInputTextField.text intValue]]] objectAtIndex:0]];
        
        //Logs both the player's hand and the current trick
        NSLog(@"Curent Trick = %@, %@'s Hand = %@", self.currentTrick, [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name], [[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] currentHand]);
        
        [self.currentTrickTabelView reloadData];
        self.playerWhoseTurnItIs++;
        self.playButtonHasBeenClicked = NO;
        
    } else {
        self.playButton.enabled = NO;
        
        //adds the currently played card to the trick
        [self.currentTrick addObject:[[[[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] currentHand] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d AND value == %d", [[[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] cardToBePlayedWithStartingSuit:self.currentTrick andTrump:self.brain.trump andtricksTakenPerPlayer:[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.tricksTaken"] andBidArray:[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"]] suit], [[[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] cardToBePlayedWithStartingSuit:self.currentTrick andTrump:self.brain.trump andtricksTakenPerPlayer:[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.tricksTaken"] andBidArray:[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"]] value]]] objectAtIndex:0]];
        
        //removes the currently played card from that player's hand
        [[[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] currentHand] removeObject:[[[[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] currentHand] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d AND value == %d", [[[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] cardToBePlayedWithStartingSuit:self.currentTrick andTrump:self.brain.trump andtricksTakenPerPlayer:[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.tricksTaken"] andBidArray:[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"]] suit], [[[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] cardToBePlayedWithStartingSuit:self.currentTrick andTrump:self.brain.trump andtricksTakenPerPlayer:[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.tricksTaken"] andBidArray:[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"]] value]]] objectAtIndex:0]];
        
        //Logs both the player's hand and the current trick
        NSLog(@"Curent Trick = %@, %@'s Hand = %@", self.currentTrick, [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs%self.numberOfPlayers)] name], [[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] currentHand]);
        
        [self.currentTrickTabelView reloadData];
        self.playerWhoseTurnItIs++;
    }
    
    if ([self.currentTrick count] < self.numberOfPlayers) {
        //recursively calls this method with break if AI
        if ([[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs-1)%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman) {
            [self play];
        } else {
            [self performSelector:@selector(play) withObject:nil afterDelay:1.0];
        }
    } else {
        //PLAY END
        if ([[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs-1)%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman) {
            [self determineWhoTheTrickGoesTo];
        } else {
            [self performSelector:@selector(determineWhoTheTrickGoesTo) withObject:nil afterDelay:1.0];
        }
            
        }
    
}*/

/*- (void) determineWhoTheTrickGoesTo {
    int playerWhoGetsCurrentTrick;
    NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"value" ascending:NO];
    
    //if there is no trump or no trump in the trick
    if (self.brain.trump == 4 || [[self.currentTrick filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d", self.brain.trump]] count] == 0) {
        playerWhoGetsCurrentTrick = [[[[self.currentTrick filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d", [[self.currentTrick objectAtIndex:0] suit]]] sortedArrayUsingDescriptors:[NSArray arrayWithObject:valueDescriptor]] objectAtIndex:0] whatPlayerTheCardBelongsTo];
        [[[self.brain.playersArray objectAtIndex:playerWhoGetsCurrentTrick] tricksTaken] addObject:[NSArray arrayWithArray:self.currentTrick]];
        [self.currentTrick removeAllObjects];
    } else {
        playerWhoGetsCurrentTrick = [[[[self.currentTrick filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"suit == %d", self.brain.trump]] sortedArrayUsingDescriptors:[NSArray arrayWithObject:valueDescriptor]] objectAtIndex:0] whatPlayerTheCardBelongsTo];
        [[[self.brain.playersArray objectAtIndex:playerWhoGetsCurrentTrick] tricksTaken] addObject:[NSArray arrayWithArray:self.currentTrick]];
        [self.currentTrick removeAllObjects];
    }
    [self.currentTrickTabelView reloadData];
    
    [valueDescriptor release];
    
    NSLog(@"%@ Gets The Trick!!!", [[self.brain.playersArray objectAtIndex:playerWhoGetsCurrentTrick] name]);
    NSLog(@"%@'s Trick's Taken Are: %@", [[self.brain.playersArray objectAtIndex:playerWhoGetsCurrentTrick] name], [[self.brain.playersArray objectAtIndex:playerWhoGetsCurrentTrick] tricksTaken]);
    
    self.playerWhoWonTrickLabel.text = [NSString stringWithFormat:@"%@ Won the Trick!", [[self.brain.playersArray objectAtIndex:playerWhoGetsCurrentTrick%self.numberOfPlayers] name]];
    
    
    int numberOFTotalTricksTaken = 0;
    for (Player *p in self.brain.playersArray) {
        numberOFTotalTricksTaken = numberOFTotalTricksTaken + [p.tricksTaken count];
    }
    
    if (self.burstNumberOfCardsPerPersonInTheRound == numberOFTotalTricksTaken) {
        NSLog(@"Round is Over!");
        if ([[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman) {
            [self burstRoundOver];
        } else {
            //waits one second
            [self performSelector:@selector(burstRoundOver) withObject:nil afterDelay:1.0];
        }
    } else {
        if ([[self.brain.playersArray objectAtIndex:self.playerWhoseTurnItIs%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman && [[self.brain.playersArray objectAtIndex:(self.playerWhoseTurnItIs + 1)%self.numberOfPlayers] typeOfPlayer] == PlayerTypeHuman) {
            self.playerWhoseTurnItIs = playerWhoGetsCurrentTrick;
        } else {
            //waits one second if current player and/or next player is AI
            int nextPlayer = playerWhoGetsCurrentTrick;
            
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:@selector(setPlayerWhoseTurnItIs:)]];
            [invocation setTarget:self];
            [invocation setSelector:@selector(setPlayerWhoseTurnItIs:)];
            [invocation setArgument:&nextPlayer atIndex:2];
            [invocation performSelector:@selector(invoke) withObject:nil afterDelay:1.0];
        }
    }
}*/

/*- (void) burstRoundOver {
    //self.haveTheCardsBeenDealtYetForTheRound = NO;
    NSString *endOfRoundMessage = [[[NSString alloc] init] autorelease];
    for (Player *p in self.brain.playersArray) {
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
                                                     delegate:self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    [message release];
    
    
    //rest of endRound stuff happens in alertview's buttonclick event (see below)
}*/

- (void) updatePlayersHand {
    int width = [[UIScreen mainScreen] bounds].size.width;
    int height = [[UIScreen mainScreen] bounds].size.height;
    //if less cards than full width, no overlab n center
    for (Card *c in [[[self.brain playersArray] objectAtIndex:[self.brain previousPlayerIndex]] currentHand]) {
        [c removeFromSuperview];
    }
    float interval = width / [[[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] currentHand] count];
        if ([[[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] currentHand] count]*[Card cardWidth] >= width) {
            NSLog(@"no offest for cards");
            for (Card *c in [[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] currentHand]) {
                c.frame = CGRectMake(interval*[[[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] currentHand] indexOfObject:c], height - c.frame.size.height, [Card cardWidth], [Card cardWidth]*3.5/2.25);
                [self.view addSubview:c];
            }
        } else {
            NSLog(@"offest for cards");
            float firstCardOffset = (width - [[[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] currentHand] count]*[Card cardWidth]) / 2;
            for (Card *c in [[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] currentHand]) {
                c.frame = CGRectMake((firstCardOffset + [Card cardWidth]*[[[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] currentHand] indexOfObject:c]), height - c.frame.size.height, [Card cardWidth], [Card cardWidth]*3.5/2.25);
                [self.view addSubview:c];
            }
        }
    
}

- (void) moveCard:(Card *)card {
    if ([self.brain.currentTrick count] == 1) {
        self.arrayOfViablePoints = [self viablePointsToMoveACardTo];
    }
    NSLog(@"viable points = %@", self.arrayOfViablePoints);
    
    // all the card has been played stuff here is temp, i need to figure out how you can only get into this method if card is being played, n where the cardhasbeeplayed prop shud be set
    if (card.cardHasBeenPlayed == NO) {
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         int randomNumber = arc4random()%[self.arrayOfViablePoints count];
                         CGPoint point = [[self.arrayOfViablePoints objectAtIndex:randomNumber] CGPointValue];
                         NSLog(@"card frame = %@", NSStringFromCGRect(card.frame));
                         float angle = (arc4random()%20);
                         angle = angle / 50;
                         NSLog(@"angle = %f", angle);
                         BOOL yesOrNo = arc4random()%2;
                         if (yesOrNo == 1) {
                             angle = -angle;
                         }
                         /*card.transform = CGAffineTransformMakeRotation(angle);
                         card.transform = CGAffineTransformMakeTranslation((float)(point.x - card.frame.origin.x), (float)(point.y - card.frame.origin.y));*/
                         card.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(angle), CGAffineTransformMakeTranslation((float)(point.x - card.frame.origin.x), (float)(point.y - card.frame.origin.y)));
                         NSLog(@"card frame = %@", NSStringFromCGRect(card.frame));
                         [self.arrayOfViablePoints removeObject:[NSValue valueWithCGPoint:point]];
                         /*CGRect rect = card.frame;
                         rect.origin = CGPointMake(point.x, point.y);
                         card.frame = rect;
                         //card.frame.origin = CGPointMake(point.x,point.y);
                         card.bounds = CGRectMake(0, 0, [Card cardWidth], [Card cardWidth]*3.5/2.25);
                         NSLog(@"card frame = %@", NSStringFromCGRect(card.frame));*/
                     }
                     completion:nil];
        card.cardHasBeenPlayed = YES;
    }
    
    //NOTE:  if a card's tag is 5, that means it is on the screen in a played position
    card.tag = 5;
}

//why do I even need a subview called players hand?????

- (NSMutableArray *) viablePointsToMoveACardTo {
    NSMutableArray *arrayOfPoints = [[[NSMutableArray alloc] init] autorelease];
    int width;
    int height;
    int cardHeight = [Card cardWidth]/2.25*3.5;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        width = 320;
        height = 460;
    } else if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        width = 460;
        height = 320;
    }
    
    if (self.brain.numberOfPlayers == 5) {
        //OPTION 1 FOR CARD ARRANGEMENT
        [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(width/2 + [Card cardWidth]/4, (height - [Card cardWidth]*3.5/2.25)/2 + [Card cardWidth]/4)]];
        [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(width/2 - 5*[Card cardWidth]/4, (height - [Card cardWidth]*3.5/2.25)/2 + [Card cardWidth]/4)]];
        [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(width/2 - 5*[Card cardWidth]/4, (height - [Card cardWidth]*3.5/2.25)/2 - [Card cardWidth]/4 - cardHeight)]];
        [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(width/2 + [Card cardWidth]/4, (height - [Card cardWidth]*3.5/2.25)/2 - [Card cardWidth]/4 - cardHeight)]];
        [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(width/2 - [Card cardWidth]/2, (height - [Card cardWidth]*3.5/2.25)/2 - cardHeight/2)]];
        
        /*
        //OPTION 2 FOR CARD ARRANGEMENT
        [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(width/2 - 5*[Card cardWidth]/4, (height - [Card cardWidth]*3.5/2.25)/2 - cardHeight/2)]];
        [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(width/2 + [Card cardWidth]/4, (height - [Card cardWidth]*3.5/2.25)/2 - cardHeight/2)]];
        [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(width/2 - 5*[Card cardWidth]/4, (height - [Card cardWidth]*3.5/2.25)/2 - 3*cardHeight/2 - [Card cardWidth]/2)]];
        [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(width/2 + [Card cardWidth]/4, (height - [Card cardWidth]*3.5/2.25)/2 - 3*cardHeight/2 - [Card cardWidth]/2)]];
        [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(width/2 - [Card cardWidth]/2, (height - [Card cardWidth]*3.5/2.25)/2 + [Card cardWidth]/2 + 3*cardHeight/2)]];
         */
    }
    //NSLog(@"arrayOfPoints = %@", arrayOfPoints);
    
    return arrayOfPoints;
}




#pragma mark - UIAlertViewStuff

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonindex = %@", buttonIndex);
    if (buttonIndex == 0) {
        if (self.brain.numberOfCardsPerPersonInTheRound > 0) {
        [self.brain moveOnToNextRound];
        } else {
            [self.brain endGame];
        }
    } else if (buttonIndex == 1) {
        MainMenu_ViewController *controller = [[MainMenu_ViewController alloc] initWithNibName:@"MainMenu_ViewController" bundle:nil];
        controller.delegate = self;
        
        controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentModalViewController:controller animated:YES];
        
        [controller release];
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"trump"] == YES) {
        //[self.trumpIsLabel setText:[NSString stringWithFormat:@"Trump is %d", [[change objectForKey:NSKeyValueChangeNewKey] intValue]]];
    }
    if ([keyPath isEqualToString:@"playersHaveBeenCreated"] == YES) {
        if ([self.brain.playersArray count] == self.brain.numberOfPlayers) {
            for (Player *p in self.brain.playersArray) {
                [p addObserver:self forKeyPath:@"bid" options:NSKeyValueObservingOptionNew context:nil];
                [p addObserver:self forKeyPath:@"numberOfTricksTaken" options:NSKeyValueObservingOptionNew context:nil];
                [p addObserver:self forKeyPath:@"haveIPlayedYetForTheNewTrick" options:NSKeyValueObservingOptionNew context:nil];
            }
        }
    }
    
    if ([keyPath isEqualToString:@"playerWhoseTurnItIs"] == YES) {
        [self updatePlayersHand];
        //[self.playersCards performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        //[self.currentTrickTabelView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        if ([self.brain numberOfPlayersThatHaveBidSoFar] < self.brain.numberOfPlayers) {
            //BID START
            if (self.playerBidLabel.hidden != YES || self.playerTricksTakenLabel.hidden != YES || self.promptLabel.hidden != YES /*|| [self.currentTrickLabel.text isEqualToString:@""] == NO*/ || self.bidPromptLabel.hidden != NO || self.bidInputTextField.hidden != NO || self.bidButton.hidden != NO || self.bidInputTextField.enabled != YES) {
                //sets all the stuff related to actual gameplay as hidden
                self.playerBidLabel.hidden = YES;
                self.playerTricksTakenLabel.hidden = YES;
                self.promptLabel.hidden = YES;
                //self.currentTrickLabel.text = @"";
                self.bidPromptLabel.hidden = NO;
                self.bidInputTextField.hidden = NO;
                self.bidButton.hidden = NO;
            }
            if ([[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] typeOfPlayer] == PlayerTypeHuman) {
                self.bidInputTextField.enabled = YES;
                self.bidButton.enabled = YES;
                
                NSLog(@"player is human");
                
                self.bidPromptLabel.text = [NSString stringWithFormat:@"What would %@ like to bid?", [[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] name]];
            }  else {
                self.bidInputTextField.enabled = NO;
                self.bidButton.enabled = NO;
            }
        } else if ([self.brain numberOfPlayersThatHaveBidSoFar] == self.brain.numberOfPlayers) {
            //PLAY START
            if (self.bidPromptLabel.hidden != YES || self.bidInputTextField.hidden != YES || self.bidButton.hidden != YES || self.playerBidLabel.hidden != NO || self.playerTricksTakenLabel.hidden != NO || self.promptLabel.hidden != NO || self.bidPromptLabel.hidden != YES || self.bidInputTextField.hidden != YES || self.bidButton.hidden != YES || self.bidInputTextField.enabled != NO) {
                self.bidPromptLabel.hidden = YES;
                self.bidInputTextField.hidden = YES;
                self.bidButton.hidden = YES;
                self.playerBidLabel.hidden = NO;
                self.playerTricksTakenLabel.hidden = NO;
                self.promptLabel.hidden = NO;
                self.bidPromptLabel.hidden = YES;
                self.bidInputTextField.hidden = YES;
                self.bidButton.hidden = YES;
                self.bidInputTextField.enabled = NO;
                
            }
            
            self.playerBidLabel.text = [NSString stringWithFormat:@"%@'s bid is %@", [[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] name], [[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"] objectAtIndex:[self.brain currentPlayerIndex]]];
            self.playerTricksTakenLabel.text = [NSString stringWithFormat:@"%@ has taken %d tricks.", [[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] name], [[[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] tricksTaken] count]];
            
            //changes prompt
            if ([[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] typeOfPlayer] == PlayerTypeHuman) {
                self.promptLabel.text = [NSString stringWithFormat:@"What Card Would %@ Like To Play?", [[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] name]];
            } else {
                self.promptLabel.text = [NSString stringWithFormat:@"%@ is playing...", [[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] name]];
            }
            NSLog(@"subviews = %@", [self.view subviews]);
            if ([self.brain.currentTrick count] == 0) {
            for (Card *c in [self.view subviews]) {
                if (c.tag == 5) {
                    [c removeFromSuperview];
                    c.tag = 0;
                }
            }
            }
        
    }
    }
    
    if ([keyPath isEqualToString:@"haveIPlayedYetForTheNewTrick"] == YES) {
        if ([[change objectForKey:NSKeyValueChangeNewKey] boolValue] == YES) {
            [self moveCard:[self.brain.currentTrick objectAtIndex:([self.brain.currentTrick count] - 1)]];
        }
    }
    if ([keyPath isEqualToString:@"numberOfCardsPerPersonInTheRound"] == YES) {
        NSLog(@"oldnumberofplayers = %d, new number of players = %d", [[change objectForKey:NSKeyValueChangeOldKey] intValue], self.brain.numberOfCardsPerPersonInTheRound);
        if ([[change objectForKey:NSKeyValueChangeOldKey] intValue] == (self.brain.numberOfCardsPerPersonInTheRound + 1)) {
        //if the deck is full and there are the correct number of players (which occurs after each round when the player's tricks r added to the deck)
        NSString *endOfRoundMessage = [[[NSString alloc] init] autorelease];
            
        for (Player *p in self.brain.playersArray) {
            endOfRoundMessage = [endOfRoundMessage stringByAppendingFormat:@"%@'s score is %d \n", p.name, p.score];
        }
            
            for (Card *c in self.brain.gameDeck) {
                c.transform = CGAffineTransformIdentity;
                c.tag = 0;
            }
            self.arrayOfViablePoints = [self viablePointsToMoveACardTo];
            self.playerWhoWonTrickLabel.text = @"";
            if (self.brain.numberOfCardsPerPersonInTheRound > 0) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Round Over!"
                                                              message:endOfRoundMessage
                                                             delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
        [message performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        [message release];
            } else {
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Game Over!"
                                                                  message:endOfRoundMessage
                                                                 delegate:self
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:@"Main Menu"];
                [message performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
                [message release];
            }
        }
    }
    if ([keyPath isEqualToString:@"bid"] == YES) {
        self.bidInputTextField.text = @"";
        self.currentTrickLabel.text = @"Sum of Bids = 0";
        
        self.bidPromptLabel.text = [NSString stringWithFormat:@"%@ bid %d", [[self.brain.playersArray objectAtIndex:[self.brain currentPlayerIndex]] name], [[change objectForKey:NSKeyValueChangeNewKey] intValue]];
        self.currentTrickLabel.text = [NSString stringWithFormat:@"Sum of Bids = %d", [[[self.brain.playersArray valueForKeyPath:@"@unionOfObjects.bid"] valueForKeyPath:@"@sum.self"] intValue]];
    }
    //called when the number of tricks a player has taken changes
    if ([keyPath isEqualToString:@"numberOfTricksTaken"] == YES) {
        self.playerWhoWonTrickLabel.text = [NSString stringWithFormat:@"%@ Won the Trick!", [[self.brain.playersArray objectAtIndex:self.brain.playerWhoWinsCurrentTrickIndex] name]];
    }
}

#pragma mark - UIGesture Stuff

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint touchLocation = [touch locationInView:self.bidButton];
    NSLog(@"touch location x = %f, y = %f", touchLocation.x, touchLocation.y);
    if (touchLocation.x >= 0 && touchLocation.x <= self.bidButton.frame.size.width && touchLocation.y >= 0 && touchLocation.y <= self.bidButton.frame.size.height) {
        return NO;
    } else {
        return YES;
    }
}

- (void)playViewControllerDidFinish:(MainMenu_ViewController *)controller {
    [self dismissModalViewControllerAnimated:YES];
}
                                       
@end
