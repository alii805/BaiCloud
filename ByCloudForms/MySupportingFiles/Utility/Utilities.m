//
//  Utilities.m
//  Glober
//
//  Created by Muhammad Imran on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utilities.h"
#import "Reachability.h"
#import "AppDelegate.h"

@implementation Utilities

@synthesize progressIndicator;

+ (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:email];
}
+(BOOL)validateFirstAndLastNameCharsOnly: (NSString *) candidate 
{
    NSString *nameRegex = @"[A-Za-z]{1,20}";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:candidate];
}
+ (BOOL) validateZipCode: (NSString *) candidate 
{
    NSString *emailRegex = @"[0-9]{1,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}
+(void)simpleOkAlertBox:(NSString*)title Body:(NSString*)body
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:title
                          message:body
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil];
    [alert show];
}

+ (BOOL) validateFloatValue: (NSString *) candidate
{
    NSString *emailRegex = @"[-+]?[0-9]*\\.?[0-9]*";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

+(NSString*)findPlistPath:(NSString*)PlistName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",PlistName]]; //3
    return path;
}


+(void)createPlist:(NSString *)plistName{
    
    NSError* error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * path =[Utilities findPlistPath:plistName];
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
}

+(void)writeIntoPlist:(NSMutableDictionary*)dataDict and:(NSString *)plistName{
    NSString * path =[Utilities findPlistPath:plistName];
    
    NSMutableDictionary *allKeys =[NSMutableDictionary new]; 
    [allKeys setObject:dataDict forKey:@"dataArray"];
    [allKeys writeToFile:path atomically:YES];
    
}

+(NSMutableDictionary*)readFromPlist:(NSMutableDictionary*)dataDict and:(NSString *)plistName
{
    // NSMutableArray *tempArray =[NSMutableArray arrayWithContentsOfFile:[UtilityClass findPlistPath:plistName]];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[Utilities findPlistPath:plistName]];
    return dictionary;
}

+(NSMutableDictionary *)setplist
{
    NSMutableDictionary *dictionary;

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"signUp.plist"]; //3
    dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    return dictionary;
}

+(UIImage*)getImage:(NSString*)imageName
{
    NSString *mediaUrl =[[NSString alloc] init];
    NSData *imageData = [[NSData alloc] init];
    UIImage *imageFromImageData;
    
//    mediaUrl = [NSString stringWithFormat:@"%@%@",URLForImageDownload,imageName];
    
//    [nImage setImageWithURL:[NSURL URLWithString:mediaUrl] placeholderImage:nil];
    
    if(nil != mediaUrl)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        @try 
        {
            imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:mediaUrl]] ;
        }
        @catch (NSException * e) 
        {
            
        }
        @finally 
        {
            imageFromImageData = [[UIImage alloc] initWithData:imageData];
            if (imageFromImageData==nil) 
            {
                return [UIImage imageNamed:@"no_avatar.png"];
            }
            else 
            {
                return imageFromImageData;
            }
        }
    }
}

+ (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size 
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return destImage;
}

+ (UIImage*)mergeImage:(UIImage*)first withImage:(UIImage*)second
{
    CGImageRef firstImageRef = first.CGImage;
    CGFloat firstWidth = CGImageGetWidth(firstImageRef);
    CGFloat firstHeight = CGImageGetHeight(firstImageRef);
    
    CGImageRef secondImageRef = second.CGImage;
    CGFloat secondWidth = CGImageGetWidth(secondImageRef);
    CGFloat secondHeight = CGImageGetHeight(secondImageRef);
    
    CGSize mergedSize = CGSizeMake(MAX(firstWidth, secondWidth), MAX(firstHeight, secondHeight));
    
    UIGraphicsBeginImageContext(mergedSize);
    
    [first drawInRect:CGRectMake(0, 0, firstWidth, firstHeight)];
    [second drawInRect:CGRectMake(0, 0, secondWidth, secondHeight)]; 
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(BOOL)isTall
{
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        return YES;
    }
    return NO;
}

+(NSString *)getDeviceType
{
    NSString *deviceType = [UIDevice currentDevice].systemName;
    return deviceType;
}


