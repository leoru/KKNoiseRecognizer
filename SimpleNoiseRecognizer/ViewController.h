//
//  ViewController.h
//  SimpleNoiseRecognizer
//
//  Created by Кирилл Кунст on 05.02.13.
//  Copyright (c) 2013 Kirill Kunst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKNoiseRecognizer.h"
@interface ViewController : UIViewController <KKNoiseRecornizerDelegate>


- (IBAction)stop:(id)sender;
- (IBAction)start:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *levelMeter;

@end
