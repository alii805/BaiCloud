//
//  AudioVC.m
//  ByCloudForms
//
//  Created by Fahad Arshad on 7/23/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import "AudioRecVC.h"

@interface AudioRecVC ()

@end

@implementation AudioRecVC
@synthesize activityIndicator,audioRecorderd,myTag,formID,fieldID,userID,flagLibrary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [activityIndicator stopAnimating];
    NSError *setCategoryErr = nil;
    NSError *activationErr  = nil;
    //Set the general audio session category
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: &setCategoryErr];
    
    //Make the default sound route for the session be to use the speaker
    UInt32 doChangeDefaultRoute = 1;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideCategoryDefaultToSpeaker, sizeof (doChangeDefaultRoute), &doChangeDefaultRoute);
    
    //Activate the customized audio session
    [[AVAudioSession sharedInstance] setActive: YES error: &activationErr];
    
///    if (flagLibrary == fLibrary)
//    {
//        btnRecording.hidden = YES;
//        btnGallary.hidden = NO;
//
//    }
//    else
//    {
//        btnRecording.hidden = NO;
//        btnGallary.hidden = YES;
//        if ([[Singleton sharedInstance].dictAudio count]>0)
//        {
//            if ([[Singleton sharedInstance].dictAudio objectForKey:myTag])
//            {
//                //                self.imgView.image = [[Singleton sharedInstance].dictImageContainer objectForKey:myTag];
//                
//                
//                NSString *path = [[Singleton sharedInstance].dictAudio objectForKey:myTag];
//                //                NSString *path = @"assets-library://asset/asset.JPG?id=81D2C370-653B-4796-96CF-D1655DDC5196&ext=JPG";
//                
//                
//                soundFileURL = [[NSURL alloc] initWithString:path];
//                btnPlay.enabled = YES;
//                
//                
//                
//                //                NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"assets-library://asset/asset.JPG?id=BCA50E87-2569-47F8-B343-E43ECC17C592&ext=JPG"]];
//                //                self.imgView.image = [UIImage imageWithData:mydata];
//            }
//            else
//            {
//                btnPlay.enabled = YES;
//            }
//            
//        }
//        else
//        {
//            btnPlay.enabled = YES;
//        }
//
//    }
    btnGallary.hidden = YES;
    
    if ([[Singleton sharedInstance].dictAudio count]>0)
    {
        if ([[Singleton sharedInstance].dictAudio objectForKey:myTag])
        {
            //                self.imgView.image = [[Singleton sharedInstance].dictImageContainer objectForKey:myTag];
            
            
            NSString *path = [[Singleton sharedInstance].dictAudio objectForKey:myTag];
            //                NSString *path = @"assets-library://asset/asset.JPG?id=81D2C370-653B-4796-96CF-D1655DDC5196&ext=JPG";
            
            
            soundFileURLd = [[NSURL alloc] initWithString:path];
            btnPlay.enabled = YES;
            
            
            
            //                NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"assets-library://asset/asset.JPG?id=BCA50E87-2569-47F8-B343-E43ECC17C592&ext=JPG"]];
            //                self.imgView.image = [UIImage imageWithData:mydata];
        }
        else
        {
            btnPlay.enabled = YES;
        }
        
    }
    else
    {
        btnPlay.enabled = NO;
    }
//    [self audioRecorderInit];
//    library = [[ALAssetsLibrary alloc] init];
//
//    [library addAssetsGroupAlbumWithName:@"ByCloud"
//                             resultBlock:^(ALAssetsGroup *group) {
//                                 NSLog(@"added album:ByCloud");
//                             }
//                            failureBlock:^(NSError *error) {
//                                NSLog(@"error adding album");
//                            }];
    
    
    
//    UIImage *image = [UIImage imageNamed:@"Default.png"];
    
//    NSString * soundFilePath = [[NSBundle mainBundle]
//                                pathForResource:argv
//                                ofType:@"mp3"];
//    [self.library saveImage:image toAlbum:@"ByCloud" withCompletionBlock:^(NSError *error) {
//        if (error!=nil) {
//            //NSLog(@"Big error: %@", [error description]);
//        }
//    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark AudioRecorderDelegates

