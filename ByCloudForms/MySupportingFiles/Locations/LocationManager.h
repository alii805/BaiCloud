//
//  LocationManager.h
//  True Vampire
//
//  Created by Bilal Jawwad on 1/24/13.
//  Copyright (c) 2013 SD Sol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Utilities.h"

@interface LocationManager : NSObject <CLLocationManagerDelegate>
{
    
}

@property (nonatomic, strong) NSString *latitude;
@property (nonatomic ,strong) NSString *longitude;

- (void)locationWithDelegate:(id)delegateObject;

+ (LocationManager *)sharedInstance;

@end
