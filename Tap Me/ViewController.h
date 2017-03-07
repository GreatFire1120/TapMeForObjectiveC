//
//  ViewController.h
//  Tap Me
//
//  Created by Admin on 1/23/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController {
    
    NSInteger count;
    NSInteger seconds;
    
    NSTimer *timer; //ADD THIS!!
    
    // Add these AVAudioPlayer objects!
    AVAudioPlayer *buttonBeep;
    AVAudioPlayer *secondBeep;
    AVAudioPlayer *backgroundMusic;

}

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

- (IBAction)buttonTapped:(id)sender;

- (void)setupGame;
- (void)subtractTime;

@end

