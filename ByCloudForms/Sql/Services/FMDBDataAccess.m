//
//  FMDBDataAccess.m
//  Chanda
//
//  Created by Mohammad Azam on 10/25/11.
//  Copyright (c) 2011 HighOnCoding. All rights reserved.
//

#import "FMDBDataAccess.h"

@implementation FMDBDataAccess



//SaveFormData
-(BOOL) insertIntoSaveFormData:(LocalFormDataDTO *) localFormDataObj
{
    BOOL success;
    if ([self getSaveFormData:localFormDataObj.formID].formID)
    {
        success = [self updateSaveFormData:localFormDataObj];
        return success;
    }
    FMDatabase *db = [FMDatabase databaseWithPath:[Utilities getDatabasePath]];
    [db open];

    NSString *query = [NSString stringWithFormat:@"INSERT INTO saveFormData (formID,formJSon)   VALUES ('%@', '%@')",
                       localFormDataObj.formID,
                       localFormDataObj.json
                       ];
//    NSLog(@"%@",query);
    
    success = [db executeUpdate:query];
    
    [db close];
    
    return success;
}
-(LocalFormDataDTO *) getSaveFormData : (NSString*)formID
{

    FMDatabase *db = [FMDatabase databaseWithPath:[Utilities getDatabasePath]];
    
    [db open];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM saveFormData Where formID = %@",formID];
 
    FMResultSet *results = [db executeQuery:query];
    LocalFormDataDTO *localFormDataObj;
    while([results next])
    {
        localFormDataObj = [[LocalFormDataDTO alloc] init];
        localFormDataObj.formID = [results stringForColumn:@"formID"];
        localFormDataObj.json = [results stringForColumn:@"formJSon"];
    }
    
    [db close];
    
    return localFormDataObj;
}

-(BOOL) updateSaveFormData:(LocalFormDataDTO *) localFormDataObj
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Utilities getDatabasePath]];
    
    [db open];
    NSString *query = [NSString stringWithFormat:@"UPDATE saveFormData SET formID = '%@',formJSon = '%@' WHERE formID = '%@'",
                       localFormDataObj.formID,
                       localFormDataObj.json,
                       localFormDataObj.formID
                       ];
    BOOL success = [db executeUpdate:query];
    
    [db close];
    
    return success;
}
-(BOOL) deleteSaveFormData : (NSString*)formID
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Utilities getDatabasePath]];
    [db open];
    NSString *query = [NSString stringWithFormat:@"DELETE FROM saveFormData WHERE formID = %@",formID];
//    NSString *query = [NSString stringWithFormat:@"DELETE FROM saveFormData "];
    BOOL success = [db executeUpdate:query];
    
    [db close];
    return success;
}

//Form
-(BOOL) insertForm:(FormDTO *) formObj
{
    BOOL success;
    if ([self getForm:formObj.formID].formID)
    {
        success = [self updateForm:formObj];
        return success;
    }
    FMDatabase *db = [FMDatabase databaseWithPath:[Utilities getDatabasePath]];
    [db open];
    
    NSString *query = [NSString stringWithFormat:@"INSERT INTO form (formID,formJSon,fromTitle,formCounter)   VALUES ('%@', '%@', '%@', '%@')",
                       formObj.formID,
                       formObj.json,
                       formObj.formTitle,
                       formObj.formCounter
                       ];
//    NSLog(@"%@",query);
    
    success = [db executeUpdate:query];
    
    [db close];
    
    return success;
}
-(FormDTO *) getForm : (NSString*)formID
{
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utilities getDatabasePath]];
    
    [db open];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM form Where formID = %@",formID];
    
    FMResultSet *results = [db executeQuery:query];
    FormDTO *formObj;
    while([results next])
    {
        formObj = [[FormDTO alloc] init];
        formObj.formID = [results stringForColumn:@"formID"];
        formObj.json = [results stringForColumn:@"formJSon"];
        formObj.formTitle = [results stringForColumn:@"fromTitle"];
        formObj.formCounter = [results stringForColumn:@"formCounter"];
    }
    
    [db close];
    
    return formObj;
}

-(BOOL) updateForm:(FormDTO *) formObj
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Utilities getDatabasePath]];
    
    [db open];
    NSString *query = [NSString stringWithFormat:@"UPDATE form SET formID = '%@',formJSon = '%@' ,fromTitle = '%@' ,formCounter = '%@' WHERE formID = '%@'",
                       formObj.formID,
                       formObj.json,
                       formObj.formTitle,
                       formObj.formCounter,
                       formObj.formID
                       ];
    BOOL success = [db executeUpdate:query];
    
    [db close];
    
    return success;
}
-(BOOL) deleteForm : (NSString*)formID
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Utilities getDatabasePath]];
    [db open];
    NSString *query = [NSString stringWithFormat:@"DELETE FROM form WHERE formID = %@",formID];
    //    NSString *query = [NSString stringWithFormat:@"DELETE FROM saveFormData "];
    BOOL success = [db executeUpdate:query];
    
    [db close];
    return success;
}

