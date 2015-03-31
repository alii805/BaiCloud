//
//  LocationManager.m
//  True Vampire
//
//  Created by Bilal Jawwad on 1/24/13.
//  Copyright (c) 2013 SD Sol. All rights reserved.
//

#import "LocationManager.h"


@interface LocationManager()
{
    CLLocationManager *locationM;
}

@end

@implementation LocationManager

@synthesize latitude = _latitude;
@synthesize longitude = _longitude;

static LocationManager *sharedLocation = nil;    // static instance variable


-(NSString *)latitude{

    if (_latitude == nil) {
        _latitude = @"0.0";
    }

    return _latitude;
}

-(NSString *)longitude{
    
    if (_longitude == nil) {
        _longitude = @"0.0";
    }
    
    return _longitude;
}

+ (LocationManager *)sharedInstance {
    if (sharedLocation == nil) {
        sharedLocation = [[super alloc] init];
    }
    return sharedLocation;
}

- (id)init
{
    self = [super init];
    if (self) {
        locationM = [[CLLocationManager alloc]init];
        locationM.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return  self;
}

#pragma mark - Class Methods

- (void)locationWithDelegate:(id)delegateObject
{
    if([Utilities connected])
    {
        locationM.delegate = delegateObject;
        [locationM startUpdatingLocation];
    }
    else
    {
        [Utilities simpleOkAlertBox:avTitleError Body:avMsgInternetConnectionNotAvaliable];
    }
    
    
}

#pragma  mark - Location Delegate Methods

//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation 
{
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    
    if (locationAge > 5.0) return;
    
    // test that the horizontal accuracy does not indicate an invalid measurement
    if (newLocation.horizontalAccuracy < 0) return;

    
    CLLocation *location  = newLocation;//[locations lastObject];
    
    [locationM stopUpdatingLocation];
    
    if (location)
    {   
        NSString *latitudeStr = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
        NSString *longitudeStr = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
        self.latitude = latitudeStr;
        self.longitude = longitudeStr;
        
//        [[Singleton sharedInstance].userSignUpInfo setValue:latitudeStr forKey:@"userLatitude"];
//        [[Singleton sharedInstance].userSignUpInfo setValue:longitudeStr forKey:@"userLongitude"];
        
       // NSLog(@"latitude:%@", [[Singleton sharedInstance].userSignUpInfo objectForKey:@"userLatitude"]);
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
//    NSLog(@"%@", error);
    [Utilities simpleOkAlertBox:@"Error in location" Body:@"Got Error"];
    self.latitude = [NSString stringWithFormat:@"0"];
    self.longitude = [NSString stringWithFormat:@"0"];
    
}
#pragma end



@end
