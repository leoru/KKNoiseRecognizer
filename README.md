KKNoiseRecognizer
=================

It's a simple noise recognizer in decibels for iOS.

# Usage

* First, you need to add AVFoundation.framework into your project.
* Second, you should copy KKNoiseRecognizer.h and KKNoiseRecognizer into your project.
* Include in your contoller #import "KKNoiseRecognizer.h".

After this you can use KKNoiseRecognizer:
```objc

@interface ViewController : UIViewController <KKNoiseRecornizerDelegate>
{
  KKNoiseRecognizer *recognizer;
}
```

and implementation :
```objc
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    recognizer = [KKNoiseRecognizer recognizer];
    recognizer.delegate = self;
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
```

# Additional

You can use your preferences for recognizer:
```objc
recognizer = [KKNoiseRecognizer recognizerWithUpdateInterval:1.0f range:200 offset:200 referenceLevel:10];

```
