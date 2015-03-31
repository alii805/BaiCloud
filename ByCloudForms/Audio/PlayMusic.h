//
//  PlayMusic.h
//  True Vampire
//
//  Created by Fahad on 4/8/13.
//  Copyright (c) 2013 SD Sol. All rights reserved.
//


#import <AVFoundation/AVFoundation.h>
#import "Utilities.h"

@interface PlayMusic : NSObject
{
     AVAudioPlayer *audioPlayer; //Plays the audio
    NSURL *url;
}
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;
@property (nonatomic, retain) NSURL *url;
+ (PlayMusic *)sharedObj ;
- (void)playAudio:(NSURL*)audioFileLocationURL; //play the audio
- (void)pauseAudio; //pause the audio
- (void)stopAudio; //stop the audio
- (void)togglePlayPause; //toggle the state of the audio
-(void)LoadFile:(NSString*)fileName;
-(BOOL)LoadFileFromURL:(NSURL*)audioFileLocationURL;
@end
