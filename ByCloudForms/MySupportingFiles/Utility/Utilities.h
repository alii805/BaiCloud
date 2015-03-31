//
//  Utilities.h
//  Glober
//
//  Created by Muhammad Imran on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
//#import "Reachability.h"
//#import <SDWebImage/UIImageView+WebCache.h>

#define Warning                                      @"Warning"
#define WarningPasswordLength                        @"Password should be greater than 6 and less than 40 characters."
#define WarningEmailNotValid                         @"Email address is not valid."

@interface Utilities : NSObject
{

}
@property (readwrite) MBProgressHUD * progressIndicator;
+ (BOOL)validateEmailWithString:(NSString*)email;

+ (BOOL)validateFirstAndLastNameCharsOnly: (NSString *) candidate ;

+ (BOOL) validateFloatValue: (NSString *) candidate;

+ (BOOL) validateZipCode: (NSString *) candidate ;

+ (void)simpleOkAlertBox:(NSString*)title Body:(NSString*)body;

+ (void)createPlist:(NSString*)pListName;

+(NSString*)findPlistPath:(NSString*)PlistName;

+ (void)writeIntoPlist:(NSMutableDictionary*)dataDict and:(NSString *)plistName;

+ (NSMutableDictionary*)readFromPlist:(NSMutableDictionary*)dataDict and:(NSString *)plistName;

+ (NSMutableDictionary *)setplist;

+(UIImage*)getImage:(NSString*)imageName;//Download image from a given URL

+ (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size ;

+ (UIImage*)mergeImage:(UIImage*)first withImage:(UIImage*)second;

+(BOOL)isTall;

+(NSString *)getDeviceVersion;

+(NSString *)getDeviceType;

+ (UIImage*) imageCorrectedForCaptureOrientation:(UIImage*)anImage;

//+ (UIImage *)resizeImage:(UIImage*)image;

+ (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize;

+ (BOOL)connected;

+(UIFont*)setFont:(CGFloat)fontSize;

+(void)resetView:(float)yOrigin myView:(UIView*)myView;

+(NSString*)convertToDegreesLattitude:(double)latitude;
+(NSString*)convertToDegreesLongitude:(double)longitude;

+ (NSString *)encodeString:(NSString *)string;
//+(NSMutableDictionary*)NewDictionaryReplacingNSNullWithEmptyNSString:(NSMutableDictionary * )dict;

+ (NSString *)dateParser:(NSString *)inputString DateFormatter:(NSString *)format;

+(NSMutableDictionary*)NewDictionaryReplacingNSNullWithEmptyNSStringMutable:(NSMutableDictionary * )dict;

+(NSDictionary*)NewDictionaryReplacingNSNullWithEmptyNSString:(NSDictionary * )dict;

+(NSMutableDictionary*)NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:(NSMutableDictionary * )dict;

+ (void)showAlertForNoInternetConnectionAvailable;

+ (void) showHudOnView:(id)onView HUDObj:(MBProgressHUD*)hud labelText:(NSString*)labelText detailLabelText:(NSString*)detailsLabelText dimBackGround:(BOOL)value;

+ (void)hudWasHidden:(MBProgressHUD *)hud ;

+ (NSString *)removingXMLEnvelope:(NSString *)responseString;

+ (NSString *)addingArrays:(NSMutableArray *)ary;

+ (NSString *)addingArraysForMultiSelection:(NSMutableArray *)ary Key:(NSString *)jKey;

+ (NSString *)stringFromTextField:(UIView *)myView MyTag:(int)myTag;

+ (NSString *)stringFromTextView:(UIView *)myView MyTag:(int)myTag;

+ (NSString *)stringFromButton:(UIView *)myView MyTag:(int)myTag;

+ (NSString *)stringFromLable:(UIView *)myView MyTag:(int)myTag;

+(NSString *) getDatabasePath;


@end
