//
//  MainMenu_ViewController.m
//  Card Game Model
//
//  Created by Chaya Nanavati on 1/25/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "MainMenu_ViewController.h"

@interface MainMenu_ViewController ()

@end

@implementation MainMenu_ViewController
@synthesize delegate = _delegate;

- (void)playViewControllerDidFinish:(Card_Game_ModelViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.helpTextView.text = @"Burst is a multi (typically 5) player, trick-based card game.  Hearts is always trump, and Ace is high.  It consists of multiple rounds, with a player's score adding up across rounds.  \n\nAt the beginning of each round, players go around (starting from the person to the left of the dealer) and bid the number of tricks they think they will make that round.  If they make more OR less, they are burst, and get zero points for that round.  If they make that number of tricks, they get one more than their bid placed to the left of the number (3 -> 43, 5 -> 65, x -> 11x + 10.)  In order to prevent an even bid (sum of bids = number of tricks available -- if this is the case, there is the possibility of no player bursting,) the last player cannot bid such that the sum of bids = the number of tricks available.  (For example, if each player has 10 cards, and the bids are 2, 3, 1, 2, the last player CANNOT say two, otherwise the sum of bids = 10 and it is possible for no one to burst.)  \n\nAfter bidding, gameplay begins.  The person to the left of the dealer starts, with any card.  Everyone after the first player must follow the leadin suit if they can.  If not, they are free to throw any card.  At the end of the trick, the player with the highest card or highest trump (hearts) wins the trick. Once every trick is taken, the round is over and players calculate the score.  \n\nFor each consecutive round, the number of cards in each player's hand decreases by one.  For example, with 5 people, we start with a round of 10 (50 cards total, 2 left out,) move on to a round of 9 (45 cards total, 7 left out,) etc. all the way down to one.  As a result of decreasing the number of cards in game, more cards are excluded from the game and the game becomes more uncertain.  On lower rounds, it is not surprising to see a 4 or 5 make a trick!  Gameplay ends after the round of 1, and each player adds his/her score.";
    self.helpTextView.frame = CGRectMake(self.helpTextView.frame.origin.x, self.helpTextView.frame.origin.y - [UIScreen mainScreen].bounds.size.height, self.helpTextView.frame.size.width, self.helpTextView.frame.size.height);
    self.done.frame = CGRectMake(self.done.frame.origin.x, self.done.frame.origin.y - [UIScreen mainScreen].bounds.size.height, self.done.frame.size.width, self.done.frame.size.height);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_helpTextView release];
    [_done release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setHelpTextView:nil];
    [self setDone:nil];
    [super viewDidUnload];
}
- (IBAction)playButton:(id)sender {
    Card_Game_ModelViewController *controller = [[Card_Game_ModelViewController alloc] initWithNibName:@"Card_Game_ModelViewController" bundle:nil];
    controller.delegate = self;
    
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
    
    [controller release];
}

- (IBAction)helpButton:(id)sender {
    if (self.helpTextView.frame.origin.y < 0 && self.done.frame.origin.y < 0) {
        [UIView animateWithDuration:1.0
                         animations:^{
                             self.helpTextView.frame = CGRectMake(self.helpTextView.frame.origin.x, self.helpTextView.frame.origin.y + [UIScreen mainScreen].bounds.size.height, self.helpTextView.frame.size.width, self.helpTextView.frame.size.height);
                             self.done.frame = CGRectMake(self.done.frame.origin.x, self.done.frame.origin.y + [UIScreen mainScreen].bounds.size.height, self.done.frame.size.width, self.done.frame.size.height);
                         }
                         completion:nil];
    }
}

- (IBAction)done:(id)sender {
    if (self.helpTextView.frame.origin.y >= 0 && self.done.frame.origin.y >= 0) {
        [UIView animateWithDuration:1.0
                         animations:^{
                             self.helpTextView.frame = CGRectMake(self.helpTextView.frame.origin.x, self.helpTextView.frame.origin.y - [UIScreen mainScreen].bounds.size.height, self.helpTextView.frame.size.width, self.helpTextView.frame.size.height);
                             self.done.frame = CGRectMake(self.done.frame.origin.x, self.done.frame.origin.y - [UIScreen mainScreen].bounds.size.height, self.done.frame.size.width, self.done.frame.size.height);
                         }
                         completion:nil];
    }
}
@end
