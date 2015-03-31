//
//  PlayMusic.m
//  True Vampire
//
//  Created by Fahad on 4/8/13.
//  Copyright (c) 2013 SD Sol. All rights reserved.
//

#import "PlayMusic.h"

static PlayMusic *sharedInstance = nil;
@implementation PlayMusic
@synthesize audioPlayer,url;


#pragma mark - Singleton Methods

+ (PlayMusic *)sharedObj
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PlayMusic alloc] init];
        
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    
    if (self != nil)
    {
//       [self LoadFile:@"HeadspinLong"];
    }
    return self;
}
- (void)playAudio:(NSURL*)audioFileLocationURL
{
//Play the audio and set the button to represent the audio is playing    
//    UIEvent *event = [[UIEvent alloc] init];
    if (audioPlayer.isPlaying)
    {
        [audioPlayer stop];
        if ([self LoadFileFromURL:audioFileLocationURL])
        {
            [audioPlayer play];
        }
        else
        {
            
        }
        
    }
    else
    {
        if ([self LoadFileFromURL:audioFileLocationURL])
        {
            [audioPlayer play];
        }
        else
        {
            
        }
    }
    

    
}

- (void)pauseAudio
{
    //Pause the audio and set the button to represent the audio is paused
    [audioPlayer pause];
}
- (void)stopAudio
{
    [audioPlayer stop];
//    [self LoadFile:@"TrueVampire_SoundTrack"];
}
- (void)togglePlayPause {
    //Toggle if the music is playing or paused
    if (!self.audioPlayer.playing) {
        [self playAudio:url];
        
    } else if (self.audioPlayer.playing) {
        [self pauseAudio];
        
    }
}
-(BOOL)LoadFileFromURL:(NSURL*)audioFileLocationURL
{
    
//    NSURL *audioFileLocationURL = [[NSBundle mainBundle] URLForResource:@"TrueVampire_SoundTrack" withExtension:@"mp3"];
//    NSURL *audioFileLocationURL = URL;
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileLocationURL error:&error];
    [audioPlayer setNumberOfLoops:0];
    
    if (error) {
//        NSLog(@"%@", [error localizedDescription]);
        [Utilities simpleOkAlertBox:avTitleError Body:avMsgFileNotFound];
        //        [[self alertLabel] setText:@"Unable to load file"];
        //        [[self alertLabel] setHidden:NO];
        return NO;
    } else {
        //        [[self alertLabel] setText:[NSString stringWithFormat:@"%@ has loaded", @"HeadspinLong.caf"]];
        //        [[self alertLabel] setHidden:NO];
        
        //Make sure the system follows our playback status
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive: YES error: nil];
        
        //Load the audio into memory
        [audioPlayer prepareToPlay];
        return YES;
    }
    
}
-(void)LoadFile:(NSString*)fileName
{

    NSURL *audioFileLocationURL = [[NSBundle mainBundle] URLForResource:@"TrueVampire_SoundTrack" withExtension:@"mp3"];    
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileLocationURL error:&error];
    [audioPlayer setNumberOfLoops:-1];
    
    if (error) {
//        NSLog(@"%@", [error localizedDescription]);
//        [[self alertLabel] setText:@"Unable to load file"];
//        [[self alertLabel] setHidden:NO];
    } else {
//        [[self alertLabel] setText:[NSString stringWithFormat:@"%@ has loaded", @"HeadspinLong.caf"]];
//        [[self alertLabel] setHidden:NO];
        
        //Make sure the system follows our playback status
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive: YES error: nil];
        
        //Load the audio into memory
        [audioPlayer prepareToPlay];
    }

}
#pragma mark Remote Events
//Make sure we can recieve remote control events
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    //if it is a remote control event handle it correctly
    if (event.type == UIEventTypeRemoteControl) {
        if (event.subtype == UIEventSubtypeRemoteControlPlay) {
            [self playAudio:url];
        } else if (event.subtype == UIEventSubtypeRemoteControlPause) {
            [self pauseAudio];
        } else if (event.subtype == UIEventSubtypeRemoteControlTogglePlayPause) {
            [self togglePlayPause];
        }
    }
}
@end