-(void)audioRecorderDidFinishRecording: (AVAudioRecorder *)recorder successfully:(BOOL)flag
{
//    NSLog(@"Success");
    
    [[Singleton sharedInstance].dictAudio setObject:[NSString stringWithFormat:@"%@",soundFileURLd] forKey:myTag];
    [[Singleton sharedInstance].dictAudioID setObject:fieldID forKey:[NSString stringWithFormat:@"%@",soundFileURLd]];
    [Utilities simpleOkAlertBox:avSuccess Body:avMsgAudioSavedSuccessfully];
    [activityIndicator stopAnimating];
}

-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    [Utilities simpleOkAlertBox:avTitleError Body:[error localizedDescription]];
    [activityIndicator stopAnimating];
//    NSLog(@"Encode Error occurred");
}
#pragma mark Custom Functions
-(void)audioRecorderInit
{
    
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
//    NSString *tileDirectory = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ByCloud"];
//    docsDir = tileDirectory;
//    docsDir = @"ipod-library://item/";
    int myNumber = arc4random() % 1000;
    NSString *fileName = [NSString stringWithFormat:@"%@%@%@%@%d.caf",userID,formID,fieldID,myTag,myNumber];
    
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:fileName];
    
    soundFileURL2d = [NSURL fileURLWithPath:soundFilePath];
//    [[Singleton sharedInstance].dictAudio setObject:[NSString stringWithFormat:@"%@",soundFileURL] forKey:myTag];
    
    NSDictionary *recordSettings =
                                [[NSDictionary alloc] initWithObjectsAndKeys:
                                 [NSNumber numberWithFloat: 44100.0], AVSampleRateKey,
                                 [NSNumber numberWithInt: kAudioFormatAppleIMA4], AVFormatIDKey,
                                 [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                 [NSNumber numberWithInt: AVAudioQualityMedium],
                                 AVEncoderAudioQualityKey,
                                 nil];
//                                    [NSDictionary
//                                    dictionaryWithObjectsAndKeys:
//                                    [NSNumber numberWithInt:AVAudioQualityMin],
//                                    AVEncoderAudioQualityKey,
//                                    [NSNumber numberWithInt:16],
//                                    AVEncoderBitRateKey,
//                                    [NSNumber numberWithInt: 2],
//                                    AVNumberOfChannelsKey,
//                                    [NSNumber numberWithFloat:44100.0],
//                                    AVSampleRateKey,
//                                    nil];
    
    
    
    
//    [NSNumber numberWithInt:kAudioFormatMPEGLayer3] forKey:AVFormatIDKey
    
//    AudioFormatGetProperty(<#AudioFormatPropertyID inPropertyID#>, <#UInt32 inSpecifierSize#>, <#const void *inSpecifier#>, <#UInt32 *ioPropertyDataSize#>, <#void *outPropertyData#>)

    NSError *error = nil;
    audioRecorderd = nil;
    audioPlayerd = nil;
    
    audioRecorderd = [[AVAudioRecorder alloc]
                      initWithURL:soundFileURL2d
                      settings:recordSettings
                      error:&error];
    [activityIndicator stopAnimating];
    [audioRecorderd prepareToRecord];
    if (error)
    {
        [Utilities simpleOkAlertBox:avTitleError Body:[error localizedDescription]];
//        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        [audioRecorderd prepareToRecord];
    }
    
    
//    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//    NSError *err = nil;
//    [audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:&err];
//    if(err){
//        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
//        return;
//    }
//    err = nil;
//    [audioSession setActive:YES error:&err];
//    if(err){
//        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
//        return;
//    }
//    
//    
//    
//    if([audioRecorderd prepareToRecord]){
//        [audioRecorderd record];
//    }else{
//        int errorCode = CFSwapInt32HostToBig([error code]);
//        NSLog(@"Error: %@ [%4.4s])", [error localizedDescription], (char*)&errorCode);
//    }
}


#pragma mark IBActions

