//
//  LocalFormDataDTO.h
//  ByCloudForms
//
//  Created by Fahad Arshad on 7/4/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalFormDataDTO : NSObject
{
    NSString *formID;
    NSString *json;
}
@property (nonatomic, copy) NSString *formID;
@property (nonatomic, copy) NSString *json;

@end
