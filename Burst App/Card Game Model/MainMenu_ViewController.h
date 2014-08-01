//
//  MainMenu_ViewController.h
//  Card Game Model
//
//  Created by Chaya Nanavati on 1/25/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MainMenu_ViewControllerDelegate;
#import "Card_Game_ModelViewController.h"




@interface MainMenu_ViewController : UIViewController <Card_Game_ModelViewControllerDelegate>
@property (retain, nonatomic) IBOutlet UITextView *helpTextView;
@property (retain, nonatomic) IBOutlet UIButton *done;
@property (nonatomic, assign) id <MainMenu_ViewControllerDelegate> delegate;

- (IBAction)playButton:(id)sender;
- (IBAction)helpButton:(id)sender;
- (IBAction)done:(id)sender;


@end

@protocol MainMenu_ViewControllerDelegate
- (void)playViewControllerDidFinish:(MainMenu_ViewController *)controller;
@end
