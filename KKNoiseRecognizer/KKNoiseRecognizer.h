//
//  NoiseRecognizer.h
//  KKNoiseRecognizer
//
//  Created by Kirill Kunst on 05.02.13.
//  Copyright (c) 2013 Kirill Kunst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#define NOISE_RECOGNIZER_DEFAULT_REFERENCE_LEVEL 5
#define NOISE_RECOGNIZER_DEFAULT_RANGE 160
#define NOISE_RECOGNIZER_DEFAULT_OFFSET 50
#define NOISE_RECOGNIZER_DEFAULT_UPDATE_INTERVAL 0.03

@protocol KKNoiseRecornizerDelegate;

@interface KKNoiseRecognizer : NSObject
{
    AVAudioRecorder *recorder;
    NSTimer *levelTimer;
    BOOL isEnabled;
}


@property (nonatomic) int range;
@property (nonatomic) int offset;
@property (nonatomic) int referenceLevel;
@property (nonatomic) double updateInterval;
@property (nonatomic,retain) id<KKNoiseRecornizerDelegate> delegate;


-(id)initWithUpdateInterval:(double)updateInterval range:(int)range offset:(int)offset referenceLevel:(int)referenceLevel;

+(KKNoiseRecognizer *)recognizerWithUpdateInterval:(double)updateInterval range:(int)range offset:(int)offset referenceLevel:(int)referenceLevel;
+(KKNoiseRecognizer *)recognizer;

-(void)start;
-(void)stop;
-(BOOL)isEnabled;

@end

@protocol KKNoiseRecornizerDelegate <NSObject>

@required

-(void)recognizer:(KKNoiseRecognizer *)recognizer updateNoiseLevel:(int)level;
-(void)recognizer:(KKNoiseRecognizer *)recognizer StartUpdateNoiseLevel:(int)level;
-(void)recognizer:(KKNoiseRecognizer *)recognizer StopUpdateNoiseLevel:(int)level;

@end
