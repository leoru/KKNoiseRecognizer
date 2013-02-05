//
//  ViewController.m
//  SimpleNoiseRecognizer
//
//  Created by Кирилл Кунст on 05.02.13.
//  Copyright (c) 2013 Kirill Kunst. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
{
    KKNoiseRecognizer *recognizer;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    recognizer = [KKNoiseRecognizer recognizer];
	recognizer.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)stop:(id)sender {
    [recognizer stop];
}

- (IBAction)start:(id)sender {
    [recognizer start];
}

-(void)recognizer:(KKNoiseRecognizer *)recognizer StartUpdateNoiseLevel:(int)level {
    self.levelMeter.text = [NSString stringWithFormat:@"%d dB",0];
}

-(void)recognizer:(KKNoiseRecognizer *)recognizer StopUpdateNoiseLevel:(int)level {
    self.levelMeter.text = [NSString stringWithFormat:@"%d dB",0];
}

-(void)recognizer:(KKNoiseRecognizer *)recognizer updateNoiseLevel:(int)level {
    self.levelMeter.text = [NSString stringWithFormat:@"%d dB",level];
}
@end
