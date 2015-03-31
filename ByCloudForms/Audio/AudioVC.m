//
//  AudioVC.m
//  ByCloudForms
//
//  Created by Fahad Arshad on 7/23/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import "AudioVC.h"

@interface AudioVC ()

@end

@implementation AudioVC
@synthesize activityIndicator,audioRecorder,myTag,library,formID,fieldID,userID,flagLibrary;

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
    [self audioRecorderInit];
    [activityIndicator stopAnimating];
    if (flagLibrary == fLibrary)
    {
        btnRecording.hidden = YES;
        btnGallary.hidden = NO;
        pickerController =	[[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeMusic];
        pickerController.prompt = @"Choose Audio";
        pickerController.allowsPickingMultipleItems = NO;
        pickerController.delegate = self;
        [self presentViewController:pickerController animated:YES completion:nil];
    }
    else
    {
        btnRecording.hidden = NO;
        btnGallary.hidden = YES;
        if ([[Singleton sharedInstance].dictAudio count]>0)
        {
            if ([[Singleton sharedInstance].dictAudio objectForKey:myTag])
            {
                //                self.imgView.image = [[Singleton sharedInstance].dictImageContainer objectForKey:myTag];
                
                
                NSString *path = [[Singleton sharedInstance].dictAudio objectForKey:myTag];
                //                NSString *path = @"assets-library://asset/asset.JPG?id=81D2C370-653B-4796-96CF-D1655DDC5196&ext=JPG";
                
                
                soundFileURL = [[NSURL alloc] initWithString:path];
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
            btnPlay.enabled = YES;
        }

    }
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
-(void)viewDidDisappear:(BOOL)animated
{
    pickerController = nil;
    audioRecorder = nil;
    audioPlayer = nil;
    song = nil;
    library = nil;
    soundSelectedFileURL = nil;
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
    
    [[Singleton sharedInstance].dictAudio setObject:[NSString stringWithFormat:@"%@",soundFileURL] forKey:myTag];
    [Utilities simpleOkAlertBox:avSuccess Body:avMsgAudioSavedSuccessfully];
}

-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    [Utilities simpleOkAlertBox:avTitleError Body:[error localizedDescription]];
//    NSLog(@"Encode Error occurred");
}
#pragma mark Custom Functions
-(void)audioRecorderInit
{
    btnPlay.enabled = NO;
    
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
//    NSString *tileDirectory = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ByCloud"];
//    docsDir = tileDirectory;
//    docsDir = @"ipod-library://item/";
//    int myNumber = arc4random() % 1000;
//    NSString *fileName = [NSString stringWithFormat:@"%@%@%@%@%d.caf",userID,formID,fieldID,myTag,myNumber];
    NSString *fileName = [NSString stringWithFormat:@"%@%@%@%@.caf",userID,formID,fieldID,myTag];
    
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:fileName];
    
    soundFileURL2 = [NSURL fileURLWithPath:soundFilePath];
//    [[Singleton sharedInstance].dictAudio setObject:[NSString stringWithFormat:@"%@",soundFileURL] forKey:myTag];
    
    NSDictionary *recordSettings = [NSDictionary
                                    dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    
    NSError *error = nil;
    
    audioRecorder = [[AVAudioRecorder alloc]
                      initWithURL:soundFileURL2
                      settings:recordSettings
                      error:&error];
    [activityIndicator stopAnimating];
   
    if (error)
    {
        [Utilities simpleOkAlertBox:avTitleError Body:[error localizedDescription]];
//        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        [audioRecorder prepareToRecord];
    }
    
}


#pragma mark IBActions

- (IBAction)btnRecording:(id)sender
{
    if ([sender tag] == 1)//Start Recording
    {
//        [self audioRecorderInit];
        soundFileURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@",soundFileURL2]];
        btnPlay.enabled = NO;
        
        [btnRecording setTitle:@"Stop Recording" forState:UIControlStateNormal];
        btnRecording.tag = 2;
        [activityIndicator startAnimating];
        
        if (!audioRecorder.recording)
        {
            [audioRecorder record];
        }
        else
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
        
        if (audioRecorder.recording)
        {
            [audioRecorder stop];
            btnPlay.enabled = YES;
            audioRecorder.delegate = self;
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
        [self playAudio:soundFileURL];
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
    pickerController =	[[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeMusic];
	pickerController.prompt = @"Choose Audio";
	pickerController.allowsPickingMultipleItems = NO;
	pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}
#pragma mark MPMediaPickerControllerDelegate
- (void)mediaPicker: (MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
	
    [self stopAudio];
    [activityIndicator stopAnimating];
    btnPlay.enabled = YES;
//    [btnPlay setTitle:@"Play" forState:UIControlStateNormal];
//    btnPlay.tag = 1;
    
	if ([mediaItemCollection count] < 1)
    {
		return;
	}
    NSString *tempPath = NSTemporaryDirectory();
//	[song release];
	song = [[mediaItemCollection items] objectAtIndex:0];
    soundFileURL = [song valueForProperty:MPMediaItemPropertyAssetURL];
    
    AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL:soundFileURL options:nil];
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset: songAsset presetName: AVAssetExportPresetPassthrough];
    exporter.outputFileType = @"com.apple.coreaudio-format";
    NSLog(@"%@", exporter.outputFileType);
    NSString *fname = [[NSString stringWithFormat:@"song"] stringByAppendingString:@".caf"];
    NSString *exportFile = [tempPath stringByAppendingPathComponent: fname];
    exporter.outputURL = [NSURL fileURLWithPath:exportFile];
//    [self performSelectorOnMainThread:@selector([exporter exportAs]) withObject:mediaPicker waitUntilDone:YES];
    

    [exporter  exportAsynchronouslyWithCompletionHandler:^{
        //Code for completion Handler
        [[Singleton sharedInstance].dictAudio setObject:[NSString stringWithFormat:@"%@",exportFile] forKey:myTag];
        [[Singleton sharedInstance].dictAudioID setObject:fieldID forKey:[NSString stringWithFormat:@"%@",exportFile]];
//        [self dismissViewControllerAnimated:YES completion:nil];
        [self performSelectorOnMainThread:@selector(mediaPickerDidCancel:) withObject:mediaPicker waitUntilDone:YES];
        //[mediaPicker dismissViewControllerAnimated:YES completion:nil];
        return ;

    }];
//    [self mediaPickerDidCancel:mediaPicker];
//    NSLog(@"%@",soundFileURL);
    //    soundSelectedFileURL = [[[mediaItemCollection items] objectAtIndex:0] URL];
    
//	songLabel.hidden = NO;
//	artistLabel.hidden = NO;
//	coverArtView.hidden = NO;
//	songLabel.text = [song valueForProperty:MPMediaItemPropertyTitle];
//	artistLabel.text = [song valueForProperty:MPMediaItemPropertyArtist];
//	coverArtView.image = [[song valueForProperty:MPMediaItemPropertyArtwork]
//						  imageWithSize: coverArtView.bounds.size];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    NSError *setCategoryErr = nil;
    NSError *activationErr  = nil;
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: &setCategoryErr];
    
    //Make the default sound route for the session be to use the speaker
    UInt32 doChangeDefaultRoute = 1;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideCategoryDefaultToSpeaker, sizeof (doChangeDefaultRoute), &doChangeDefaultRoute);
    
    //Activate the customized audio session
    [[AVAudioSession sharedInstance] setActive: YES error: &activationErr];
	[self dismissViewControllerAnimated:YES completion:nil];
}
/////
#pragma mark Player
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
    if (audioPlayer.isPlaying)
    {
        [audioPlayer stop];
    }
    
    //    [self LoadFile:@"TrueVampire_SoundTrack"];
}
- (void)togglePlayPause {
    //Toggle if the music is playing or paused
    if (!audioPlayer.playing) {
        [self playAudio:soundFileURL];
        
    } else if (audioPlayer.playing) {
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
    audioPlayer.delegate = self;
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
        [audioPlayer prepareToPlay];
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
            [self playAudio:soundFileURL];
        } else if (event.subtype == UIEventSubtypeRemoteControlPause) {
            [self pauseAudio];
        } else if (event.subtype == UIEventSubtypeRemoteControlTogglePlayPause) {
            [self togglePlayPause];
        }
    }
}
@end
