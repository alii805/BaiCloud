//
//  Singleton.h
//  True Vampire
//
//  Created by Bilal Jawwad on 1/17/13.
//  Copyright (c) 2013 SD Sol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>


@interface UserInfo : NSObject
{
    NSMutableDictionary *dictImageContainer;
    NSString *companyID;
    NSString *companyType;
    NSString *companyName;
    NSString *groupID;
    NSString *groupName;
    NSString *userID;
    NSString *userName;
}
@property (nonatomic, strong) NSString *companyID;
@property (nonatomic, strong) NSString *companyType;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *groupID;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userName;

+ (UserInfo *)sharedInstance;
- (id)init;


@end
