//
//  Singleton.m
//  True Vampire
//
//  Created by Bilal Jawwad on 1/17/13.
//  Copyright (c) 2013 SD Sol. All rights reserved.
//

#import "UserInfo.h"


@interface UserInfo () {
    
}

@end

@implementation UserInfo
@synthesize companyID,companyType,companyName,groupID,groupName,userID,userName;

static UserInfo *sharedObjectUserInfo = nil;

+ (UserInfo *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObjectUserInfo = [[UserInfo alloc] init];
    });
    return sharedObjectUserInfo;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        //[self allocController];
        companyID = @"";
        companyType = @"";
        companyName = @"";
        groupID = @"";
        groupName = @"";
        userID = @"";
        userName = @"";
    }
    return self;
}



@end
