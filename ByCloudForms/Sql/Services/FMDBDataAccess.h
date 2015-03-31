//
//  FMDBDataAccess.h
//  Chanda
//
//  Created by Mohammad Azam on 10/25/11.
//  Copyright (c) 2011 HighOnCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h" 
#import "FMResultSet.h" 
#import "Utilities.h"
#import "UserInfo.h"
#import "LocalFormDataDTO.h"
#import "FormDTO.h"
#import "EForm.h"
#import "LocalEFormData.h"

@interface FMDBDataAccess : NSObject
{
    
}
//SaveFormData
-(BOOL) insertIntoSaveFormData:(LocalFormDataDTO *) localFormDataObj;
-(LocalFormDataDTO *) getSaveFormData : (NSString*)formID;
-(BOOL) updateSaveFormData:(LocalFormDataDTO *) localFormDataObj;
-(BOOL) deleteSaveFormData : (NSString*)formID;

//SaveForm
-(BOOL) insertForm:(FormDTO *) localFormDataObj;
-(FormDTO *) getForm : (NSString*)formID;
-(BOOL) updateForm:(FormDTO *) localFormDataObj;
-(BOOL) deleteForm : (NSString*)formID;


//eSaveFormData
-(BOOL)insertIntoESaveFormData:(LocalEFormData *)localEFormDataObj;
-(LocalEFormData *)getESaveFormData:(NSString * )formID;
-(BOOL)updateESaveFormData:(LocalEFormData *)localEFormDataObj;
-(BOOL)deleteESaveFormData:(NSString *)formID key:(NSString *)formKey;


//SaveEForm

-(BOOL)insertEFrom:(EForm *)localEFormDataobj;
-(NSMutableArray *)getEForm:(NSString *)formID;
-(BOOL)updateEForm:(EForm *)localEFormDataobj;
-(BOOL)deteEForm:(NSString *)formID key:(NSString *)formKey;




//InBite==========================
//-(BOOL) InsertInBite:(InBiteDTO *) inbiteObj;
//-(BOOL) UpdateInBite:(InBiteDTO *) inbiteObj;
//-(NSMutableArray *) getInBite;
//-(BOOL) deleteInBite;
//InBite--------------------------

@end
