//
//  AudioVC.h
//  ByCloudForms
//
//  Created by Fahad Arshad on 7/23/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PlayMusic.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
//#import <AssetsLibrary/AssetsLibrary.h>
#import "CoreAudio/CoreAudioTypes.h"
#import "Utilities.h"
#import "BCF_Defines.h"
#import "Singleton.h"

@interface AudioRecVC : UIViewController<AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
       AVAudioRecorder *audioRecorderd;
       AVAudioPlayer *audioPlayerd;
       MPMediaItem *songd;
//       ALAssetsLibrary* libraryd;
       NSURL *soundSelectedFileURLd;
    __weak IBOutlet UIButton *btnRecording;
    __weak IBOutlet UIButton *btnPlay;
    __weak IBOutlet UIButton *btnGallary;
    __weak IBOutlet UIActivityIndicatorView *activityIndicator;
       NSURL *soundFileURL2d;
       NSURL *soundFileURLd;
//       PlayMusic *music;
       NSString *myTag;
       NSString *fieldID;
       NSString *formID;
       NSString *userID;
       int flagLibrary;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (readwrite) int flagLibrary;
@property (readwrite, strong) NSString *myTag;
@property (readwrite, strong) NSString *fieldID;
@property (readwrite, strong) NSString *formID;
@property (readwrite, strong) NSString *userID;

@property (strong, nonatomic) AVAudioRecorder *audioRecorderd;
//@property (nonatomic, retain) AVAudioPlayer *audioPlayerd;
//@property (strong, atomic) ALAssetsLibrary* libraryd;

- (IBAction)btnRecording:(id)sender;
- (IBAction)btnPlay:(id)sender;
- (IBAction)btnGallary:(id)sender;

@end