- (IBAction)btnRecording:(id)sender
{
    NSError *setCategoryErr = nil;
    NSError *activationErr  = nil;
    //Set the general audio session category
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: &setCategoryErr];
    
    //Make the default sound route for the session be to use the speaker
    UInt32 doChangeDefaultRoute = 1;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideCategoryDefaultToSpeaker, sizeof (doChangeDefaultRoute), &doChangeDefaultRoute);
    
    //Activate the customized audio session
    [[AVAudioSession sharedInstance] setActive: YES error: &activationErr];
    if ([sender tag] == 1)//Start Recording
    {
        [self audioRecorderInit];
        [activityIndicator startAnimating];
        soundFileURLd = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@",soundFileURL2d]];
        btnPlay.enabled = NO;
        
        if ([audioRecorderd prepareToRecord] == YES){
            [audioRecorderd record];
            [btnRecording setTitle:@"Stop Recording" forState:UIControlStateNormal];
            btnRecording.tag = 2;
            [activityIndicator startAnimating];
        }
        
        if (!audioRecorderd.recording)
        {
            [activityIndicator stopAnimating];
        }
    }
    else if ([sender tag] == 2)//Stop Recording
    {
        btnPlay.enabled = YES;
        [btnRecording setTitle:@"Start Recording" forState:UIControlStateNormal];
        [activityIndicator stopAnimating];
        btnRecording.tag = 1;
        
        if (audioRecorderd.recording)
        {
            [audioRecorderd stop];
            btnPlay.enabled = YES;
            audioRecorderd.delegate = self;
//            NSLog(@"Yessss");
        }
        else
        {
//             NSLog(@"Nooooo");
        }
        
    }

}

- (IBAction)btnPlay:(id)sender
{
    if ([sender tag] == 1)//Play
    {
        [btnPlay setTitle:@"Stop" forState:UIControlStateNormal];
        btnPlay.tag = 2;
//        [soundFileURL initWithString:@"ipod-library:/item/sound.caf"];
//        NSURL *urll =[[NSURL alloc] initWithString:@"ipod-library:/item/sound.caf"];
        [self playAudio:soundFileURLd];
        [activityIndicator startAnimating];
//        NSError *error;
//        
//        AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
//        NSLog(@"%@",audioPlayer.url);
//        
//        if (error)
//        {
//            NSLog(@"Error in audioPlayer: %@", [error localizedDescription]);
//            
//            [Utilities simpleOkAlertBox:avTitleError Body:[error localizedDescription]];
//            
//        }
//        else
//        {
//
//            
//        }

    }
    else if ([sender tag] == 2)//Stop
    {
        [btnPlay setTitle:@"Play" forState:UIControlStateNormal];
        btnPlay.tag = 1;
        [activityIndicator stopAnimating];
        
        [self stopAudio];
    }
}

- (IBAction)btnGallary:(id)sender
{
//    MPMediaPickerController *pickerController =	[[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeMusic];
//	pickerController.prompt = @"Choose Audio";
//	pickerController.allowsPickingMultipleItems = NO;
//	pickerController.delegate = self;
//    [self presentViewController:pickerController animated:YES completion:nil];
}
#pragma mark MPMediaPickerControllerDelegate
//- (void)mediaPicker: (MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
//{
//	
//    [self stopAudio];
//    [activityIndicator stopAnimating];
//    btnPlay.enabled = YES;
//    [btnPlay setTitle:@"Play" forState:UIControlStateNormal];
//    btnPlay.tag = 1;
//    
//	if ([mediaItemCollection count] < 1)
//    {
//		return;
//	}
//    
////	[song release];
//	songd = [[mediaItemCollection items] objectAtIndex:0];
//    soundFileURLd = [songd valueForProperty:MPMediaItemPropertyAssetURL];
//    
//    NSLog(@"%@",soundFileURLd);
//    [[Singleton sharedInstance].dictAudio setObject:[NSString stringWithFormat:@"%@",soundFileURLd] forKey:myTag];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
////    soundSelectedFileURL = [[[mediaItemCollection items] objectAtIndex:0] URL];
////
////	songLabel.hidden = NO;
////	artistLabel.hidden = NO;
////	coverArtView.hidden = NO;
////	songLabel.text = [song valueForProperty:MPMediaItemPropertyTitle];
////	artistLabel.text = [song valueForProperty:MPMediaItemPropertyArtist];
////	coverArtView.image = [[song valueForProperty:MPMediaItemPropertyArtwork]
////						  imageWithSize: coverArtView.bounds.size];
//}
//
//- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
//	[self dismissViewControllerAnimated:YES completion:nil];
//}
/////
#pragma mark Player
- (void)playAudio:(NSURL*)audioFileLocationURL
{
    //Play the audio and set the button to represent the audio is playing
    //    UIEvent *event = [[UIEvent alloc] init];
    if (audioPlayerd.isPlaying)
    {
        [audioPlayerd stop];
        if ([self LoadFileFromURL:audioFileLocationURL])
        {
            [audioPlayerd play];
        }
        else
        {
            
        }
        
    }
    else
    {
        if ([self LoadFileFromURL:audioFileLocationURL])
        {
            [audioPlayerd play];
        }
        else
        {
            
        }
    }
    
    
    
}

