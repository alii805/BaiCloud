//
//  SignaturePopoverViewController.m
//  TowBoat
//
//  Created by Kamran on 18/03/2013.
//  Copyright (c) 2013 Khurram Awan. All rights reserved.
//

#import "SignaturePopoverViewController.h"

@interface SignaturePopoverViewController ()

@end

@implementation SignaturePopoverViewController
@synthesize signatureView,delegate;
@synthesize myTag,formID,fieldID,userID,viewFlag,library;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (viewFlag == fSignView)
    {
        btnClear.hidden = YES;
        btnSave.hidden = YES;
    }
    if ([[Singleton sharedInstance].dictSingnContainer count]>0)
    {
        if ([[Singleton sharedInstance].dictSingnContainer objectForKey:myTag])
        {
            //                self.imgView.image = [[Singleton sharedInstance].dictImageContainer objectForKey:myTag];
            
            
            NSString *path = [[Singleton sharedInstance].dictSingnContainer objectForKey:myTag];
            //                NSString *path = @"assets-library://asset/asset.JPG?id=81D2C370-653B-4796-96CF-D1655DDC5196&ext=JPG";
            
            {
                
                NSURL *url = [[NSURL alloc] initWithString:path];
                
                typedef void (^ALAssetsLibraryAssetForURLResultBlock)(ALAsset *asset);
                typedef void (^ALAssetsLibraryAccessFailureBlock)(NSError *error);
                
                ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset){
                    
                    ALAssetRepresentation *rep = [myasset defaultRepresentation];
                    CGImageRef iref = [rep fullResolutionImage];
                    UIImage *myImage;
                    
                    if (iref){
                        
                        myImage = [UIImage imageWithCGImage:iref scale:[rep scale] orientation:(UIImageOrientation)[rep orientation]];
                        self.signatureView.image = myImage;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    signatureView = nil;
    [super viewDidUnload];
}

#pragma mark Signature Functions
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:signatureView];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:signatureView];
    
    if (CGRectContainsPoint([signatureView frame], [touch locationInView:signatureView]))
    {
        UIGraphicsBeginImageContext(signatureView.frame.size);
        [signatureView.image drawInRect:CGRectMake(0, 0, signatureView.frame.size.width, signatureView.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        
        signatureView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        lastPoint = currentPoint;
    }
    else
    {
        lastPoint = currentPoint;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!mouseSwiped)
    {
        UIGraphicsBeginImageContext(signatureView.frame.size);
        [signatureView.image drawInRect:CGRectMake(0, 0, signatureView.frame.size.width, signatureView.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 0.0);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        signatureView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}
- (IBAction)btnSave:(id)sender
{
//    UIImage * img =  signatureView.image;
//    library = [[ALAssetsLibrary alloc] init];
//    
//    [library addAssetsGroupAlbumWithName:@"BaiCloudSignature"
//                             resultBlock:^(ALAssetsGroup *group) {
//                                 NSLog(@"added album:ByCloud");
//                             }
//                            failureBlock:^(NSError *error) {
//                                NSLog(@"error adding album");
//                            }];
//    
//    [self.library saveImage:img toAlbum:@"BaiCloudSignature" withCompletionBlock:^(NSError *error) {
//        if (error!=nil) {
//            //NSLog(@"Big error: %@", [error description]);
//        }
//        else
//        {
//            
//        }
//    }];

//    ALAssetsLibraryWriteImageCompletionBlock completeBlock = ^(NSURL *assetURL, NSError *error){
//        if (!error) {
//#pragma mark get image url from camera capture.
//            NSURL *imageURL = [NSString stringWithFormat:@"%@",assetURL];
//            NSLog(@"Path = %@",imageURL);
//        }
//    };
    
//    if(delegate)
//    {
//        [delegate getSign:img];
//    }
    
    UIImage *image = signatureView.image;
    
    imageURL = nil;
    
    ALAssetsLibraryWriteImageCompletionBlock completeBlock = ^(NSURL *assetURL, NSError *error){
        if (!error) {
#pragma mark get image url from camera capture.
            imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",assetURL]];
//            NSLog(@"Path = %@",imageURL);
            [[Singleton sharedInstance].dictSingnContainer setObject:[NSString stringWithFormat:@"%@",imageURL] forKey:myTag];
            [[Singleton sharedInstance].dictSingnContainerID setObject:fieldID forKey:[NSString stringWithFormat:@"%@",imageURL]];
        }
    };
    
    if(image){
        library = [[ALAssetsLibrary alloc] init];
        [self.library writeImageToSavedPhotosAlbum:[image CGImage]
                                  orientation:(ALAssetOrientation)[image imageOrientation]
                              completionBlock:completeBlock];
    }
    
    
    
}
- (IBAction)CancelSignature:(id)sender
{
    signatureView.image=nil;
}
//-(void)getLatestImages
//{
////    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//    
//    [self.library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop)
//     {
//         ii=1;
//         ourSize=1;
//         for (int j=0; j<ourSize; j++)
//         {
//             [group setAssetsFilter:[ALAssetsFilter allPhotos]];
//             
//             if([group numberOfAssets] >0)
//             {
//                 [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:([group numberOfAssets]-ii)]
//                                         options:0
//                                      usingBlock:^(ALAsset *alAsset, NSUInteger index, BOOL *innerStop)
//                  {
//                      
//                      ourSize = (int)[group numberOfAssets];
//                      if (ourSize>=12)
//                      {
//                          ourSize=12;
//                      }
//                      if (alAsset)
//                      {
//                          ALAssetRepresentation *representation = [alAsset defaultRepresentation];
//                          UIImage *latestPhoto = [UIImage imageWithCGImage:[representation fullScreenImage]];
//                          sendImage = latestPhoto;
//                          [myImgAry addObject:sendImage];
//                          if (ii==ourSize)
//                          {
//                              myInd=0;
//                              [self setData];
//                              [tblRecentImages reloadData];
//                              
//                          }
//                          ii++;
//                      }
//                  }];
//             }
//             else
//             {
//                 
//             }
//         }
//     }
//     
//                         failureBlock: ^(NSError *error)
//     {
//         [Utilities simpleOkAlertBox:@"Oops...!" Body:@"No image exists."];
//     }];
//}
@end
