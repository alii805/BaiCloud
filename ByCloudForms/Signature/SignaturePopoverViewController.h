//
//  SignaturePopoverViewController.h
//  TowBoat
//
//  Created by Kamran on 18/03/2013.
//  Copyright (c) 2013 Khurram Awan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "Utilities.h"
#import "BCF_Defines.h"


@protocol MySignature <NSObject>
@optional
- (void)getSign:(UIImage *)image;

@end

@interface SignaturePopoverViewController : UIViewController
{
    id <MySignature> delegate;
    __weak IBOutlet UIButton *btnSave;
    __weak IBOutlet UIButton *btnClear;
    BOOL mouseSwiped;
    CGPoint lastPoint;
    __weak IBOutlet UIImageView *signatureView;
    NSURL *imageURL;
    NSString *myTag;
    NSString *fieldID;
    NSString *formID;
    NSString *userID;
    int viewFlag;
    
    ALAssetsLibrary* library;
    int ii;
    int ourSize;
}
@property (readwrite, strong) NSString *myTag;
@property (readwrite, strong) NSString *fieldID;
@property (readwrite, strong) NSString *formID;
@property (readwrite, strong) NSString *userID;
@property (readwrite) int viewFlag;

@property(nonatomic,strong) id delegate;
@property (weak, nonatomic) IBOutlet UIImageView *signatureView;
@property (strong, atomic) ALAssetsLibrary* library;

- (IBAction)btnSave:(id)sender;
- (IBAction)CancelSignature:(id)sender;


@end




