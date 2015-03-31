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
#import <AssetsLibrary/AssetsLibrary.h>
#import "Utilities.h"
#import "BCF_Defines.h"
#import "Singleton.h"

@interface AudioVC : UIViewController<AVAudioRecorderDelegate,AVAudioPlayerDelegate,MPMediaPickerControllerDelegate>
{
       AVAudioRecorder *audioRecorder;
       AVAudioPlayer *audioPlayer;
       MPMediaItem *song;
       ALAssetsLibrary* library;
       NSURL *soundSelectedFileURL;
    __weak IBOutlet UIButton *btnRecording;
    __weak IBOutlet UIButton *btnPlay;
    __weak IBOutlet UIButton *btnGallary;
    __weak IBOutlet UIActivityIndicatorView *activityIndicator;
       NSURL *soundFileURL2;
       NSURL *soundFileURL;
//       PlayMusic *music;
       NSString *myTag;
       NSString *fieldID;
       NSString *formID;
       NSString *userID;
       int flagLibrary;
       MPMediaPickerController *pickerController;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (readwrite) int flagLibrary;
@property (readwrite, strong) NSString *myTag;
@property (readwrite, strong) NSString *fieldID;
@property (readwrite, strong) NSString *formID;
@property (readwrite, strong) NSString *userID;

@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
//@property (nonatomic, retain) AVAudioPlayer *audioPlayer;
@property (strong, atomic) ALAssetsLibrary* library;

- (IBAction)btnRecording:(id)sender;
- (IBAction)btnPlay:(id)sender;
- (IBAction)btnGallary:(id)sender;

@end
