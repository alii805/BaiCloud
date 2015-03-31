//
//  ImagePickerVC.h
//  ByCloudForms
//
//  Created by Fahad Arshad on 6/18/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "Singleton.h"
#import "Utilities.h"
#import <AssetsLibrary/AssetsLibrary.h>

@protocol imgViewProtocol <NSObject>
@optional

-(void)imgCanceled:(NSInteger)row;
-(void)imgSelected:(NSInteger)row UIImage:(UIImage*)img;

@end

@interface ImagePickerVC : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPopoverControllerDelegate>
{
//    NSURL *imageURL;
//    ALAssetsLibrary* library;
    int flag;
    NSString *tag;
    UIImageView *imgView;
    id <imgViewProtocol> delegate;
    UIToolbar *toolbar;
    BOOL newMedia;
    UIBarButtonItem *cameraButton,*cameraRollButton,*btnBack;
    NSString *fieldID;
    
    BOOL  isClicked;
    BOOL isview;
}
@property(nonatomic,strong) id delegate;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property(assign,readwrite) int flag;
@property (readwrite, strong) NSString *myTag;
@property (readwrite, strong) NSString *fieldID;
@property (strong, nonatomic) UIPopoverController *popoverController;
@property (strong, nonatomic) ImagePickerVC *imagePickerVC;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
- (UIImage*)getImage;


@end
