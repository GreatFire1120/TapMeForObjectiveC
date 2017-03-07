//
//  ViewController.m
//  Tap Me
//
//  Created by Admin on 1/23/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView* timeImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view layoutIfNeeded];
    
//    self.view.backgroundColor = [UIColor purpleColor];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tile.png"]];

    UIImage* timeImage = [UIImage imageNamed:@"field_time"];
    self.scoreLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"field_score.png"]];
    self.timerLabel.backgroundColor = [UIColor colorWithPatternImage:timeImage];
 
    buttonBeep = [self setupAudioPlayerWithFile:@"ButtonTap" type:@"wav"];
    secondBeep = [self setupAudioPlayerWithFile:@"SecondBeep" type:@"wav"];
    backgroundMusic = [self setupAudioPlayerWithFile:@"HallOfTheMountainKing" type:@"mp3"];
    
    [self setupGame];

    NSLog(@"%@ : %@ : %@", NSStringFromCGRect([UIScreen mainScreen].bounds), NSStringFromCGRect(self.timerLabel.frame), NSStringFromCGRect(self.timeImageView.frame));
    
//    self.timeLabel.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.timeLabel.layer.borderWidth = 0.5f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupGame{
    seconds = 30;
    count = 0;
    
    self.timerLabel.text = [NSString stringWithFormat:@"Time: %li",(long)seconds];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score\n%li",(long)count];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(subtractTime) userInfo:nil repeats:YES];
    
    [backgroundMusic setVolume:0.3];
    [backgroundMusic play];
}

- (AVAudioPlayer *)setupAudioPlayerWithFile:(NSString *)file type:(NSString *)type
{
    // 1
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:type];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    // 2
    NSError *error;
    
    // 3
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    // 4
    if (!audioPlayer) {
        NSLog(@"%@",[error description]);
    }
    
    // 5
    return audioPlayer;
}

- (void)subtractTime{
    seconds--;
    self.timerLabel.text = [NSString stringWithFormat:@"Time: %li",(long)seconds];
    
    // add this line
    [secondBeep play];
    
    if(seconds == 0){
        [timer invalidate];

        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Time is up!"
                                      message:[NSString stringWithFormat:@"You scored %li points",(long)count]
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"Play Again"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //[alert dismissViewControllerAnimated:YES completion:nil];
                                 [self setupGame];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)buttonTapped:(id)sender {
    count++;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score\n%li",(long)count];
    
    // add this line
    [buttonBeep play];
}

@end
