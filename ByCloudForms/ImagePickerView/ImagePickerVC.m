//
//  ImagePickerVC.m
//  ByCloudForms
//
//  Created by Fahad Arshad on 6/18/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import "ImagePickerVC.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ImagePickerVC ()

@end

@implementation ImagePickerVC
@synthesize flag,imgView,myTag,delegate,popoverController,toolbar,fieldID;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}
- (void)btnBack
{
   [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
//    btnBack = [[UIBarButtonItem alloc]
//                    initWithTitle:@""
//                    style:UIBarButtonSystemItemRedo
//                    target:self
//                    action:@selector(btnBack)];
//    self.navigationItem.leftBarButtonItem.enabled = YES;
//    self.navigationItem.leftBarButtonItem= btnBack;
//    [super viewDidLoad];
//    UINavigationController *myNav = [[UINavigationController alloc] initWithRootViewController:self.view];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        cameraButton = [[UIBarButtonItem alloc]
                        initWithTitle:@"Camera"
                        style:UIBarButtonItemStyleBordered
                        target:self
                        action:@selector(useCameraIphone:)];
        cameraRollButton = [[UIBarButtonItem alloc]
                            initWithTitle:@"Camera Roll"
                            style:UIBarButtonItemStyleBordered
                            target:self
                            action:@selector(useCameraRollIphone:)];
        
        NSArray *items = [NSArray arrayWithObjects: cameraButton,cameraRollButton, nil];
        
        
        [toolbar setItems:items animated:NO];
    }
    else
    {
        
        cameraButton = [[UIBarButtonItem alloc]
                        initWithTitle:@"Camera"
                        style:UIBarButtonItemStyleBordered
                        target:self
                        action:@selector(useCamera:)];
        cameraRollButton = [[UIBarButtonItem alloc]
                            initWithTitle:@"Camera Roll"
                            style:UIBarButtonItemStyleBordered
                            target:self
                            action:@selector(useCameraRoll:)];
        
        NSArray *items = [NSArray arrayWithObjects: cameraButton,cameraRollButton, nil];
        
        
        [toolbar setItems:items animated:NO];
        
        //========
        //            BOOL hasCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        //            UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        //            picker.delegate = self;
        //            picker.sourceType = hasCamera ? UIImagePickerControllerSourceTypeCamera :    UIImagePickerControllerSourceTypePhotoLibrary;
        //
        //            popoverController = [[UIPopoverController alloc] initWithContentViewController:picker];
        //            CGRect popoverRect = CGRectMake(0.0, 0.0, 400.0, 400.0);
        //
        //            popoverRect.size.width = MIN(popoverRect.size.width, 100) ;
        //            popoverRect.origin.x = popoverRect.origin.x;
        //
        //            [popoverController presentPopoverFromRect:CGRectMake(10, 10, 100, 100) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }

    
//    if (flag == camrarollImage)
//    {
//        
//    }
//    else
    if (flag == captureImage)
    {
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate = self;
//        picker.allowsEditing = NO;
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        
//        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//        {
//            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
//            [popover presentPopoverFromRect:self.view.bounds inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//            self.popover = popover;
//        }
//        else
//        {
//            [self presentModalViewController:picker animated:YES];
//        }
        if ([[Singleton sharedInstance].dictImageContainer count]>0)
        {
            if ([[Singleton sharedInstance].dictImageContainer objectForKey:myTag])
            {
                //                self.imgView.image = [[Singleton sharedInstance].dictImageContainer objectForKey:myTag];
                
                
                NSString *path = [[Singleton sharedInstance].dictImageContainer objectForKey:myTag];
                //                NSString *path = @"assets-library://asset/asset.JPG?id=81D2C370-653B-4796-96CF-D1655DDC5196&ext=JPG";
                
                {
                    
                    NSURL *url = [[NSURL alloc] initWithString:path];
                    NSLog(@"%@",path);
                    
                    typedef void (^ALAssetsLibraryAssetForURLResultBlock)(ALAsset *asset);
                    typedef void (^ALAssetsLibraryAccessFailureBlock)(NSError *error);
                    
                    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset){
                        
                        ALAssetRepresentation *rep = [myasset defaultRepresentation];
                        CGImageRef iref = [rep fullResolutionImage];
                        UIImage *myImage;
                        
                        if (iref){
                            
                            myImage = [UIImage imageWithCGImage:iref scale:[rep scale] orientation:(UIImageOrientation)[rep orientation]];
                            self.imgView.image = myImage;
                            //upload the image
                            
                        }
                    };
                    
                    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
                    {
                        [Utilities simpleOkAlertBox:@"Error" Body:@"Unable to find image.This image is deleted or moved some where else."];
                    };
                    
                    
                    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
                    [assetslibrary assetForURL:url
                                   resultBlock:resultblock
                     
                                  failureBlock:failureblock];
                    
                    
                }
                
                
                
                //                NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"assets-library://asset/asset.JPG?id=BCA50E87-2569-47F8-B343-E43ECC17C592&ext=JPG"]];
                //                self.imgView.image = [UIImage imageWithData:mydata];
            }
            
        }
    }
    else if (flag == viewImageOnly)
    {
                cameraRollButton.enabled = NO;
        cameraButton.enabled = NO;
        
        if ([[Singleton sharedInstance].dictImageContainer count]>0)
        {
            if ([[Singleton sharedInstance].dictImageContainer objectForKey:myTag])
            {
//                self.imgView.image = [[Singleton sharedInstance].dictImageContainer objectForKey:myTag];
               
                
                 NSString *path = [[Singleton sharedInstance].dictImageContainer objectForKey:myTag];
//                NSString *path = @"assets-library://asset/asset.JPG?id=81D2C370-653B-4796-96CF-D1655DDC5196&ext=JPG";
                
                
                    
                    
                    NSURL *url = [NSURL URLWithString:path];//[[NSURL alloc] initWithString:path];
                    
                    typedef void (^ALAssetsLibraryAssetForURLResultBlock)(ALAsset *asset);
                    typedef void (^ALAssetsLibraryAccessFailureBlock)(NSError *error);
                    
                    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset){
                        
                        ALAssetRepresentation *rep = [myasset defaultRepresentation];
                        CGImageRef iref = [rep fullResolutionImage];
                        UIImage *myImage;
                        
                        if (iref){
                            
                           myImage = [UIImage imageWithCGImage:iref scale:[rep scale] orientation:(UIImageOrientation)[rep orientation]];
                            self.imgView.image = myImage;
                            //upload the image
                            
                        }
                        else
                        {
                            myImage = [self getImage];
                            self.imgView.image = myImage;
                        }
                    };
                    
                    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
                    {
                        [Utilities simpleOkAlertBox:@"Error" Body:@"Unable to find image.This image is deleted or moved some where else."];
                    };
                    
                    
                    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
                    [assetslibrary assetForURL:url
                                   resultBlock:resultblock
                     
                                  failureBlock:failureblock];
                    
                
                
                 
                 
//                NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"assets-library://asset/asset.JPG?id=BCA50E87-2569-47F8-B343-E43ECC17C592&ext=JPG"]];
//                self.imgView.image = [UIImage imageWithData:mydata];
            }
            
        }
       
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate = self;
//        picker.allowsEditing = NO;
//        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else
    {
        self.navigationController.navigationBar.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
// Dispose of any resources that can be recreated.
}
- (IBAction) useCameraRollIphone: (id)sender
{
    isClicked = NO;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
//
    
    
    
}
- (IBAction) useCameraIphone: (id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        isClicked = YES;
        
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects: (NSString *) kUTTypeImage,nil];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
        newMedia = YES;
    }
}
- (IBAction) useCameraRoll: (id)sender
{
    
    if ([self.popoverController isPopoverVisible])
    {
        [self.popoverController dismissPopoverAnimated:YES];
    }
    else
    {
        BOOL hasCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
            UIImagePickerController* picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = hasCamera ? UIImagePickerControllerSourceTypeCamera :    UIImagePickerControllerSourceTypePhotoLibrary;

            popoverController = [[UIPopoverController alloc] initWithContentViewController:picker];
            CGRect popoverRect = CGRectMake(80, toolbar.frame.origin.y+20, 100.0, 100.0);

            popoverRect.size.width = MIN(popoverRect.size.width, 100) ;
            popoverRect.origin.x = popoverRect.origin.x;
        
            [popoverController presentPopoverFromRect:popoverRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        //=======
//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
//        {
//            UIImagePickerController *imagePicker =
//            [[UIImagePickerController alloc] init];
//            imagePicker.delegate = self;
//            imagePicker.sourceType =
//            UIImagePickerControllerSourceTypePhotoLibrary;
////            imagePicker.mediaTypes = [NSArray arrayWithObjects:
////                                      (NSString *) kUTTypeImage,
////                                      nil];
//            imagePicker.allowsEditing = NO;
//            
//            self.popoverController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
//            
//            popoverController.delegate = self;
//            
//            [self.popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//            
//
//            newMedia = NO;
//        }
    }
}
- (IBAction) useCamera: (id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        
        
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects: (NSString *) kUTTypeImage,nil];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
        newMedia = YES;
        
    }
}
#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if(isClicked)
    {
        NSLog(@"Camera Take");
        
        
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
        {
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            imgView.image = image;
            UIImageJPEGRepresentation(image,0.1);
            //You have to Save Image in Documents and get its Url
            
            NSURL *url = [self saveImage:imgView.image];
           
            //End Making Document Url
            
            [[Singleton sharedInstance].dictImageContainer setObject:[NSString stringWithFormat:@"%@",url] forKey:myTag];
            [[Singleton sharedInstance].dictImageContainerID setObject:fieldID forKey:[NSString stringWithFormat:@"%@",url]];
            [picker dismissViewControllerAnimated:YES completion:NULL];
            
        }
        else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
        {
            // Code here to support video if enabled
        }
        else if ([mediaType isEqualToString:(NSString *)kUTTypePDF])
        {
            // Code here to support PDF if enabled
        }
        
    }
    else
    {
    //    [self.popoverController dismissPopoverAnimated:true];
    //    
    //    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //    [self dismissViewControllerAnimated:YES completion:nil];
    //    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    //    {
    //        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //        
    //        imgView.image = image;
    ////        if (newMedia)
    ////            UIImageWriteToSavedPhotosAlbum(image,
    ////                                           self,
    ////                                           @selector(image:finishedSavingWithError:contextInfo:),
    ////                                           nil);
    //    }
    //    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    //    {
    //        // Code here to support video if enabled
    //    }
    //    else if ([mediaType isEqualToString:(NSString *)kUTTypePDF])
    //    {
    //        // Code here to support PDF if enabled
    //    }
    //==================================
        [picker dismissViewControllerAnimated:YES completion:NULL];
    //    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    //==========
        NSURL *resourceURL = [info objectForKey:UIImagePickerControllerReferenceURL];
        NSLog(@"%@",resourceURL);
    //=========
       
    //    imgView.image = chosenImage;
    //    if (resourceURL)
    //    {
    ////        [[Singleton sharedInstance].dictImageContainer setObject:[NSString stringWithFormat:@"%@",resourceURL] forKey:myTag];
    //        if (delegate)
    //        {
    //            [delegate imgSelected:[tag integerValue] UIImage:chosenImage];
    //        }
    //    }
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
        }
        else
        {
            if (popoverController != nil) {
                [popoverController dismissPopoverAnimated:YES];
                popoverController=nil;
            }
        }
        

        
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
        {
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            
            imgView.image = image;
            [[Singleton sharedInstance].dictImageContainer setObject:[NSString stringWithFormat:@"%@",resourceURL] forKey:myTag];
            [[Singleton sharedInstance].dictImageContainerID setObject:fieldID forKey:[NSString stringWithFormat:@"%@",resourceURL]];
            UIImageJPEGRepresentation(image, 0.1);
           //        if (newMedia)
    //            UIImageWriteToSavedPhotosAlbum(image,
    //                                           self,
    //                                           @selector(image:finishedSavingWithError:contextInfo:),
    //                                           nil);
        }
        else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
        {
            // Code here to support video if enabled
        }
        else if ([mediaType isEqualToString:(NSString *)kUTTypePDF])
        {
            // Code here to support PDF if enabled
        }
        if(resourceURL) {
            // it's a video: handle import
            
        }
        else
        {
            
            // it's a photo
            //        resourceURL = [info objectForKey:UIImagePickerControllerReferenceURL];
            
            //    UIImage *image = [UIImage imageNamed:@"Default.png"];
    //        library = [[ALAssetsLibrary alloc] init];
    //        
    //        [library addAssetsGroupAlbumWithName:@"BaiCloud"
    //                                 resultBlock:^(ALAssetsGroup *group) {
    //                                     NSLog(@"added album:BaiCloud");
    //                                 }
    //                                failureBlock:^(NSError *error) {
    //                                    NSLog(@"error adding album");
    //                                }];
    //        
    //        
    //        
    //
    //        
    //        [library saveImage:imgView.image toAlbum:@"BaiCloud" withCompletionBlock:^(NSError *error) {
    //            if (error!=nil) {
    //                //NSLog(@"Big error: %@", [error description]);
    //            }
    //        }];
            
        
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            // Request to save the image to camera roll
            [library writeImageToSavedPhotosAlbum:[imgView.image CGImage] orientation:(ALAssetOrientation)[imgView.image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
                if (error) {
    //                NSLog(@"error");
                } else {
    //                NSLog(@"url =  %@", assetURL);
                    [[Singleton sharedInstance].dictImageContainer setObject:[NSString stringWithFormat:@"%@",assetURL] forKey:myTag];
                }  
            }];
            
            
            
        }
    }
//    NSLog(@"Path = %@",resourceURL);
    
}
- (NSURL *)saveImage : (UIImage*)img {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
    NSData *imageData = UIImageJPEGRepresentation(img, 0.1);
    [imageData writeToFile:savedImagePath atomically:YES];
    NSURL * resourceurl = [NSURL URLWithString:savedImagePath];
    
    return resourceurl;
}

- (UIImage*)getImage {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
    
    UIImage *img = [UIImage imageWithContentsOfFile:getImagePath];
    
    //NSData *data = UIImageJPEGRepresentation(img, 1);
    
    return img;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (delegate)
    {
        [delegate imgCanceled:[tag integerValue]];
    }
    [self.navigationController popViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"\
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
       
    }
}

@end
