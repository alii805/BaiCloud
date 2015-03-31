//
//  LocalEFormData.h
//  ByCloudForms
//
//  Created by Mac102 on 11/27/14.
//  Copyright (c) 2014 LobiaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalEFormData : NSObject
{
    NSString *formID;
    NSString *json;
    NSString *formKey;
}
@property (nonatomic, copy) NSString *formID;
@property (nonatomic, copy) NSString *json;
@property (nonatomic, copy) NSString *formKey;

@end
