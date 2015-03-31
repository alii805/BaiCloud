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


@interface Singleton : NSObject
{
    NSMutableDictionary *dictImageContainer;
    NSMutableDictionary *dictImageContainerID;
    
    NSMutableDictionary *dictMultiSelectedStrings;
    NSMutableDictionary *dictMultiSelectedIDs;
    NSMutableDictionary *dictSingleSelectedIDs;
    NSMutableDictionary *dictAudio;
    NSMutableDictionary *dictAudioID;
    NSString *moveToScreen;
    NSMutableArray *aryTableList;
    NSMutableArray *aryETableList;
    NSMutableArray *aryFields;
    NSMutableDictionary *dictSingnContainer;
    NSMutableDictionary *dictSingnContainerID;
    NSMutableDictionary *dictLocal;
    NSMutableDictionary *dictMainForFields;
    NSMutableArray *aryMainForFields;
    NSMutableDictionary *dictSendMainForFields;
    NSString *entity_id;
}

@property (nonatomic, strong) NSString *moveToScreen;
@property (nonatomic, strong) NSString *entity_id;
@property (strong, nonatomic) NSMutableDictionary *dictImageContainer;
@property (strong, nonatomic) NSMutableDictionary *dictImageContainerID;
@property (strong, nonatomic) NSMutableDictionary *dictMultiSelectedStrings;
@property (strong, nonatomic) NSMutableDictionary *dictSingleSelectedIDs;
@property (strong, nonatomic) NSMutableDictionary *dictAudio;
@property (strong, nonatomic) NSMutableDictionary *dictAudioID;
@property (strong, nonatomic) NSMutableDictionary *dictSingnContainer;
@property (strong, nonatomic) NSMutableDictionary *dictSingnContainerID;
@property (strong, nonatomic) NSMutableArray *aryTableList;
@property (strong, nonatomic) NSMutableArray *aryTEableList;
@property (strong, nonatomic) NSMutableArray *aryFields;
@property (strong, nonatomic) NSMutableDictionary *dictLocal;
@property (strong, nonatomic) NSMutableDictionary *dictMainForFields;
@property (strong, nonatomic) NSMutableDictionary *dictSendMainForFields;
@property (strong, nonatomic) NSMutableArray *aryMainForFields;
+ (Singleton *)sharedInstance;
- (id)init;


@end
