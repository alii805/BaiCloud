//
//  FormsListDTO.h
//  ByCloudForms
//
//  Created by Fahad Arshad on 6/21/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormsListDTO : NSObject
{
 	NSString *description;
    NSString *formID;
    NSString *title;
    NSString *counter;
    NSString *formKey;


}

@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *formID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *counter;
@property (nonatomic, copy) NSString *formKey;


@end
