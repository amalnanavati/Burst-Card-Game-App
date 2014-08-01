//
//  Card_Game_ModelAppDelegate.h
//  Card Game Model
//
//  Created by Chaya Nanavati on 6/15/13.
//  Copyright 2013 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainMenu_ViewController;

@interface Card_Game_ModelAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet MainMenu_ViewController *viewController;

@end
