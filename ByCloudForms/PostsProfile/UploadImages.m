//
//  UploadImages.m
//  ByCloudForms
//
//  Created by Fahad Arshad on 8/23/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import "UploadImages.h"

@implementation UploadImages
//#pragma mark - Upload image
//-(void)uploadImage
//{
//    myHud = [[MBProgressHUD alloc] init];
//    [Utilities showHudOnView:self.view HUDObj:myHud labelText:hudHead detailLabelText:hudDetail dimBackGround:YES];
//    
//    NSData *imageData = UIImageJPEGRepresentation(imgAddImage.image,90);
//    NSURL *url = [NSURL URLWithString:@"http://leadconcept.com/ryvalry/yiiproject/ws/ryvalryService/uploadImage"];
//    ASIFormDataRequest *request = [ASIFormDataRequest
//                                   requestWithURL:url];
//    [request setDelegate:self];
//    [request setPostValue:model.signinObj.sessionId forKey:@"session_id"];
//    [request setPostValue:model.startARyvalry._id forKey:@"ryvalry_id"];
//    [request setData:imageData withFileName:@"myphoto.jpg" andContentType:@"image/jpeg" forKey:@"file"];
//    [request startAsynchronous];
//}
//
//- (void)requestFinished:(ASIHTTPRequest *)request
//{
//    NSDictionary *responseDict;
//    
//    NSString *responseString = [request responseString];
//    
//    
//    responseString = [responseString stringByReplacingOccurrencesOfString: @"<string xmlns=\"http://tempuri.org/\">"
//                                                               withString:@""];
//    
//    responseString = [responseString stringByReplacingOccurrencesOfString: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//                                                               withString:@""];
//    
//    responseString = [responseString stringByReplacingOccurrencesOfString: @"</string>"
//                                                               withString:@""];
//    
//    responseString = [responseString stringByReplacingOccurrencesOfString: @"\r\n" withString:@""];
//    
//    
//    NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSError*error;
//    responseDict = [NSJSONSerialization JSONObjectWithData:data //1
//                                                   options:0
//                                                     error:&error];
//    
//    //    NSLog(@"%@", responseString);
//    //    NSLog(@"%@", responseDict);
//    [Utilities hudWasHidden:myHud];
//    if ([[responseDict valueForKey:@"status"] isEqualToString:@"Success"])
//    {
//        [Utilities simpleOkAlertBox:@"Success" Body:@"Image uploaded successfully."];
//    }
//    else
//    {
//        [Utilities simpleOkAlertBox:@"Failure" Body:@"Unable to upload the image."];
//    }
//    //        if (responseDict)
//    //        {
//    //            NSError *errorr = [ [NSError alloc] initWithDomain:@"Error" code:400 userInfo:responseDict];
//    ////            NSLog(@"No response from delegate");
//    //        }
//}
//
//- (void)requestFailed:(ASIHTTPRequest *)request
//{
//    [Utilities hudWasHidden:myHud];
//    NSError *error = [request error];
//    NSLog(@"%@",error);
//    if ([error code] == 400)
//    {
//        NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:[error userInfo]];
//        NSLog(@"%@",[dict valueForKey:@"error"]);
//        NSString *msg = [dict valueForKey:@"error"];
//        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alertView show];
//    }
//    else
//    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alertView show];
//    }
//}

@end
