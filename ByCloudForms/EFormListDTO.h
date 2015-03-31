//
//  EFormListDTO.h
//  ByCloudForms
//
//  Created by Mac102 on 12/2/14.
//  Copyright (c) 2014 LobiaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EFormListDTO : NSObject

{
 	NSString *description;
    NSString *formID;
    NSString *title;
    NSString *counter;
}
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *formID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *counter;


@end
