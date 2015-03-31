//
//  FormDTO.h
//  ByCloudForms
//
//  Created by Fahad Arshad on 7/5/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormDTO : NSObject
{
    NSString *formID;
    NSString *formTitle;
    NSString *json;
    NSString *formCounter;
}

@property (nonatomic, copy) NSString *formID;
@property (nonatomic, copy) NSString *formTitle;
@property (nonatomic, copy) NSString *json;
@property (nonatomic, copy) NSString *formCounter;

@end