- (void)pauseAudio
{
    //Pause the audio and set the button to represent the audio is paused
    [audioPlayerd pause];
}
- (void)stopAudio
{
    if (audioPlayerd.isPlaying)
    {
        [audioPlayerd stop];
    }
    
    //    [self LoadFile:@"TrueVampire_SoundTrack"];
}
- (void)togglePlayPause {
    //Toggle if the music is playing or paused
    if (!audioPlayerd.playing) {
        [self playAudio:soundFileURLd];
        
    } else if (audioPlayerd.playing) {
        [self pauseAudio];
        
    }
}

-(BOOL)LoadFileFromURL:(NSURL*)audioFileLocationURL
{
    
    //    NSURL *audioFileLocationURL = [[NSBundle mainBundle] URLForResource:@"TrueVampire_SoundTrack" withExtension:@"mp3"];
    //    NSURL *audioFileLocationURL = URL;
    NSError *error;
    audioPlayerd = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileLocationURL error:&error];
    [audioPlayerd setNumberOfLoops:0];
    audioPlayerd.delegate = self;
    if (error) {
//        NSLog(@"%@", [error localizedDescription]);
        [Utilities simpleOkAlertBox:avTitleError Body:[error localizedDescription]];
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
        [audioPlayerd prepareToPlay];
        return YES;
    }
    
}
//-(void)LoadFile:(NSString*)fileName
//{
//    
//    NSURL *audioFileLocationURL = [[NSBundle mainBundle] URLForResource:@"TrueVampire_SoundTrack" withExtension:@"mp3"];
//    NSError *error;
//    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileLocationURL error:&error];
//    [audioPlayer setNumberOfLoops:-1];
//    
//    if (error) {
//        NSLog(@"%@", [error localizedDescription]);
//        //        [[self alertLabel] setText:@"Unable to load file"];
//        //        [[self alertLabel] setHidden:NO];
//    } else {
//        //        [[self alertLabel] setText:[NSString stringWithFormat:@"%@ has loaded", @"HeadspinLong.caf"]];
//        //        [[self alertLabel] setHidden:NO];
//        
//        //Make sure the system follows our playback status
//        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
//        [[AVAudioSession sharedInstance] setActive: YES error: nil];
//        
//        //Load the audio into memory
//        [audioPlayer prepareToPlay];
//    }
//    
//}
#pragma mark Player Delegates
-(void)audioPlayerDidFinishPlaying: (AVAudioPlayer *)player successfully:(BOOL)flag
{
//    NSLog(@"Finish");
    [btnPlay setTitle:@"Play" forState:UIControlStateNormal];
    btnPlay.tag = 1;
    [activityIndicator stopAnimating];
}

-(void)audioPlayerDecodeErrorDidOccur: (AVAudioPlayer *)player error:(NSError *)error
{
    
//    NSLog(@"Decode Error occurred");
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
            [self playAudio:soundFileURLd];
        } else if (event.subtype == UIEventSubtypeRemoteControlPause) {
            [self pauseAudio];
        } else if (event.subtype == UIEventSubtypeRemoteControlTogglePlayPause) {
            [self togglePlayPause];
        }
    }
}
@end
