//
//  Singleton.m
//  True Vampire
//
//  Created by Bilal Jawwad on 1/17/13.
//  Copyright (c) 2013 SD Sol. All rights reserved.
//

#import "Singleton.h"


@interface Singleton () {
    
}


@end

@implementation Singleton
@synthesize moveToScreen;
@synthesize aryTableList;
@synthesize aryTEableList;
@synthesize dictImageContainer;
@synthesize dictMultiSelectedStrings;
@synthesize dictSingleSelectedIDs;
@synthesize dictAudio;
@synthesize aryFields;
@synthesize dictSingnContainer;
@synthesize dictLocal;
@synthesize dictMainForFields;
@synthesize aryMainForFields;
@synthesize dictSendMainForFields;
@synthesize entity_id;
@synthesize dictAudioID,dictSingnContainerID,dictImageContainerID;

static Singleton *sharedObject = nil;

+ (Singleton *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[Singleton alloc] init];
    });
    return sharedObject;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        //[self allocController];
        
        moveToScreen = @"";
        entity_id = @"";
        self.dictImageContainer = [[NSMutableDictionary alloc]init];
        dictImageContainerID = [[NSMutableDictionary alloc]init];
        dictMultiSelectedStrings = [[NSMutableDictionary alloc]init];
        dictSingleSelectedIDs = [[NSMutableDictionary alloc]init];
        dictSingnContainer = [[NSMutableDictionary alloc]init];
        dictSingnContainerID = [[NSMutableDictionary alloc]init];
        dictAudio = [[NSMutableDictionary alloc]init];
        dictAudioID = [[NSMutableDictionary alloc]init];
        aryFields = [[NSMutableArray alloc]init];
        aryMainForFields = [[NSMutableArray alloc]init];
        self.aryTableList = [[NSMutableArray alloc]init];
        dictLocal = [[NSMutableDictionary alloc]init];
        dictMainForFields = [[NSMutableDictionary alloc]init];
        dictSendMainForFields = [[NSMutableDictionary alloc]init];
        self.aryTEableList = [[NSMutableArray alloc]init];
    }
    return self;
}



@end
