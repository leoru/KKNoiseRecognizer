//
//  NoiseRecognizer.m
//  KKNoiseRecognizer
//
//  Created by Kirill Kunst on 05.02.13.
//  Copyright (c) 2013 Kirill Kunst. All rights reserved.
//

#import "KKNoiseRecognizer.h"

@implementation KKNoiseRecognizer

-(id)init {
    self = [super init];
    if (self) {
        isEnabled = NO;
        [self configureRecorder];
        [self setOffset:NOISE_RECOGNIZER_DEFAULT_OFFSET];
        [self setRange:NOISE_RECOGNIZER_DEFAULT_RANGE];
        [self setReferenceLevel:NOISE_RECOGNIZER_DEFAULT_REFERENCE_LEVEL];
        [self setUpdateInterval:NOISE_RECOGNIZER_DEFAULT_UPDATE_INTERVAL];
    }
    return self;
}
-(id)initWithUpdateInterval:(double)updateInterval range:(int)range offset:(int)offset referenceLevel:(int)referenceLevel {
    self = [self init];
    if (self) {
        [self setOffset:offset];
        [self setRange:range];
        [self setReferenceLevel:referenceLevel];
        [self setUpdateInterval:updateInterval];
    }
    return self;
}

+(KKNoiseRecognizer *)recognizerWithUpdateInterval:(double)updateInterval range:(int)range offset:(int)offset referenceLevel:(int)referenceLevel {
    KKNoiseRecognizer *recognizer = [[KKNoiseRecognizer alloc] initWithUpdateInterval:updateInterval range:range offset:offset referenceLevel:referenceLevel];
    return recognizer;
}
+(KKNoiseRecognizer *)recognizer {
    KKNoiseRecognizer *recognizer = [[KKNoiseRecognizer alloc] init];
    return recognizer;
}


-(void)configureRecorder {
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
                              [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                              [NSNumber numberWithInt: 2],                         AVNumberOfChannelsKey,
                              [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
                              nil];
    
    NSError *error;
    
    if (recorder == nil)
        recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    
    if (recorder) {
        [recorder prepareToRecord];
        recorder.meteringEnabled = YES;
    }
}
-(void)start {
    [recorder record];
    levelTimer = [NSTimer scheduledTimerWithTimeInterval: self.updateInterval
                                                  target: self
                                                selector: @selector(levelTimerCallback:)
                                                userInfo: nil
                                                 repeats: YES];
    isEnabled = YES;
    [self.delegate recognizer:self StartUpdateNoiseLevel:0];
}
-(void)stop {
    [recorder stop];
    [levelTimer invalidate];
    isEnabled = NO;
    [self.delegate recognizer:self StopUpdateNoiseLevel:0];
}

-(BOOL)isEnabled {
    return isEnabled;
}
- (void)levelTimerCallback:(NSTimer *)timer
{
    [recorder updateMeters];
    float averagePower = [recorder averagePowerForChannel:0];
    int SPL = [self SPL:averagePower];
    NSLog(@"Decibels level: %d",SPL);
    [self.delegate recognizer:self updateNoiseLevel:SPL];
}
-(int)SPL:(float)decibelsPower {
    int SPL = 20 * log10(self.referenceLevel * powf(10, (decibelsPower/20)) * self.range + self.offset);
    return SPL;
}
@end