//eSaveFormData
-(BOOL)insertIntoESaveFormData:(LocalEFormData *)localEFormDataObj
{
    BOOL success;

    FMDatabase *db = [FMDatabase databaseWithPath:[Utilities getDatabasePath]];
    [db open];
    
    NSString *query = [NSString stringWithFormat:@"INSERT INTO eSaveFormData (formID,formJSon,formKey)   VALUES ('%@', '%@', '%@')",
                       localEFormDataObj.formID,
                       localEFormDataObj.json,
                       localEFormDataObj.formKey
                       ];
    //    NSLog(@"%@",query);
    
    success = [db executeUpdate:query];
    
    [db close];
    
    return success;


}
-(LocalEFormData *)getESaveFormData:(NSString * )formID
{

    FMDatabase *db = [FMDatabase databaseWithPath:[Utilities getDatabasePath]];
    
    [db open];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM eSaveFormData Where formKey = %@",formID];
    
    FMResultSet *results = [db executeQuery:query];
    LocalEFormData *localEFormDataObj;
    while([results next])
    {
        localEFormDataObj = [[LocalEFormData alloc] init];
        localEFormDataObj.formID = [results stringForColumn:@"formID"];
        localEFormDataObj.json = [results stringForColumn:@"formJSon"];
        localEFormDataObj.formKey = [results stringForColumn:@"formKey"];
    }
    
    [db close];
    
    return localEFormDataObj;


}
-(BOOL)updateESaveFormData:(LocalEFormData *)localEFormDataObj
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Utilities getDatabasePath]];
    
    [db open];
    NSString *query = [NSString stringWithFormat:@"UPDATE eSaveFormData SET formID = '%@',formJSon = '%@' WHERE formID = '%@'",
                       localEFormDataObj.formID,
                       localEFormDataObj.json,
                       localEFormDataObj.formID
                       ];
    BOOL success = [db executeUpdate:query];
    
    [db close];
    
    return success;

}
-(BOOL)deleteESaveFormData:(NSString *)formID key:(NSString *)formKey
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Utilities getDatabasePath]];
    [db open];
    NSString *query = [NSString stringWithFormat:@"DELETE FROM eSaveFormData WHERE formKey = %@",formKey];
    //    NSString *query = [NSString stringWithFormat:@"DELETE FROM saveFormData "];
    BOOL success = [db executeUpdate:query];
    
    [db close];
    return success;
}


//SaveEForm

-(BOOL)insertEFrom:(EForm *)eformObj
{

    BOOL success;

    FMDatabase *db = [FMDatabase databaseWithPath:[Utilities getDatabasePath]];
    [db open];
    
    NSString *query = [NSString stringWithFormat:@"INSERT INTO eForm (formID,formJSon,fromTitle,formCounter,formKey)   VALUES ('%@', '%@', '%@', '%@', '%@')",
                       eformObj.formID,
                       eformObj.json,
                       eformObj.formTitle,
                       eformObj.formCounter,
                       eformObj.formKey
                       ];
    //    NSLog(@"%@",query);
    
    success = [db executeUpdate:query];
    
    [db close];
    
    return success;


}
-(NSMutableArray *)getEForm:(NSString *)formID // updated shoaib
{

    FMDatabase *db = [FMDatabase databaseWithPath:[Utilities getDatabasePath]];
    
    [db open];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM eForm"];
    
    FMResultSet *results = [db executeQuery:query];
    NSMutableArray *eSavedForm = [[NSMutableArray alloc] init];
    EForm *eFormObj;
    while([results next])
    {
        eFormObj = [[EForm alloc] init];
        eFormObj.formID = [results stringForColumn:@"formID"];
        eFormObj.json = [results stringForColumn:@"formJSon"];
        eFormObj.formTitle = [results stringForColumn:@"fromTitle"];
        eFormObj.formCounter = [results stringForColumn:@"formCounter"];
        eFormObj.formKey = [results stringForColumn:@"formKey"];
        [eSavedForm addObject:eFormObj];
    }
    
    [db close];
    
    return eSavedForm;


}
-(BOOL)updateEForm:(EForm *)eFormObj
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Utilities getDatabasePath]];
    
    [db open];
    NSString *query = [NSString stringWithFormat:@"UPDATE eForm SET formID = '%@',formJSon = '%@' ,fromTitle = '%@' ,formCounter = '%@' WHERE formID = '%@'",
                       eFormObj.formID,
                       eFormObj.json,
                       eFormObj.formTitle,
                       eFormObj.formCounter,
                       eFormObj.formID
                       ];
    BOOL success = [db executeUpdate:query];
    
    [db close];
    
    return success;


}
-(BOOL)deteEForm:(NSString *)formID key:(NSString *)formKey
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Utilities getDatabasePath]];
    [db open];
    NSString *query = [NSString stringWithFormat:@"DELETE FROM eForm WHERE formKey = %@",formKey];
    //    NSString *query = [NSString stringWithFormat:@"DELETE FROM saveFormData "];
    BOOL success = [db executeUpdate:query];
    
    [db close];
    return success;
}
@end