+(NSString *)getDeviceVersion
{
    NSString *deviceVersion = [UIDevice currentDevice].systemVersion;
    return deviceVersion;
    //if ((![UIApplication sharedApplication].statusBarHidden && (int)[[UIScreen mainScreen] applicationFrame].size.height == 548) || ([UIApplication sharedApplication].statusBarHidden && (int)[[UIScreen mainScreen] applicationFrame].size.height == 568))
}
+ (UIImage*) imageCorrectedForCaptureOrientation:(UIImage*)anImage
{
    float rotation_radians = 0;
    bool perpendicular = false;
    
    switch ([anImage imageOrientation]) {
        case UIImageOrientationUp:
            rotation_radians = 0.0;
            break;
        case UIImageOrientationDown:
            rotation_radians = M_PI;
            break;
        case UIImageOrientationRight:
            rotation_radians = M_PI_2;
            perpendicular = true;
            break;
        case UIImageOrientationLeft:
            rotation_radians = -M_PI_2;
            perpendicular = true;
            break;
        default:
            break;
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(anImage.size.width, anImage.size.height));
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, anImage.size.width/2, anImage.size.height/2);
    CGContextRotateCTM(context, rotation_radians);
    
    CGContextScaleCTM(context, 1.0, -1.0);
    float width = perpendicular ? anImage.size.height : anImage.size.width;
    float height = perpendicular ? anImage.size.width : anImage.size.height;
    CGContextDrawImage(context, CGRectMake(-width / 2, -height / 2, width, height), [anImage CGImage]);
    
    if (perpendicular) {
        CGContextTranslateCTM(context, -anImage.size.height/2, -anImage.size.width/2);
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
   
    newImage = [self resizeImage:newImage newSize: CGSizeMake(320.0,560.0)];
    
    return newImage;
}
+ (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize
{
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
    CGContextConcatCTM(context, flipVertical);
    CGContextDrawImage(context, newRect, imageRef);
    
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(UIFont*)setFont:(CGFloat)fontSize
{
    return  [UIFont boldSystemFontOfSize:fontSize];
}
#pragma Reset View
+(void)resetView:(float)yOrigin myView:(UIView*)myView
{
    CGRect viewFrame = myView.frame;
    if (yOrigin==0 && viewFrame.origin.y!=0)
    {
        viewFrame.origin.y=yOrigin;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        [myView setFrame:viewFrame];
        [UIView commitAnimations];
    }
    else if(yOrigin>0 ||yOrigin<0)
    {
        viewFrame.origin.y=yOrigin;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        [myView setFrame:viewFrame];
        [UIView commitAnimations];
    }
    
    
}
+(NSString*)convertToDegreesLattitude:(double)latitude
{
    NSString *lat = @"";
    int degrees = latitude;
    double decimal = fabs(latitude - degrees);
    int minutes = decimal * 60;
    double seconds = decimal * 3600 - minutes * 60;
    if ((degrees == 0) && (minutes == 0) && (seconds == 0))
    {
        lat = [NSString stringWithFormat:@"%d°%d'%1.0f\"", (degrees), minutes, seconds];
    }
    else if (latitude>0)
    {
        lat = [NSString stringWithFormat:@"N %d°%d'%1.0f\"",degrees, minutes, seconds];
    }
    else if (latitude<0)
    {
        lat = [NSString stringWithFormat:@"S %d°%d'%1.0f\"",(-1*degrees), minutes, seconds];
    }
    return lat;
}
+(NSString*)convertToDegreesLongitude:(double)longitude
{
    NSString *longt = @"";
    int degrees = longitude;
    double decimal = fabs(longitude - degrees);
    int minutes = decimal * 60;
    double seconds = decimal * 3600 - minutes * 60;
    
    if ((degrees == 180) && (minutes == 0) && (seconds == 0))
    {
        longt = [NSString stringWithFormat:@"%d°%d'%1.0f\"", (degrees), minutes, seconds];
    }
    else if ((degrees == 0) && (minutes == 0) && (seconds == 0))
    {
        longt = [NSString stringWithFormat:@"%d°%d'%1.0f\"", (degrees), minutes, seconds];
    }
    else if (longitude>0)
    {
        longt = [NSString stringWithFormat:@"E %d°%d'%1.0f\"", degrees, minutes, seconds];
    }
    else if (longitude<0)
    {
        longt = [NSString stringWithFormat:@"W %d°%d'%1.0f\"", (-1*degrees), minutes, seconds];
    }
    return longt;
}

+ (NSString *)encodeString:(NSString *)string
{
    NSString *newString = (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL,CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return newString;
}

-(NSMutableDictionary*)NewDictionaryReplacingNSNullWithEmptyNSString:(NSMutableDictionary * )dict
{
    NSMutableDictionary * const m = [dict mutableCopy];
    NSString * const empty = @"";
    id const nul = [NSNull null];
    NSArray * const keys = [m allKeys];
    for (NSUInteger idx = 0, count = [keys count]; idx < count; ++idx) {
        id const key = [keys objectAtIndex:idx];
        id const obj = [m objectForKey:key];
        if (nul == obj) {
            [m setObject:empty forKey:key];
        }
    }
    
    NSMutableDictionary * result = [m copy];
    return result;    
}
+ (NSString *)dateParser:(NSString *)inputString DateFormatter:(NSString *)format
{
    if([inputString isEqualToString:@""])
    {
        return @"";
    }
    if ([inputString rangeOfString:@"Date"].location == NSNotFound)
    {
        return inputString;
    }
    [inputString stringByReplacingOccurrencesOfString: @"/" withString:@""];
    [inputString stringByReplacingOccurrencesOfString: @"Date" withString:@""];
    [inputString stringByReplacingOccurrencesOfString: @"(" withString:@""];
    [inputString stringByReplacingOccurrencesOfString: @")" withString:@""];
    NSInteger offset = [[NSTimeZone defaultTimeZone] secondsFromGMT];
    NSDate * dateNew = [[NSDate dateWithTimeIntervalSince1970:[inputString intValue]]dateByAddingTimeInterval:offset];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:format];
    inputString = [dateFormat stringFromDate:dateNew];
    return inputString;
}

+(NSMutableDictionary*)NewDictionaryReplacingNSNullWithEmptyNSStringMutable:(NSMutableDictionary * )dict
{
    
    NSMutableDictionary * const m = [dict mutableCopy];
    NSString * const empty = @"";
    id const nul = [NSNull null];
    NSArray * const keys = [m allKeys];
    for (NSUInteger idx = 0, count = [keys count]; idx < count; ++idx) {
        id const key = [keys objectAtIndex:idx];
        id const obj = [m objectForKey:key];
        NSString *str = [NSString stringWithFormat:@"%@",[m objectForKey:key]];
        if (nul == obj )
        {
            [m setObject:empty forKey:key];
        }
        else if ([str isEqualToString:@"(null)"])
        {
            [m setObject:empty forKey:key];
        }
    }
    
    NSMutableDictionary * result = [m copy];
    return result;
}
+(NSDictionary*)NewDictionaryReplacingNSNullWithEmptyNSString:(NSDictionary * )dict
{
    NSMutableDictionary * const m = [dict mutableCopy];
    NSString * const empty = @"";
    id const nul = [NSNull null];
    NSArray * const keys = [m allKeys];
    for (NSUInteger idx = 0, count = [keys count]; idx < count; ++idx) {
        id const key = [keys objectAtIndex:idx];
        id const obj = [m objectForKey:key];
        NSString *str = [NSString stringWithFormat:@"%@",[m objectForKey:key]];
        if (nul == obj )
        {
            [m setObject:empty forKey:key];
        }
        else if ([str isEqualToString:@"(null)"])
        {
            [m setObject:empty forKey:key];
        }
    }
    NSDictionary * result = [m copy];
    return result;
}

#pragma mark - check connection
+ (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

+ (void)showAlertForNoInternetConnectionAvailable
{
    UIAlertView * _connAlert = [[UIAlertView alloc] initWithTitle:@"No internet connection"
                                                          message:@"For maximum app functionality please check your connectivity."
                                                         delegate:nil
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Retry", nil];
    [_connAlert show];
}
+ (void) showHudOnView:(id)onView HUDObj:(MBProgressHUD*)hud labelText:(NSString*)labelText detailLabelText:(NSString*)detailsLabelText dimBackGround:(BOOL)value{
    
    [onView addSubview:hud];
    
    hud.labelText = labelText;
    hud.detailsLabelText = detailsLabelText;
    hud.dimBackground = value;
    //    [HUD showWhileExecuting:@selector(myTask) onTarget:delegate withObject:nil animated:YES];
    
    [hud show:YES];
}

#pragma mark - MBProgress HUD

+ (void)hudWasHidden:(MBProgressHUD *)hud
{
	// Remove HUD from screen when the HUD was hidded
    [hud hide:YES];
	[hud removeFromSuperview];
	hud = nil;
}
+ (NSString *)removingXMLEnvelope:(NSString *)responseString
{
    responseString = [[[responseString stringByReplacingOccurrencesOfString:@"<string xmlns=\"http://tempuri.org/\">" withString:@""] stringByReplacingOccurrencesOfString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>" withString:@""] stringByReplacingOccurrencesOfString:@"</string>" withString:@""];
    
    return responseString;
}
+ (NSString *)addingArrays:(NSMutableArray *)ary
{
    NSString *str = [ary objectAtIndex:0];
    if ([ary count]>1)
    {
        for (int i = 1;i < [ary count]; i++)
        {
            str = [NSString stringWithFormat:@"%@,%@",str,[ary objectAtIndex:i]];
//            NSLog(@"%@",str);
        }
    }
    
//    NSLog(@"Full str = %@",str);
    return str;
}
+ (NSString *)addingArraysForMultiSelection:(NSMutableArray *)ary Key:(NSString *)jKey
{
    NSString *str = [[ary objectAtIndex:0] valueForKey:jKey];
    if ([ary count]>1)
    {
        for (int i = 1;i < [ary count]; i++)
        {
            str = [NSString stringWithFormat:@"%@,%@",str,[[ary objectAtIndex:i] valueForKey:jKey]];
//            NSLog(@"%@",str);
        }
    }
    
//    NSLog(@"Full str = %@",str);
    return str;
}
+ (NSString *)stringFromTextField:(UIView *)myView MyTag:(int)myTag
{
    UITextField *currentTxtField = (UITextField *)[myView viewWithTag:myTag];
    NSString *currentString = currentTxtField.text;
    if ( ([currentTxtField.text isEqualToString:@"(null)"]) || ([currentTxtField.text isEqualToString:@"null"]) || ([currentTxtField.text isEqualToString:@""]) ) {
        return nil;
    }
    return  currentString;
}
+ (NSString *)stringFromTextView:(UIView *)myView MyTag:(int)myTag
{
    UITextView *currentTxtView = (UITextView *)[myView viewWithTag:myTag];
    NSString *currentString = currentTxtView.text;
    if ( ([currentTxtView.text isEqualToString:@"(null)"]) || ([currentTxtView.text isEqualToString:@"null"]) || ([currentTxtView.text isEqualToString:@""]) ) {
        return nil;
    }
    return  currentString;
}
+ (NSString *)stringFromButton:(UIView *)myView MyTag:(int)myTag
{
    UIButton *currentBtn = (UIButton *)[myView viewWithTag:myTag];
    if ( ([currentBtn.titleLabel.text isEqualToString:@"(null)"]) || ([currentBtn.titleLabel.text isEqualToString:@"null"]) || ([currentBtn.titleLabel.text isEqualToString:@""]) ) {
        return nil;
    }
    return  currentBtn.titleLabel.text;
}
+ (NSString *)stringFromLable:(UIView *)myView MyTag:(int)myTag
{
    UILabel *currentLable = (UILabel *)[myView viewWithTag:myTag];
    return  currentLable.text;
    
}
+(NSMutableDictionary*)NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:(NSMutableDictionary * )dict
{
    
    NSMutableDictionary * const m = [dict mutableCopy];
    NSString * const empty = @"";
    id const nul = [NSNull null];
    NSArray * const keys = [m allKeys];
    for (NSUInteger idx = 0, count = [keys count]; idx < count; ++idx) {
        id const key = [keys objectAtIndex:idx];
        id const obj = [m objectForKey:key];
        NSString *str = [NSString stringWithFormat:@"%@",[m objectForKey:key]];
        if (nul == obj )
        {
            [m setObject:empty forKey:key];
        }
        else if ([str isEqualToString:@"(null)"])
        {
            [m setObject:empty forKey:key];
        }
    }
    
    NSMutableDictionary * result = [m copy];
    return result;
}
#pragma mark getDatabasePath
+(NSString *) getDatabasePath
{
    NSString *databasePath = [(AppDelegate *)[[UIApplication sharedApplication] delegate] databasePath];
    
    return databasePath;
}
@end
