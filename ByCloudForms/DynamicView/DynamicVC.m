//
//  DynamicVC.m
//  ByCloudForms
//
//  Created by Fahad Arshad on 6/11/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import "DynamicVC.h"
#import "Singleton.h"
#import "FormsTableVCViewController.h"


@interface DynamicVC ()

@end

@implementation DynamicVC
@synthesize pickerViewController,txtField,txtView,datePickerVC,formID,formTitle,startAddControls,screenName,imagePickerVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad // updated by shoaib
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
//    txtField = [[UITextField alloc] init];
    x = 20;
    y = 20;
    viewHolderSubView.hidden = YES;
    FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
    
    // load data from local DB
    
    if (_isSavedForm) {
        // saved eform
        EForm *form = [[Singleton sharedInstance].aryTableList objectAtIndex:_selectedInd];
        key = [form.formKey integerValue];
        LocalEFormData *localEFormDataObj = [db getESaveFormData:form.formKey];//searching with key
        if (localEFormDataObj.json)
        {
            NSData *data = [localEFormDataObj.json dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error;
            NSMutableDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data //1
                                                                                options:0
                                                                                  error:&error];
            if (responseDict)
            {
                if ([[Singleton sharedInstance].aryFields count]>0)
                {
                    [self AddControllAndData:[Singleton sharedInstance].aryFields DataDictionary:[responseDict valueForKey:jFieldAry]];
                    //                [self readWriteData];
                }
                else
                {
                    [Utilities simpleOkAlertBox:avTitleError Body:@"Form don't have any field."];
                }
                
            }
            
        }
        else
        {
            [self readWriteData];
        }
    }
    else
    {
        // not e saved
        
        if ([[UserInfo sharedInstance].companyType isEqualToString:@"1"]) {
            
            // its etrack case so get but not saved data
            
            [self readWriteData];
        }
        else
        {
            // its google docs so check it data exists
            
            LocalFormDataDTO *localFormDataObj = [db getSaveFormData:formID];
            if (localFormDataObj.json)
            {
                NSData *data = [localFormDataObj.json dataUsingEncoding:NSUTF8StringEncoding];
                NSError *error;
                NSMutableDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data //1
                                                                                    options:0
                                                                                      error:&error];
                if (responseDict)
                {
                    if ([[Singleton sharedInstance].aryFields count]>0)
                    {
                        [self AddControllAndData:[Singleton sharedInstance].aryFields DataDictionary:[responseDict valueForKey:jFieldAry]];
                        //                [self readWriteData];
                    }
                    else
                    {
                        [Utilities simpleOkAlertBox:avTitleError Body:@"Form don't have any field."];
                    }
                    
                }
                
            }
            else
            {
                [self readWriteData];
            }
        }
        
    }
   

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
//    gestureRecognizer.delegate = self;
    [viwHolderScroll addGestureRecognizer:gestureRecognizer];
    
    if (!_isSavedForm && [[UserInfo sharedInstance].companyType isEqualToString:@"1"]) {
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"formKey"]) {
            key = [[NSUserDefaults standardUserDefaults] integerForKey:@"formKey"];
            key ++;
            [[NSUserDefaults standardUserDefaults] setInteger:key forKey:@"formKey"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"formKey"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
//    if ([screenName isEqualToString:@"Next"])
//    {
//        [[Singleton sharedInstance].dictMainForFields removeAllObjects];
//    }
    
    sendIndex = 0;
    sendImageDone = 0;
    sendSignImageDone = 0;
    sendAudioDone = 0;
}
//-(void) hideKeyBoard:(id) sender
-(void) hideKeyBoard
{
    // Do whatever such as hiding the keyboard
    
    UITextField *currentTxtField = (UITextField *)[viwHolderScroll viewWithTag:txtField.tag];
    UITextView *currentTxtView = (UITextView *)[viwHolderScroll viewWithTag:txtView.tag];
//    NSLog(@"%d",txtField.tag);
//    NSLog(@"%d",txtView.tag);
    [currentTxtView resignFirstResponder];
    [currentTxtField resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//#pragma mark Call Api for Form
//-(void)sendFormByIdRequest
//{
//    myHud = [[MBProgressHUD alloc] init];
//    [Utilities showHudOnView:self.view HUDObj:myHud labelText:hudHead detailLabelText:hudDetail dimBackGround:YES];
//    
//    if([Utilities connected])
//    {
//        if ([[UserInfo sharedInstance].userID length] > 0)
//        {
//            NSArray *data = [[NSArray alloc] initWithObjects:[UserInfo sharedInstance].userID, formID,nil];
//            NSArray  *keys = [[NSArray alloc] initWithObjects:@"user_id",@"form_id", nil];
//            
//            [[sendRequests sharedInstance] sendRequestWithUrl:data Keys:keys MyURL:[NSString stringWithFormat:@"%@%@",liveBaseUrl , FormsByIdUrl]delegate:self requestCompleteHandler:@selector(formByIdComplete:)requestFailHandler:@selector(formByIdRequestFailed:)];
//        }
//        else
//        {
//        }
//    }
//    else
//    {
////        NSString* finalPath = [[NSBundle mainBundle] pathForResource:@"FormListPList" ofType:@"plist"];
////        NSMutableDictionary *dict =[[NSMutableDictionary alloc] init];
////        NSMutableDictionary *data =[[NSMutableDictionary alloc] init];
////        dict =  [NSDictionary dictionaryWithContentsOfFile:finalPath];
////        dict = [Utilities readFromPlist:nil and:@"FormListPList"];
////        NSLog(@"%@",dict);
////        if (dict)
////        {
////            data = [[NSMutableDictionary alloc] init];
////            data = [dict valueForKey:@"dataArray" ];
////            [self readWriteData:data];
////        }
//    }
//    
//    
//    
//    
//}
//-(void)formByIdComplete:(NSMutableDictionary *)data
//{
//    [self readWriteData:data];
//}
//-(void)formByIdRequestFailed:(NSError*)error
//{
//    [Utilities hudWasHidden:myHud];
//    NSLog(@"login fail due to: %@", [error localizedDescription]);
//    NSLog(@"login fail due to: %d",[error code]);
//    if ([error code] == 400)
//    {
//        NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:[error userInfo]];
//        NSLog(@"%@",[dict valueForKey:@"error"]);
//        NSString *msg = [dict valueForKey:@"error"];
//        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alertView show];
//    }
//    else
//    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alertView show];
//    }
//}
//-(void)readWriteData:(NSMutableDictionary *)data
//{
//  
//    if([[data   valueForKey:jStatus] isEqualToString:jFailure])
//    {
//        [Utilities hudWasHidden:myHud];
//        [Utilities simpleOkAlertBox:avTitleError Body:[data valueForKey:@"error"]];
//    }
//    else if([[data   valueForKey:jStatus] isEqualToString:jSuccess])
//    {
//        [Utilities hudWasHidden:myHud];
//        if ([data valueForKey:jFormData])
//        {
//            [Singleton sharedInstance].aryFields = [[NSMutableArray alloc] initWithArray:[[data valueForKey:jFormData] valueForKey:jFields]];
//            if ([[Singleton sharedInstance].aryFields count]>0)
//            {
//                [self AddControlls:[Singleton sharedInstance].aryFields];
//            }
//        }
//        
//        
//        
//        //saving in Plist
////        [Utilities createPlist:FormListPList];
////        [Utilities writeIntoPlist:data and:FormListPList];
////        NSString* finalPath = [[NSBundle mainBundle] pathForResource:FormListPList ofType:PListExt];
////        NSDictionary *dict =[[NSDictionary alloc] init];
////        dict =  [NSDictionary dictionaryWithContentsOfFile:finalPath];
////        dict = [Utilities readFromPlist:nil and:FormListPList];
////        NSLog(@"%@",dict);
////        if (dict)
////        {
////            data = [[NSMutableDictionary alloc] init];
////            data = [dict valueForKey:jDataArray ];
////        }
////        [[Singleton sharedInstance].aryTableList removeAllObjects];
//        //        [Singleton sharedInstance].aryTableList = [[NSMutableArray alloc]init];
////        for (int i = 0; i < [[data valueForKey:jForms] count]; i++)
////        {
////            FormsListDTO *formsListObj = [[FormsListDTO alloc] init];
////            formsListObj.formID = [[[data valueForKey:jForms] objectAtIndex:i] valueForKey:jID];
////            formsListObj.description = [[[data valueForKey:jForms] objectAtIndex:i] valueForKey:jDescription];
////            formsListObj.title = [[[data valueForKey:jForms] objectAtIndex:i] valueForKey:jTitle];
////            [[Singleton sharedInstance].aryTableList addObject:formsListObj];
////            
////        }
////        FormsListDTO *formsListObj = [[Singleton sharedInstance].aryTableList objectAtIndex:1];
////        NSLog(@"%@",formsListObj.description);
////        [tblFormsView reloadData];
//        
//        //        NSUserDefaults *sessionID = [NSUserDefaults standardUserDefaults];
//        //        [sessionID setValue:[[data   valueForKey:@"userInfo"] valueForKey:@"session_id"] forKey:sessionIDKey];
//        //        model = [ModelLocator getInstance];
//        //        model.signinObj = [[SigninVO alloc] init];
//        //        model.signinObj.sessionId = [[data   valueForKey:@"userInfo"] valueForKey:@"session_id"];
//        //        NSLog(@"%@",model.signinObj.sessionId);
//        
//        //        NSLog(@"%@",model.signinObj.sessionId);
//        //        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        //        HomeController *homeController = [[HomeController alloc] initWithNibName:@"HomeController" bundle:nil];
//        //        [self.navigationController pushViewController:homeController animated:YES];
//        //        [defaults setValue:swNo forKey:leftViewApiCall];
//        //        if ([[defaults valueForKey:nsCategory] isEqualToString:nsCategoryALL])
//        //        {
//        //            HomeController *homeController = [[HomeController alloc] initWithNibName:@"HomeController" bundle:nil];
//        //            [self.navigationController pushViewController:homeController animated:YES];
//        //        }
//        //        else
//        //        {
//        //            HomeControllerWithoutMap *homeControllerWithoutMap = [[HomeControllerWithoutMap alloc] initWithNibName:@"HomeControllerWithoutMap" bundle:nil];
//        //            [self.navigationController pushViewController:homeControllerWithoutMap animated:YES];
//        //        }
//    }
//    
//}
-(void)readWriteData
{
    if ([[Singleton sharedInstance].aryFields count]>0)
    {
        [self AddControlls:[Singleton sharedInstance].aryFields];
    }
    else
    {
        [Utilities simpleOkAlertBox:avTitleError Body:@"Form don't have any field."];
    }
}
#pragma mark AddControlls
-(void)AddControlls:(NSArray*)aryFieldsData
{
//    [[aryFields objectAtIndex:1] valueForKey:jChoices];
//    [[aryFields objectAtIndex:1] valueForKey:jInstructions];
//    [[aryFields objectAtIndex:1] valueForKey:jIs_randomized];
//    [[aryFields objectAtIndex:1] valueForKey:jIs_required];
//    [[aryFields objectAtIndex:1] valueForKey:jTitle];
//    [[aryFields objectAtIndex:1] valueForKey:jType];
    //===========
//    [self AddButton:i Title:[NSString stringWithFormat:@"Button %d",i]];
//    [self AddLable:i Title:[NSString stringWithFormat:@"Button %d",i]];
//    [self AddTextFields:i Title:[NSString stringWithFormat:@"Button %d",i]];
//    [self AddPickerButton:i Title:[NSString stringWithFormat:@"Button %d",i]];
//    [self AddMultiSelectionButton:i Title:[NSString stringWithFormat:@"Button %d",i]];
//    falgDate0Time1 = 0;
//    [self AddDatePickerButton:i Title:[NSString stringWithFormat:@"Button %d",i]];
//    [self AddTextView:i Title:[NSString stringWithFormat:@"Button %d",i]];
//    [self AddImageButtons:i Title:[NSString stringWithFormat:@"Button %d",i]];

    //===========
//    NSLog(@"count = %d",[aryFields count]);
    for (int j = startAddControls; j< [[Singleton sharedInstance].aryFields count];j++ )
    {
        int i = j+1;
        if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jText])//text
        {
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//                [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeDefault];
//            }
//            else
//            {
//                [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeDefault];
//            }
            [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeDefault];
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jNumber])//number
        {
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//                [self AddTextFields:i Title:[NSString stringWithFormat:@"* %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeNumberPad];
//            }
//            else
//            {
//                [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeNumberPad];
//            }
            [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeNumberPad];
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jTextArea])//textarea
        {
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//                [self AddTextView:i Title:[NSString stringWithFormat:@"* %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeDefault];
//            }
//            else
//            {
//                [self AddTextView:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeDefault];
//            }
            [self AddTextView:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeDefault];
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jCheckbox])//checkbox
        {
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//                [self AddMultiSelectionButton:i Title:[NSString stringWithFormat:@"* %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
//            }
//            else
//            {
//                [self AddMultiSelectionButton:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
//            }
            [self AddMultiSelectionButton:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jRadio])//radio
        {
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//                [self AddPickerButton:i Title:[NSString stringWithFormat:@"* %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
//            }
//            else
//            {
//                [self AddPickerButton:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
//            }
            [self AddPickerButton:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jSelect])//select
        {
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//                [self AddMultiSelectionButton:i Title:[NSString stringWithFormat:@"* %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
//            }
//            else
//            {
//                [self AddMultiSelectionButton:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
//            }
            [self AddPickerButton:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jSection])//Section
        {
            [self AddSectionLable:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//            }
//            else
//            {
//            }
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jPage])//Page Break
        {
            indBreak = j+1;
            [self AddNextButton:20000 Title:@"Next"];
            return;
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//            }
//            else
//            {
//            }
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jShortname])//shortname
        {
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//                [self AddTextFields:i Title:[NSString stringWithFormat:@"* %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeNamePhonePad];
//            }
//            else
//            {
//                [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeNamePhonePad];
//            }
            [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeNamePhonePad];
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jSignature])//Sign
        {
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//                [self AddSignatureButtons:i Title:[NSString stringWithFormat:@"* %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
//            }
//            else
//            {
//                [self AddSignatureButtons:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
//                
//            }
            [self AddSignatureButtons:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jImage])//Image
        {
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//                [self AddImageButtons:i Title:[NSString stringWithFormat:@"* %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
//            }
//            else
//            {
//                [self AddImageButtons:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
//                
//            }
            [self AddImageButtons:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jAudio])//Audio
        {
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//                [self AddAudioButtons:i Title:[NSString stringWithFormat:@"* %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
////                [self AddAudioButtons:i Title:@"* Audio"];
//            }
//            else
//            {
//                [self AddAudioButtons:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
////                [self AddAudioButtons:i Title:@"Audio"];
//            }
            [self AddAudioButtons:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
        
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jAddress])//address
        {
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//                [self AddTextFields:i Title:[NSString stringWithFormat:@"* %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeDefault];
//            }
//            else
//            {
//                [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeDefault];
//            }
//            [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeDefault];
            [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeDefault];
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jDate])//date
        {
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//                falgDate0Time1 = 0;
//                [self AddDatePickerButton:i Title:[NSString stringWithFormat:@"* %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
//            }
//            else
//            {
//                falgDate0Time1 = 0;
//                [self AddDatePickerButton:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
//            }
            falgDate0Time1 = 0;
            [self AddDatePickerButton:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
        
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jEmail])//email
        {
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//                [self AddTextFields:i Title:[NSString stringWithFormat:@"* %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeEmailAddress];
//            }
//            else
//            {
//                [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeEmailAddress];
//            }
            [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeEmailAddress];
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jTime])//time
        {
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//                falgDate0Time1 = 1;
//                [self AddDatePickerButton:i Title:[NSString stringWithFormat:@"* %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
//            }
//            else
//            {
//                falgDate0Time1 = 1;
//                [self AddDatePickerButton:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
//            }
            falgDate0Time1 = 1;
            [self AddDatePickerButton:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
            

        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jPhone])//phone
        {
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//                [self AddTextFields:i Title:[NSString stringWithFormat:@"* %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypePhonePad];
//            }
//            else
//            {
//                [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypePhonePad];
//            }
            [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypePhonePad];
//            NSLog(@"phone index = %d",i);
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jURL])//url
        {
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//                [self AddTextFields:i Title:[NSString stringWithFormat:@"* %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeTypeURL];
//            }
//            else
//            {
//                [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeTypeURL];
//            }
            [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeTypeURL];
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jMoney])//money
        {
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//                [self AddTextFields:i Title:[NSString stringWithFormat:@"* %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeNumberPad];
//            }
//            else
//            {
//                [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeNumberPad];
//            }
            [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeNumberPad];
        
        }
//        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:i] valueForKey:jType] isEqualToString:jText])
//        {
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//            }
//            else
//            {
//            }
//        }
    }
//    [self AddNextButton:20000 Title:@"Next"];
    [self AddMenuButtons:10000 Title:@"Menu"];
    
}

-(void)AddControllAndData:(NSArray*)aryFieldsData DataDictionary:(NSMutableDictionary*)fDataDict
{
    for (int j = startAddControls; j< [[Singleton sharedInstance].aryFields count];j++ )
    {
        int i = j+1;
//        NSLog(@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType]);
        
        if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jText])//Text
        {
            [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeDefault];
            if ([fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]])
            {
                [self setDataInTextField:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData] Tag:j];
            }
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jNumber])//Number
        {
            [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeNumberPad];
            if ([fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]])
            {
                 [self setDataInTextField:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData] Tag:j];
            }
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jTextArea])//TextView
        {
            [self AddTextView:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeDefault];
            if ([fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]])
            {
                 [self setDataInTextView:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData] Tag:j];
            }
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jCheckbox])//Multi
        {
            [self AddMultiSelectionButton:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
            if ([fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]])
            {
                
                [[Singleton sharedInstance].dictMultiSelectedStrings setObject:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jSelectedChoices] forKey:[NSString stringWithFormat:@"%d",j]];
            }
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jRadio])//Single - Radio
        {
            [self AddPickerButton:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
            if ([fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]])
            {
                [self setDataInButton:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData] Tag:j];
                 [[Singleton sharedInstance].dictSingleSelectedIDs setObject:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jSelectedChoices] forKey:[NSString stringWithFormat:@"%d",j]];
            }
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jSelect])//Single - Select
        {
            [self AddPickerButton:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
            if ([fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]])
            {
                [self setDataInButton:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData] Tag:j];
                [[Singleton sharedInstance].dictSingleSelectedIDs setObject:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jSelectedChoices] forKey:[NSString stringWithFormat:@"%d",j]];
            }
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jSection])//Section --DB
        {
            [self AddSectionLable:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
//            if ([fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]])
//            {
//                [self setDataInTextField:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData] Tag:j];
//            }

        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jPage])//Page Break
        {
            indBreak = j+1;
            [self AddNextButton:20000 Title:@"Next"];
            return;
//            if ([fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]])
//            {
//                [self setDataInTextField:[[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID] valueForKey:jFieldData] Tag:j];
//            }
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jShortname])//shortname
        {
            [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeNamePhonePad];
            if ([fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]])
            {
                [self setDataInTextField:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData] Tag:j];
            }
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jImage])//image --DB
        {
//            [self AddImageButtons:i Title:[NSString stringWithFormat:@"%@",[[aryFields objectAtIndex:j] valueForKey:jTitle]]];
            [self AddImageButtons:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
            if ([fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]])
            {
                [[Singleton sharedInstance].dictImageContainer setObject:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData] forKey:[NSString stringWithFormat:@"%d",j]];
//                NSLog(@"layyyyy = %@",[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jID]);
                [[Singleton sharedInstance].dictImageContainerID setObject:[NSString stringWithFormat:@"%@",[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jID]] forKey:[NSString stringWithFormat:@"%@",[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData]]];
//                NSLog(@"");
            }
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jSignature])//Signature --DB
        {
             [self AddSignatureButtons:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
            if ([fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]])
            {
                [[Singleton sharedInstance].dictSingnContainer setObject:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData] forKey:[NSString stringWithFormat:@"%d",j]];
                [[Singleton sharedInstance].dictSingnContainerID setObject:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jID] forKey:[NSString stringWithFormat:@"%@",[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData]]];
            }
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jAudio])//Audio
        {
            [self AddAudioButtons:i Title:@"Audio"];
            if ([fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]])
            {
                [[Singleton sharedInstance].dictAudio setObject:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData] forKey:[NSString stringWithFormat:@"%d",j]];
                [[Singleton sharedInstance].dictAudioID setObject:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jID] forKey:[NSString stringWithFormat:@"%@",[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData]]];
            }
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jAddress])//Address
        {
            [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeDefault];
            if ([fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]])
            {
                 [self setDataInTextField:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData] Tag:j];
            }
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jDate])//Date
        {
            falgDate0Time1 = 0;
            [self AddDatePickerButton:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
            if ([fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]])
            {
                if ([[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData] isEqualToString:@""])
                {
                    [self setDataInButton:@"Set Date" Tag:j];
                }
                else
                {
                    [self setDataInButton:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData] Tag:j];
                }
                 
            }
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jEmail])//Email
        {
            [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeEmailAddress];
            if ([fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]])
            {
                 [self setDataInTextField:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData] Tag:j];
            }
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jTime])//Time
        {
            falgDate0Time1 = 1;
            [self AddDatePickerButton:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]]];
            if ([fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]])
            {
                if ([[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData] isEqualToString:@""])
                {
                    [self setDataInButton:@"Set Time" Tag:j];
                }
                else
                {
                    [self setDataInButton:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData] Tag:j];
                }
                
            }
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jPhone])//Phone
        {
            [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypePhonePad];
            if ([fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]])
            {
                 [self setDataInTextField:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData] Tag:j];
            }
            //            NSLog(@"phone index = %d",i);
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jURL])//URL
        {
            [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeTypeURL];
            if ([fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]])
            {
                 [self setDataInTextField:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData] Tag:j];
            }
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jMoney])//Money
        {
            [self AddTextFields:i Title:[NSString stringWithFormat:@"%@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle]] KeyBoardType:kbTypeNumberPad];
            if ([fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]])
            {
                 [self setDataInTextField:[[fDataDict valueForKey:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]] valueForKey:jFieldData] Tag:j];
            }
        }
//        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:i] valueForKey:jType] isEqualToString:jText])
//        {
//            
//        }
    }
    [self AddMenuButtons:10000 Title:@"Menu"];
    
}
-(void)setDataInTextField:(NSString*)str Tag:(int)myTagg
{
    UITextField *currentTxtField = (UITextField *)[self.view viewWithTag:myTagg+1];
    currentTxtField.text = str;
}
-(void)setDataInTextView:(NSString*)str Tag:(int)myTagg
{
    UITextView *currentTxtView = (UITextView *)[self.view viewWithTag:myTagg+1];
    currentTxtView.text = str;
}
-(void)setDataInButton:(NSString*)str Tag:(int)myTagg
{
    UIButton *currentBtn = (UIButton *)[self.view viewWithTag:myTagg+1];
    [currentBtn setTitle:[NSString stringWithFormat:@"   %@",str] forState:UIControlStateNormal];
}
-(void)setDataInForImage:(NSMutableDictionary*)iDict Tag:(int)myTagg
{
    
}
-(void)setDataInForAudio:(NSMutableDictionary*)aDict Tag:(int)myTagg
{
    
}

#pragma mark - Add Text View
-(void)AddTextView:(int)tag Title:(NSString*)txtTitle KeyBoardType:(int)kbType
{

    if ([[[[Singleton sharedInstance].aryFields objectAtIndex:tag-1] valueForKey:jIs_required] boolValue])
    {
        [self AddLable:tag Title:[NSString stringWithFormat:@"* %@",txtTitle]];
    }
    else
    {
        [self AddLable:tag Title:txtTitle];
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [viwHolderScroll addSubview:[AddComponents addTextView:txtTitle Frame:CGRectMake(x, y,txtViewWidthIphone , txtViewHeightIphone) delegate:self Tag:tag]];
        y=y+8+txtViewHeightIphone;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIphone,  y)];
    }
    else
    {
        [viwHolderScroll addSubview:[AddComponents addTextView:txtTitle Frame:CGRectMake(x, y,txtViewWidthIpad , txtViewHeightIpad) delegate:self Tag:tag]];
        y=y+8+txtViewHeightIpad;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIpad,  y)];
    }
    
}
#pragma mark Text View Delegates
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    txtView = textView;
    txtView.tag =textView.tag;
    int i;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([Utilities isTall])
        {
            i = txtView.frame.origin.y-150;
        }
        else
        {
            i = txtView.frame.origin.y-100;
        }
        if (txtView.frame.origin.y >84)
        {
            [viwHolderScroll setContentOffset:CGPointMake(0,i) animated:NO];
        }
    }
    else
    {
        i = txtView.frame.origin.y-450;
        if (txtView.frame.origin.y >400)
        {
            [viwHolderScroll setContentOffset:CGPointMake(0,i) animated:NO];
        }
    }
  
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

#pragma mark - Add Text Fields
-(void)AddTextFields:(int)tag Title:(NSString*)txtTitle KeyBoardType:(int)kbType
{
    if ([[[[Singleton sharedInstance].aryFields objectAtIndex:tag-1] valueForKey:jIs_required] boolValue])
    {
        [self AddLable:tag Title:[NSString stringWithFormat:@"* %@",txtTitle]];
    }
    else
    {
        [self AddLable:tag Title:txtTitle];
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [viwHolderScroll addSubview:[AddComponents addTextField:txtTitle Frame:CGRectMake(x, y,txtWidthIphone , txtHeightIphone) delegate:self Tag:tag KeyBoardType:kbType]];
        y=y+8+txtHeightIphone;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIphone,  y)];
    }
    else
    {
        [viwHolderScroll addSubview:[AddComponents addTextField:txtTitle Frame:CGRectMake(x, y,txtWidthIpad , txtHeightIpad) delegate:self Tag:tag KeyBoardType:kbType]];
        y=y+8+txtHeightIpad;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIpad,  y)];
    }
    
}

#pragma mark Text Field Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    if (textField.tag == 5)
//    {
//        [txtConfrimPassword resignFirstResponder];
//    }
//    else
//    {
//        UITextField *currentTxtField = (UITextField *)[self.view viewWithTag:textField.tag+1];
//        [currentTxtField becomeFirstResponder];
//    }
    if( [[self.view viewWithTag:txtCurrentfieldTag+1] isKindOfClass:[UITextField class]] )
    {
        UITextField *currentTxtField = (UITextField *)[self.view viewWithTag:txtCurrentfieldTag+1];
        [currentTxtField becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//    myTag = textField.tag;
    txtField = textField;
    txtField.tag = textField.tag;
    txtCurrentfieldTag = textField.tag;
//    NSLog(@"txtField>>> %d",txtField.tag);
//    NSLog(@"textField>>> %d",textField.tag);
    int i;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([Utilities isTall])
        {
            i = txtField.frame.origin.y-150;
        }
        else
        {
            i = txtField.frame.origin.y-100;
        }
        if (txtField.frame.origin.y >84)
        {
            [viwHolderScroll setContentOffset:CGPointMake(0,i) animated:NO];
        }
    }
    else
    {
        i = txtField.frame.origin.y-500;
        
        if (txtField.frame.origin.y >450)
        {
            [viwHolderScroll setContentOffset:CGPointMake(0,i) animated:NO];
        }
    }
    
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    if (textField == txtConfrimPassword)
//    {
//        [Utilities resetView:0 myView:self.view];
//    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    int j = textField.tag-1;
//    NSLog(@"J = %d",j);
//    NSLog(@"data = %@",[aryFields objectAtIndex:j]);
    
    if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jText])
    {
        return YES;
    }
    else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jShortname])
    {
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if ([myCharSet characterIsMember:c]) {
                return NO;
            }
            else
            {
                return YES;
            }
        }
        const char * _char = [string cStringUsingEncoding:NSUTF8StringEncoding];
        int isBackSpace = strcmp(_char, "\b");
        
        if (isBackSpace == -8)
        {
            return YES;
        }
    }
    else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jNumber]
             || [[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jMoney]
             )
    {
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if ([myCharSet characterIsMember:c]) {
                return YES;
            }
        }
        const char * _char = [string cStringUsingEncoding:NSUTF8StringEncoding];
        int isBackSpace = strcmp(_char, "\b");
        
        if (isBackSpace == -8)
        {
            return YES;
        }
    }
    else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jPhone])
    {
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if ([myCharSet characterIsMember:c]) {
                return YES;
            }
        }
        const char * _char = [string cStringUsingEncoding:NSUTF8StringEncoding];
        int isBackSpace = strcmp(_char, "\b");
        
        if (isBackSpace == -8)
        {
            return YES;
        }

    }
    else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jShortname])
    {
        return YES;
    }
    else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jEmail])
    {
        return YES;
    }
    
    else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jURL])
    {
        return YES;
    }
    else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jAddress])
    {
        return YES;
    }
    return NO;
}

#pragma mark - touchesBegan
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [txtField resignFirstResponder];
}

#pragma mark - Add Lables
-(void)AddLable:(int)tag Title:(NSString*)lblTitle
{

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [viwHolderScroll addSubview:[AddComponents addLable:lblTitle Frame:CGRectMake(x, y,lblWidthIphone , lblHeightIphone)]];
        y=y+3+lblHeightIphone;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIphone,  y)];
    }
    else
    {
        [viwHolderScroll addSubview:[AddComponents addLable:lblTitle Frame:CGRectMake(x, y,lblWidthIpad , lblHeightIpad)]];
        y=y+3+lblHeightIpad;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIpad,  y)];
    }
    
}

#pragma mark - Section
-(void)AddSectionLable:(int)tag Title:(NSString*)lblTitle
{
//    Lable:lblTitle Frame:CGRectMake(x, y,lblWidthIphone , lblHeightIphone)
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [viwHolderScroll addSubview:[AddComponents addSectionLable:lblTitle Frame:CGRectMake(x, y,lblWidthIphone , lblHeightIphone+5) Color:[UIColor darkTextColor] Size:lblSectionFontSize]];
        y=y+5+lblHeightIphone;
        
//        [viwHolderScroll addSubview:[AddComponents addSectionLine:CGRectMake(0, y, sectionWidthIphone, sectionHeightIphone) Color:[UIColor grayColor]]];
//        y=y+3+sectionHeightIphone;
        
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIphone,  y)];
    }
    else
    {
        [viwHolderScroll addSubview:[AddComponents addLable:lblTitle Frame:CGRectMake(x, y,lblWidthIpad , lblHeightIpad+5)]];
        y=y+5+lblHeightIpad;
        
//        [viwHolderScroll addSubview:[AddComponents addSectionLine:CGRectMake(0, y, sectionWidthIpad, sectionHeightIpad) Color:[UIColor grayColor]]];
//        y=y+3+sectionHeightIpad;
        
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIpad,  y)];
    }
    

}
#pragma mark - Add Buttons
-(void)AddButton:(int)tag Title:(NSString*)btnTitle 
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [viwHolderScroll addSubview:[AddComponents addButton:btnTitle Frame :CGRectMake(x, y,btnWidthIphone , btnHeightIphone) Selector:@selector(btnAction:) delegate:self Tag:tag]];
        y=y+10+btnHeightIphone;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIphone,  y)];
    }
    else
    {
       [viwHolderScroll addSubview:[AddComponents addButton:btnTitle Frame :CGRectMake(x, y,btnWidthIpad , btnHeightIpad) Selector:@selector(btnAction:) delegate:self Tag:tag]];
        y=y+10+btnHeightIpad;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIpad,  y)];
    }
    
}
- (void) btnAction:(id)sender
{
    [self hideKeyBoard];
//    NSLog(@"Btn tag = %d",[sender tag]-1);
}
#pragma mark - Add Remove Picker View
-(void)AddPickerButton:(int)tag Title:(NSString*)btnTitle
{
    [self hideKeyBoard];
//    [self AddLable:tag Title:btnTitle];
    if ([[[[Singleton sharedInstance].aryFields objectAtIndex:tag-1] valueForKey:jIs_required] boolValue])
    {
        [self AddLable:tag Title:[NSString stringWithFormat:@"* %@",btnTitle]];
    }
    else
    {
        [self AddLable:tag Title:btnTitle];
    }
    btnTitle = @"Select Choice";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [viwHolderScroll addSubview: [AddComponents addPickerButton:btnTitle Frame:CGRectMake(x, y,btnWidthIphone , btnHeightIphone) Selector:@selector(btnActionPicker:) delegate:self Tag:tag]];
        y=y+10+btnHeightIphone;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIphone,  y)];
    }
    else
    {
        [viwHolderScroll addSubview:[AddComponents addPickerButton:btnTitle Frame :CGRectMake(x, y,btnWidthIpad , btnHeightIpad) Selector:@selector(btnActionPicker:) delegate:self Tag:tag]];
        y=y+10+btnHeightIpad;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIpad,  y)];
    }
    
}
- (void) btnActionPicker:(id)sender
{
    [self hideKeyBoard];
//    NSLog(@"Btn Picker tag = %d",[sender tag]);
    btnPickerTag = [sender tag]-1;
    [self AddPicker:btnPickerTag ];
}
-(void)AddPicker:(int)tag
{
    
    [self removePicker];
    viewHolderSubView.hidden = NO;
    pickerViewController = [[PickerViewController alloc] initWithNibName:@"PickerViewController" bundle:nil];
    pickerViewController.fieldID = [NSString stringWithFormat:@"%d",tag];
    pickerViewController.dataAry = [[NSMutableArray alloc] initWithArray:[[[Singleton sharedInstance].aryFields objectAtIndex:tag] valueForKey:jChoices]];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([Utilities isTall])
        {
            viewHolderSubView.frame = CGRectMake(0, 242, 320, 261);
        }
    }
    else
    {
        viewHolderSubView.frame = CGRectMake(0, 740, 768, 300);
        pickerViewController.view.frame = CGRectMake(0, 0, 768, 261);
        pickerViewController.pickerView.frame = CGRectMake(0, 48, 768, 216);
    }
    pickerViewController.delegate = self;

    [viewHolderSubView addSubview:pickerViewController.view];
}
-(void)removePicker
{
    for(UIView *subview in [viewHolderSubView subviews])
    {
        [subview removeFromSuperview];
    }
}

#pragma mark Custom PickerView Delegates
-(void)btnCancelClicked:(NSInteger)row
{
    [self removePicker];
    viewHolderSubView.hidden = YES;
}
-(void)btnDoneClicked:(NSInteger)row
{
    viewHolderSubView.hidden = YES;
}
-(void)selectedIndex:(NSString*)str
{
//    NSLog(@"Selected = %@",str);
    UIButton *currentBtn = (UIButton *)[viwHolderScroll viewWithTag:btnPickerTag+1];
    [currentBtn setTitle:[NSString stringWithFormat:@"   %@",str] forState:UIControlStateNormal];
}
#pragma mark - Add Remove Date Picker View
-(void)AddDatePickerButton:(int)tag Title:(NSString*)btnTitle
{
    if ([[[[Singleton sharedInstance].aryFields objectAtIndex:tag-1] valueForKey:jIs_required] boolValue])
    {
        [self AddLable:tag Title:[NSString stringWithFormat:@"* %@",btnTitle]];
    }
    else
    {
        [self AddLable:tag Title:btnTitle];
    }
    
    if (falgDate0Time1 == 0)//Date
    {
        btnTitle = @"Set Date";
    }
    else if (falgDate0Time1 == 1)//Time
    {
        btnTitle = @"Set Time";
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [viwHolderScroll addSubview: [AddComponents addPickerButton:btnTitle Frame:CGRectMake(x, y,btnWidthIphone , btnHeightIphone) Selector:@selector(btnActionDatePicker:) delegate:self Tag:tag]];
        y=y+10+btnHeightIphone;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIphone,  y)];
    }
    else
    {
        [viwHolderScroll addSubview:[AddComponents addPickerButton:btnTitle Frame :CGRectMake(x, y,btnWidthIpad , btnHeightIpad) Selector:@selector(btnActionDatePicker:) delegate:self Tag:tag]];
        y=y+10+btnHeightIpad;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIpad,  y)];
    }
    
}
- (void) btnActionDatePicker:(id)sender
{
    [self hideKeyBoard];
    btnDatePickerTag = [sender tag]-1;
    
    if ([[[[Singleton sharedInstance].aryFields objectAtIndex:btnDatePickerTag] valueForKey:jType] isEqualToString:jDate])//Date
    {
        falgDate0Time1 = 0;
    }
    else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:btnDatePickerTag] valueForKey:jType] isEqualToString:jTime])//Time
    {
        falgDate0Time1 = 1;
    }

    [self AddDatePicker];
    //    NSLog(@"Btn Picker tag = %d",[sender tag]);
    
    
}
-(void)AddDatePicker
{
    
    [self removePicker];
    
    viewHolderSubView.hidden = NO;
    datePickerVC = [[DatePickerVC alloc] initWithNibName:@"DatePickerVC" bundle:nil];
    datePickerVC.flag = falgDate0Time1;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([Utilities isTall])
        {
            viewHolderSubView.frame = CGRectMake(0, 242, 320, 261);
        }
    }
    else
    {
        viewHolderSubView.frame = CGRectMake(0, 740, 768, 300);
        datePickerVC.view.frame = CGRectMake(0, 0, 768, 261);
        datePickerVC.pickerDate.frame = CGRectMake(0, 48, 768, 216);
    }
    datePickerVC.delegate = self;
    
    [viewHolderSubView addSubview:datePickerVC.view];
}
#pragma mark Custom Date PickerView Delegates

-(void)btnCancelDateClicked:(NSInteger)row
{
//    NSString *str;
//    if (falgDate0Time1 == 0)//Date
//    {
//        str = @"Set Date";
//    }
//    else if (falgDate0Time1 == 1)//Time
//    {
//        str = @"Set Time";
//    }
//    UIButton *currentBtn = (UIButton *)[viwHolderScroll viewWithTag:btnDatePickerTag];
//    [currentBtn setTitle:[NSString stringWithFormat:@"   %@",str] forState:UIControlStateNormal];
    [self removePicker];
    viewHolderSubView.hidden = YES;
}
-(void)btnDoneDateClicked:(NSString*)str
{
    viewHolderSubView.hidden = YES;
    UIButton *currentBtn = (UIButton *)[viwHolderScroll viewWithTag:btnDatePickerTag+1];
    [currentBtn setTitle:[NSString stringWithFormat:@"   %@",str] forState:UIControlStateNormal];
}
-(void)selectedDateIndex:(NSString*)str
{
    UIButton *currentBtn = (UIButton *)[viwHolderScroll viewWithTag:btnDatePickerTag+1];
    [currentBtn setTitle:[NSString stringWithFormat:@"   %@",str] forState:UIControlStateNormal];
}

#pragma mark Custom Multiple Values Delegates
-(void)AddMultiSelectionButton:(int)tag Title:(NSString*)btnTitle
{
    if ([[[[Singleton sharedInstance].aryFields objectAtIndex:tag-1] valueForKey:jIs_required] boolValue])
    {
        [self AddLable:tag Title:[NSString stringWithFormat:@"* %@",btnTitle]];
    }
    else
    {
        [self AddLable:tag Title:btnTitle];
    }
    btnTitle = @"Select Choices";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [viwHolderScroll addSubview: [AddComponents addPickerButton:btnTitle Frame:CGRectMake(x, y,btnWidthIphone , btnHeightIphone) Selector:@selector(btnActionMultiSelection:) delegate:self Tag:tag]];
        y=y+10+btnHeightIphone;
    }
    else
    {
        [viwHolderScroll addSubview:[AddComponents addPickerButton:btnTitle Frame :CGRectMake(x, y,btnWidthIpad , btnHeightIpad) Selector:@selector(btnActionMultiSelection:) delegate:self Tag:tag]];
        y=y+10+btnHeightIpad;
    }

    [viwHolderScroll setContentSize:CGSizeMake(320,  y)];
}
- (void) btnActionMultiSelection:(id)sender
{
    [self hideKeyBoard];
    MultiSelectionViewController *multiSelectionViewController;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        multiSelectionViewController = [[MultiSelectionViewController alloc] initWithNibName:@"MultiSelectionViewController" bundle:nil];
    }
    else
    {
        multiSelectionViewController = [[MultiSelectionViewController alloc] initWithNibName:@"MultiSelectionViewController_iPad" bundle:nil];
    }
    int i = [sender tag]-1;
    multiSelectionViewController.aryData = [[NSMutableArray alloc] initWithArray:[[[Singleton sharedInstance].aryFields objectAtIndex:i] valueForKey:jChoices]];
    multiSelectionViewController.delegate = self;
//    NSLog(@"Btn Multi tag = %d",[sender tag]-1);
    btnMultiSelectionTag = [sender tag]-1;
    multiSelectionViewController.fieldID = [NSString stringWithFormat:@"%d",[sender tag]-1];
//    [[Singleton sharedInstance].dictMultiSelectedStrings setObject:selectedDict forKey:fieldID];
    if ([[Singleton sharedInstance].dictMultiSelectedStrings valueForKey:[NSString stringWithFormat:@"%d",[sender tag]-1]])
    {
        multiSelectionViewController.selectedDict = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictMultiSelectedStrings valueForKey:[NSString stringWithFormat:@"%d",[sender tag]-1]]];
        
    }
    else
    {
        multiSelectionViewController.selectedDict = [[NSMutableDictionary alloc] init];
    }
    [self.navigationController pushViewController:multiSelectionViewController animated:YES];
}

-(void)btnCancelMultiClicked:(NSInteger)row
{
    
}
-(void)btnDoneMultiClicked:(NSInteger)row
{
   
}
-(void)selectedValues:(NSString *)str
{
//    NSLog(@"Selected = %@",str);
//    NSLog(@"Btn Multi str = %@",str);
    UIButton *currentBtn = (UIButton *)[viwHolderScroll viewWithTag:btnMultiSelectionTag+1];
    [currentBtn setTitle:[NSString stringWithFormat:@"   %@",str] forState:UIControlStateNormal];
}
#pragma mark - Add Image View
-(void)AddImageButtons:(int)tag Title:(NSString*)btnTitle
{
    if ([[[[Singleton sharedInstance].aryFields objectAtIndex:tag-1] valueForKey:jIs_required] boolValue])
    {
        [self AddLable:tag Title:[NSString stringWithFormat:@"* %@",btnTitle]];
    }
    else
    {
        [self AddLable:tag Title:btnTitle];
    }
//    [self AddLable:tag Title:@"Image section"];
    if ([[[[Singleton sharedInstance].aryFields objectAtIndex:tag-1] valueForKey:jIs_required] boolValue])
    {
        btnTitle = [NSString stringWithFormat:@"* %@",btnTitle];
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [viwHolderScroll addSubview: [AddComponents addButton:@"Camera" Frame:CGRectMake(x, y,btnImgWidthIphone , btnImgHeightIphone) Selector:@selector(btnActionAddImage:) delegate:self Tag:tag]];
        [viwHolderScroll addSubview: [AddComponents addButton:@"View" Frame:CGRectMake(btnImgWidthIphone+30, y,btnImgWidthIphone , btnImgHeightIphone) Selector:@selector(btnViewImage:) delegate:self Tag:tag+1000]];
        
        y=y+10+btnHeightIphone;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIphone,  y)];
        
    }
    else
    {
        [viwHolderScroll addSubview:[AddComponents addButton:@"Camera" Frame :CGRectMake(x, y,btnImgWidthIpad , btnImgHeightIpad) Selector:@selector(btnActionAddImage:) delegate:self Tag:tag]];
        [viwHolderScroll addSubview: [AddComponents addButton:@"View" Frame:CGRectMake(btnImgWidthIpad+40, y,btnImgWidthIpad , btnImgHeightIpad) Selector:@selector(btnViewImage:) delegate:self Tag:tag+1000]];
        y=y+10+btnHeightIpad;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIpad,  y)];
    }
    
}
- (void) btnActionAddImage:(id)sender
{
    [self hideKeyBoard];
    int tagg = [sender tag]-1;
    ImagePickerVC *imagePickerVC;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        imagePickerVC = [[ImagePickerVC alloc] initWithNibName:@"ImagePickerVC" bundle:nil];
    
    } else {
        imagePickerVC = [[ImagePickerVC alloc] initWithNibName:@"ImagePickerVC_iPad" bundle:nil];
    }
    imagePickerVC.flag = captureImage ;
    imagePickerVC.myTag = [NSString stringWithFormat:@"%d",tagg];
//    imagePickerVC.formID = formID;
    imagePickerVC.fieldID = [[[Singleton sharedInstance].aryFields objectAtIndex:tagg] valueForKey:jID];
//    imagePickerVC.userID = [UserInfo sharedInstance].userID;
    [self.navigationController pushViewController:imagePickerVC animated:YES];
}
- (void) btnViewImage:(id)sender
{
    
    int tagg = [sender tag]-1001;
    ImagePickerVC *imagePickerVC;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        imagePickerVC = [[ImagePickerVC alloc] initWithNibName:@"ImagePickerVC" bundle:nil];
    }
    else
    {
        imagePickerVC = [[ImagePickerVC alloc] initWithNibName:@"ImagePickerVC_iPad" bundle:nil];
    }
    imagePickerVC.flag = viewImageOnly ;
    imagePickerVC.myTag = [NSString stringWithFormat:@"%d",tagg];
    
    if ([[Singleton sharedInstance].dictImageContainer objectForKey:[NSString stringWithFormat:@"%d",tagg]])
    {
        [self.navigationController pushViewController:imagePickerVC animated:YES];
    }
    else
    {
        [Utilities simpleOkAlertBox:@"Warning" Body:@"Image not added."];
    }
    
    //    NSLog(@"Btn Picker tag = %d",[sender tag]);
    
}
#pragma mark - Add Signature View
-(void)AddSignatureButtons:(int)tag Title:(NSString*)btnTitle
{
    if ([[[[Singleton sharedInstance].aryFields objectAtIndex:tag-1] valueForKey:jIs_required] boolValue])
    {
        [self AddLable:tag Title:[NSString stringWithFormat:@"* %@",btnTitle]];
    }
    else
    {
        [self AddLable:tag Title:btnTitle];
    }
    //    [self AddLable:tag Title:@"Image section"];
    if ([[[[Singleton sharedInstance].aryFields objectAtIndex:tag-1] valueForKey:jIs_required] boolValue])
    {
        btnTitle = [NSString stringWithFormat:@"* %@",btnTitle];
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [viwHolderScroll addSubview: [AddComponents addButton:@"Signature" Frame:CGRectMake(x, y,btnImgWidthIphone , btnImgHeightIphone) Selector:@selector(btnActionAddSignature:) delegate:self Tag:tag]];
        [viwHolderScroll addSubview: [AddComponents addButton:@"View" Frame:CGRectMake(btnImgWidthIphone+30, y,btnImgWidthIphone , btnImgHeightIphone) Selector:@selector(btnViewSignature:) delegate:self Tag:tag+2000]];
        
        y=y+10+btnHeightIphone;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIphone,  y)];
        
    }
    else
    {
        [viwHolderScroll addSubview:[AddComponents addButton:@"Gallary" Frame :CGRectMake(x, y,btnImgWidthIpad , btnImgHeightIpad) Selector:@selector(btnActionAddSignature:) delegate:self Tag:tag]];
        [viwHolderScroll addSubview: [AddComponents addButton:@"View" Frame:CGRectMake(btnImgWidthIpad+40, y,btnImgWidthIpad , btnImgHeightIpad) Selector:@selector(btnViewSignature:) delegate:self Tag:tag+2000]];
        y=y+10+btnHeightIpad;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIpad,  y)];
    }
    
}
- (void) btnActionAddSignature:(id)sender
{
    [self hideKeyBoard];
    int tagg = [sender tag]-1;
    SignaturePopoverViewController *signaturePopoverVC;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        signaturePopoverVC = [[SignaturePopoverViewController alloc] initWithNibName:@"SignaturePopoverViewController" bundle:nil];
        
        signaturePopoverVC.myTag = [NSString stringWithFormat:@"%d",tagg];
    } else {
        signaturePopoverVC = [[SignaturePopoverViewController alloc] initWithNibName:@"SignaturePopoverViewController_iPad" bundle:nil];
    }
    signaturePopoverVC.myTag = [NSString stringWithFormat:@"%d",tagg];
    signaturePopoverVC.formID = formID;
    signaturePopoverVC.fieldID = [[[Singleton sharedInstance].aryFields objectAtIndex:tagg] valueForKey:jID];
    signaturePopoverVC.userID = [UserInfo sharedInstance].userID;
    signaturePopoverVC.viewFlag = 0;
    [self.navigationController pushViewController:signaturePopoverVC animated:YES];
}
- (void) btnViewSignature:(id)sender
{
    [self hideKeyBoard];
    int tagg = [sender tag]-2001;
    SignaturePopoverViewController *signaturePopoverVC;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        signaturePopoverVC = [[SignaturePopoverViewController alloc] initWithNibName:@"SignaturePopoverViewController" bundle:nil];
        
    }
    else
    {
        signaturePopoverVC = [[SignaturePopoverViewController alloc] initWithNibName:@"SignaturePopoverViewController_iPad" bundle:nil];
    }
    signaturePopoverVC.myTag = [NSString stringWithFormat:@"%d",tagg];
    signaturePopoverVC.formID = formID;
    signaturePopoverVC.fieldID = [[[Singleton sharedInstance].aryFields objectAtIndex:tagg] valueForKey:jID];
    signaturePopoverVC.userID = [UserInfo sharedInstance].userID;
    signaturePopoverVC.viewFlag = fSignView;
    if ([[Singleton sharedInstance].dictSingnContainer objectForKey:[NSString stringWithFormat:@"%d",tagg]])
    {
        [self.navigationController pushViewController:signaturePopoverVC animated:YES];
    }
    else
    {
        [Utilities simpleOkAlertBox:@"Warning" Body:@"Image not added."];
    }
}

#pragma mark - Add Audio View
-(void)AddAudioButtons:(int)tag Title:(NSString*)btnTitle
{
    
//    [self AddLable:tag Title:@"Audio section"];
    if ([[[[Singleton sharedInstance].aryFields objectAtIndex:tag-1] valueForKey:jIs_required] boolValue])
    {
        [self AddLable:tag Title:[NSString stringWithFormat:@"* %@",btnTitle]];
    }
    else
    {
        [self AddLable:tag Title:btnTitle];
    }
    if ([[[[Singleton sharedInstance].aryFields objectAtIndex:tag-1] valueForKey:jIs_required] boolValue])
    {
        btnTitle = [NSString stringWithFormat:@"* %@",btnTitle];
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [viwHolderScroll addSubview: [AddComponents addButton:@"Recording" Frame:CGRectMake(x, y,btnImgWidthIphone , btnImgHeightIphone) Selector:@selector(btnActionAddAudio:) delegate:self Tag:tag]];
        [viwHolderScroll addSubview: [AddComponents addButton:@"Library" Frame:CGRectMake(btnImgWidthIphone+30, y,btnImgWidthIphone , btnImgHeightIphone) Selector:@selector(btnViewAudio:) delegate:self Tag:tag+3000]];
        
        y=y+10+btnHeightIphone;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIphone,  y)];
    }
    else
    {
        [viwHolderScroll addSubview:[AddComponents addButton:@"Recording" Frame :CGRectMake(x, y,btnImgWidthIpad , btnImgHeightIpad) Selector:@selector(btnActionAddAudio:) delegate:self Tag:tag]];
        [viwHolderScroll addSubview: [AddComponents addButton:@"Library" Frame:CGRectMake(btnImgWidthIpad+40, y,btnImgWidthIpad , btnImgHeightIpad) Selector:@selector(btnViewAudio:) delegate:self Tag:tag+3000]];
        y=y+10+btnHeightIpad;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIpad,  y)];
    }
    
    [viwHolderScroll setContentSize:CGSizeMake(320,  y)];
}
- (void) btnActionAddAudio:(id)sender//Recording
{
    [self hideKeyBoard];
//    NSError *setCategoryErr = nil;
//    NSError *activationErr  = nil;
//    //Set the general audio session category
//    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: &setCategoryErr];
//    
//    //Make the default sound route for the session be to use the speaker
//    UInt32 doChangeDefaultRoute = 1;
//    AudioSessionSetProperty (kAudioSessionProperty_OverrideCategoryDefaultToSpeaker, sizeof (doChangeDefaultRoute), &doChangeDefaultRoute);
//    
//    //Activate the customized audio session
//    [[AVAudioSession sharedInstance] setActive: YES error: &activationErr];
//    SpeakHereViewController *speakHereViewController = [[SpeakHereViewController alloc] init];
//    [self.navigationController pushViewController:speakHereViewController animated:YES];
    int tagg = [sender tag]-1;
    AudioRecVC *audioVC;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        audioVC = [[AudioRecVC alloc] initWithNibName:@"AudioRecVC" bundle:nil];
        audioVC.myTag = [NSString stringWithFormat:@"%d",tagg];
        audioVC.formID = formID;
        audioVC.fieldID = [[[Singleton sharedInstance].aryFields objectAtIndex:tagg] valueForKey:jID];
        audioVC.userID = [UserInfo sharedInstance].userID;
        audioVC.flagLibrary = 0;
    } else {
        //        audioVC = [[AudioVC alloc] initWithNibName:@"ImagePickerVC_iPad" bundle:nil];
    }
    //
    [self.navigationController pushViewController:audioVC animated:YES];

}
- (void) btnViewAudio:(id)sender//Library
{
    [self hideKeyBoard];
    int tagg = [sender tag]-3001;
    AudioVC *audioVC;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        audioVC = [[AudioVC alloc] initWithNibName:@"AudioVC" bundle:nil];
        audioVC.myTag = [NSString stringWithFormat:@"%d",tagg];
        audioVC.formID = formID;
        audioVC.fieldID = [[[Singleton sharedInstance].aryFields objectAtIndex:tagg] valueForKey:jID];
        audioVC.userID = [UserInfo sharedInstance].userID;
        audioVC.flagLibrary = fLibrary;
    } else {
        //        audioVC = [[AudioVC alloc] initWithNibName:@"ImagePickerVC_iPad" bundle:nil];
    }
    //
    [self.navigationController pushViewController:audioVC animated:YES];
    
//    int tagg = [sender tag]-1001;
//    if ([[Singleton sharedInstance].dictAudio objectForKey:[NSString stringWithFormat:@"%d",tagg]])
//    {
//        
//    }
//    else
//    {
//        [Utilities simpleOkAlertBox:@"Warning" Body:@"Audio file not exist."];
//    }
    
//    ImagePickerVC *imagePickerVC;
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//    {
//        imagePickerVC = [[ImagePickerVC alloc] initWithNibName:@"ImagePickerVC" bundle:nil];
//        imagePickerVC.flag = viewImageOnly ;
//        imagePickerVC.myTag = [NSString stringWithFormat:@"%d",tagg];
//    }
//    else
//    {
//        imagePickerVC = [[ImagePickerVC alloc] initWithNibName:@"ImagePickerVC_iPad" bundle:nil];
//    }
//    if ([[Singleton sharedInstance].dictImageContainer objectForKey:[NSString stringWithFormat:@"%d",tagg]])
//    {
//        [self.navigationController pushViewController:imagePickerVC animated:YES];
//    }
//    else
//    {
//        [Utilities simpleOkAlertBox:@"Warning" Body:@"Audio not added."];
//    }
}
//===========
#pragma mark - Add Next for page break
-(void)AddNextButton:(int)tag Title:(NSString*)btnTitle
{
    btnTitle = @"Next";
    [self AddLable:tag Title:@"Next Page"];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [viwHolderScroll addSubview:[AddComponents addButton:btnTitle Frame :CGRectMake(x+15, y,btnWidthIphone-30 , btnHeightIphone) Selector:@selector(btnNextAction:) delegate:self Tag:tag]];
        y=y+10+btnHeightIphone;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIphone,  y)];
    }
    else
    {
        [viwHolderScroll addSubview:[AddComponents addButton:btnTitle Frame :CGRectMake(x+15, y,btnWidthIpad-30 , btnHeightIpad) Selector:@selector(btnNextAction:) delegate:self Tag:tag]];
        y=y+10+btnHeightIpad;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIpad,  y)];
    }
    
}
- (void) btnNextAction:(id)sender
{
    [self hideKeyBoard];
    [self SaveData:fNext];
    
//    NSLog(@"Btn Next = %d",[sender tag]-1);
}

#pragma mark - Add Menu Buttons
-(void)AddMenuButtons:(int)tag Title:(NSString*)btnTitle
{
   
    [self AddLable:tag Title:@"Menu"];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [viwHolderScroll addSubview: [AddComponents addButton:@"Send" Frame:CGRectMake(x,y,btnImgWidthIphone-15 , btnImgHeightIphone) Selector:@selector(btnActionSend:) delegate:self Tag:tag]];
        [viwHolderScroll addSubview: [AddComponents addButton:@"Save" Frame:CGRectMake(btnImgWidthIphone+10, y,btnImgWidthIphone-30 , btnImgHeightIphone) Selector:@selector(btnActionSave:) delegate:self Tag:tag]];
        [viwHolderScroll addSubview: [AddComponents addButton:@"Cancel" Frame:CGRectMake(btnImgWidthIphone+btnImgWidthIphone+6, y,btnImgWidthIphone-15 , btnImgHeightIphone) Selector:@selector(btnActionCancel:) delegate:self Tag:tag]];
        if (_isSavedForm) {
        
           [viwHolderScroll addSubview: [AddComponents addButton:@"Delete" Frame:CGRectMake(btnImgWidthIphone+btnImgWidthIphone+btnImgWidthIphone+6, y,btnImgWidthIphone-15 , btnImgHeightIphone) Selector:@selector(btnActionDelete:) delegate:self Tag:tag]];
           
        }
        y=y+10+btnHeightIphone;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIphone,  y)];
        
    }
    else
    {
        [viwHolderScroll addSubview:[AddComponents addButton:@"Send" Frame :CGRectMake(x, y,btnImgWidthIpad-40 , btnImgHeightIpad) Selector:@selector(btnActionSend:) delegate:self Tag:tag]];
        
        [viwHolderScroll addSubview: [AddComponents addButton:@"Save" Frame:CGRectMake(btnImgWidthIpad-10, y,btnImgWidthIpad-40 , btnImgHeightIpad) Selector:@selector(btnActionSave:) delegate:self Tag:tag]];
        
        [viwHolderScroll addSubview: [AddComponents addButton:@"Cancel" Frame:CGRectMake(btnImgWidthIpad+btnImgWidthIpad-40, y,btnImgWidthIpad-40 , btnImgHeightIpad) Selector:@selector(btnActionCancel:) delegate:self Tag:tag]];
       if (_isSavedForm ) {
        
            [viwHolderScroll addSubview: [AddComponents addButton:@"Delete" Frame:CGRectMake(btnImgWidthIpad+btnImgWidthIpad-40, y,btnImgWidthIpad-40 , btnImgHeightIpad) Selector:@selector(btnActionDelete:) delegate:self Tag:tag]];
        }
        
        y=y+10+btnHeightIpad;
        [viwHolderScroll setContentSize:CGSizeMake(sectionWidthIpad,  y)];
    }
    
}
- (void) btnActionSend:(id)sender
{
    [self hideKeyBoard];
    [self SaveData:fSend];
//   NSLog(@"btnActionSend = %d",[sender tag]);
}
- (void) btnActionSave:(id)sender // updated by shoaib
{
    [self hideKeyBoard];
//    NSLog(@"btnActionSave = %d",[sender tag]);
    
    [self SaveData:fSave];
    
    
}
- (void) btnActionCancel:(id)sender
{
    [self hideKeyBoard];
    [self.navigationController popViewControllerAnimated:YES];
//    NSLog(@"btnActionCancel = %d",[sender tag]);
}
- (void) btnActionDelete:(id)sender
{
    [self deleteDbEForm];
    [self hideKeyBoard];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Read & Save data
-(void)SaveData:(int)flagSaveSend
{
    int flagTypeOfAry;
//    NSMutableArray *aryMainForFields = [[NSMutableArray alloc] init];
//    NSMutableDictionary *dictMainForFields = [[NSMutableDictionary alloc] init];
    NSString * choicesStr;
    
    for (int j = startAddControls; j< [[Singleton sharedInstance].aryFields count];j++ )
    {
        int i = j+1;
        NSMutableArray *aryChoices = [[NSMutableArray alloc] init];
        
        NSMutableDictionary *dictSelectedChoices = [[NSMutableDictionary alloc] init];
        NSString *currentString = @"";
        if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jText])//Text
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromTextField:self.view MyTag:i];
            if (currentString == nil) {
                currentString = @"";
            }
            if (currentString)
            {
//                NSLog(@"Text = %@",currentString);
            }
            else
            {
                
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }
//            NSLog(@"Text = %@",currentString);
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jNumber])//Number
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromTextField:self.view MyTag:i];
            if (currentString)
            {
//                NSLog(@"Number = %@",currentString);
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }

//            NSLog(@"Number = %@",currentString);
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jTextArea])//TextArea
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromTextView:self.view MyTag:i];
            if (currentString)
            {
//                NSLog(@"Text Area = %@",currentString);
            }
            else
            {
                
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }

//            NSLog(@"Text Area = %@",currentString);
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jCheckbox])//Multi Selection
        {
            flagTypeOfAry = fMulti;
            if ([[Singleton sharedInstance].dictMultiSelectedStrings valueForKey:[NSString stringWithFormat:@"%d",j]])
            {
                dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictMultiSelectedStrings valueForKey:[NSString stringWithFormat:@"%d",j]]];
//                 NSLog(@"yes multi %@",dictSelectedChoices);
                currentString = @"";
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
//                    dictSelectedChoices = [[NSMutableDictionary alloc] init];
                    dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictMultiSelectedStrings valueForKey:[NSString stringWithFormat:@"%d",j]]];
                    currentString = @"";
//                     NSLog(@"Multi Empty = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictMultiSelectedStrings valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                }
            }
           
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jRadio])//Radio
        {
            flagTypeOfAry = fSingle;
            if ([[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]])
            {
//                NSLog(@"Radio %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
                currentString =[[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]] valueForKey:jChoice];
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
//                    dictSelectedChoices = [[NSMutableDictionary alloc] init];
                    dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
                    currentString =[[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]] valueForKey:jChoice];
//                    NSLog(@"Radio Empty %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                }
            }
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jSelect])//Select
        {
            flagTypeOfAry = fSingle;
            if ([[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]])
            {
                //                NSLog(@"Radio %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]] ;
                currentString =[[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]] valueForKey:jChoice];
                
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    //                    dictSelectedChoices = [[NSMutableDictionary alloc] init];
                    dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
                    currentString =[[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]] valueForKey:jChoice];
                    //                    NSLog(@"Radio Empty %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                }
            }
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jSection])//Section
        {
            flagTypeOfAry = fOther;
            currentString = [[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle];
            if (!currentString)
            {
                currentString = @"";
            }
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//               [Utilities simpleOkAlertBox:avTitleError Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
//            }
//            else
//            {
//                 NSLog(@"save");
//            }
 
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jPage])//Page
        {
//            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//            {
//                [Utilities simpleOkAlertBox:avTitleError Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
//            }
//            else
//            {
//                NSLog(@"save");
            NSMutableDictionary *dictLocal = [[NSMutableDictionary alloc] init];
            [dictLocal setObject:dictSelectedChoices forKey:jSelectedChoices];
            [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID] forKey:jID];
            [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle] forKey:jTitle];
            [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] forKey:jType];
            if ([currentString isEqualToString:@""])
            {
                [dictLocal setObject:@"(null)"  forKey:jFieldData];
                dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
            }
            else
            {
                [dictLocal setObject:currentString  forKey:jFieldData];
            }
            
            [[Singleton sharedInstance].dictMainForFields setObject:dictLocal forKey: [[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]];
            break;
//            }
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jShortname])//Shortname
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromTextField:self.view MyTag:i];
            if (currentString)
            {
//                NSLog(@"Shortname = %@",currentString);
//                if ([Utilities validateFirstAndLastNameCharsOnly:currentString])
//                {
//                    ///save
//                }
//                else
//                {
//                    [Utilities simpleOkAlertBox:avTitleError Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisNotValid]];
//                }
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }
//           NSLog(@"Shortname = %@",currentString); 
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jSignature])//Sign
        {
            flagTypeOfAry = fSignImg;
            if ([[Singleton sharedInstance].dictSingnContainer valueForKey:[NSString stringWithFormat:@"%d",j]])
            {
//                NSLog(@"image = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
                currentString = [[Singleton sharedInstance].dictSingnContainer valueForKey:[NSString stringWithFormat:@"%d",j]];
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    //                    NSLog(@"image Empty = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                    //                    dictSelectedChoices = [[NSMutableDictionary alloc] init];
                    dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
                    currentString = @"";
                }
            }
//            if ([[Singleton sharedInstance].dictImageContainer valueForKey:[NSString stringWithFormat:@"%d",j]])
//            {
//                //                NSLog(@"image = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
//                dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
//                currentString = [[Singleton sharedInstance].dictImageContainer valueForKey:[NSString stringWithFormat:@"%d",j]];
//            }
//            else
//            {
//                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//                {
//                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
//                    currentString = @"";
//                    return;
//                }
//                else
//                {
//                    //                    NSLog(@"image Empty = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
//                    //                    dictSelectedChoices = [[NSMutableDictionary alloc] init];
//                    dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
//                    currentString = @"";
//                }
//            }
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jImage])//Image
        {
            flagTypeOfAry = fImg;
            if ([[Singleton sharedInstance].dictImageContainer valueForKey:[NSString stringWithFormat:@"%d",j]])
            {
//                NSLog(@"image = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
                currentString = [[Singleton sharedInstance].dictImageContainer valueForKey:[NSString stringWithFormat:@"%d",j]];
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
//                    NSLog(@"image Empty = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
//                    dictSelectedChoices = [[NSMutableDictionary alloc] init];
                    dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
                    currentString = @"";
                }
            }
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jAudio])//Audio
        {
            flagTypeOfAry = fAudio;
            if ([[Singleton sharedInstance].dictAudio valueForKey:[NSString stringWithFormat:@"%d",j]])
            {
                //                NSLog(@"image = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
                currentString = [[Singleton sharedInstance].dictAudio valueForKey:[NSString stringWithFormat:@"%d",j]];
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    //                    NSLog(@"image Empty = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                    //                    dictSelectedChoices = [[NSMutableDictionary alloc] init];
                    dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
                    currentString = @"";
                }
            }

//            if ([[Singleton sharedInstance].dictAudio valueForKey:[NSString stringWithFormat:@"%d",j]])
//            {
////                NSLog(@"Audio = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictAudio valueForKey:[NSString stringWithFormat:@"%d",j]]]);
//                dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictAudio valueForKey:[NSString stringWithFormat:@"%d",j]]];
//                currentString = [[Singleton sharedInstance].dictAudio valueForKey:[NSString stringWithFormat:@"%d",j]];
//            }
//            else
//            {
//                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
//                {
//                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
//                    currentString = @"";
//                    return;
//                }
//                else
//                {
////                    dictSelectedChoices = [[NSMutableDictionary alloc] init];
//                    dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictAudio valueForKey:[NSString stringWithFormat:@"%d",j]]];
//                    currentString = @"";
////                     NSLog(@"Audio = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictAudio valueForKey:[NSString stringWithFormat:@"%d",j]]]);
//                }
//            }
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jAddress])//Address
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromTextField:self.view MyTag:i];
            if (currentString)
            {
//                NSLog(@"Address = %@",currentString);
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }
            
//            NSLog(@"Address = %@",currentString);
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jDate])//Date
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromButton:self.view MyTag:i];
            if ([currentString isEqualToString:@"   Set Date"])
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
//                    currentString = @"\"\"";
                    currentString = @"";
                }
            }
            else
            {
                currentString = [Utilities stringFromButton:self.view MyTag:i];
                currentString = [currentString stringByReplacingOccurrencesOfString:@"   " withString:@""];
            }
//            NSLog(@"Date = %@",currentString);
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jEmail])//Email
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromTextField:self.view MyTag:i];
            if (currentString)
            {
                if ([Utilities validateEmailWithString:currentString])
                {
                    //save for json
                }
                else
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisNotValid]];
                    currentString = @"";
                    return;
                }
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }
            
//            NSLog(@"Email = %@",[Utilities stringFromTextField:self.view MyTag:i]);
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jTime])//Time
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromButton:self.view MyTag:i];
            if ([currentString isEqualToString:@"   Set Time"])
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                   [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }
            else
            {
                currentString = [Utilities stringFromButton:self.view MyTag:i];
                currentString = [currentString stringByReplacingOccurrencesOfString:@"   " withString:@""];
            }
//            NSLog(@"Time = %@",currentString);
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jPhone])//Phone
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromTextField:self.view MyTag:i];
            if (currentString)
            {
                
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }
//            NSLog(@"Phone = %@",currentString);
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jURL])//URL
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromTextField:self.view MyTag:i];
            if (currentString)
            {
                
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }
//            NSLog(@"URL = %@",currentString);
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jMoney])//Money
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromTextField:self.view MyTag:i];
            if (currentString)
            {
                
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }
//            NSLog(@"Money = %@",currentString);
        }
        
        if (flagSaveSend == fSave)
        {
            NSMutableDictionary *dictLocal = [[NSMutableDictionary alloc] init];
            [dictLocal setObject:dictSelectedChoices forKey:jSelectedChoices];
            [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID] forKey:jID];
            [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle] forKey:jTitle];
            [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] forKey:jType];
            if ([currentString isEqualToString:@""])
            {
                [dictLocal setObject:@"(null)"  forKey:jFieldData];
                dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
            }
            else
            {
                [dictLocal setObject:currentString  forKey:jFieldData];
            }
//            [dictMainForFields setObject:dictLocal forKey: [[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]];
//            [[Singleton sharedInstance].dictLocal setObject:dictSelectedChoices forKey:jSelectedChoices];
//            [[Singleton sharedInstance].dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID] forKey:jID];
//            [[Singleton sharedInstance].dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle] forKey:jTitle];
//            [[Singleton sharedInstance].dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] forKey:jType];
//            if ([currentString isEqualToString:@""])
//            {
//                [[Singleton sharedInstance].dictLocal setObject:@"(null)"  forKey:jFieldData];
//                [Singleton sharedInstance].dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:[Singleton sharedInstance].dictLocal]];
//            }
//            else
//            {
//                [[Singleton sharedInstance].dictLocal setObject:currentString  forKey:jFieldData];
//            }

            [[Singleton sharedInstance].dictMainForFields setObject:dictLocal forKey: [[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]];
        }
        else if (flagSaveSend == fNext)
        {
            
//            [[Singleton sharedInstance].dictLocal setObject:dictSelectedChoices forKey:jSelectedChoices];
//            [[Singleton sharedInstance].dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID] forKey:jID];
//            [[Singleton sharedInstance].dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle] forKey:jTitle];
//            [[Singleton sharedInstance].dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] forKey:jType];
//            if ([currentString isEqualToString:@""])
//            {
//                [[Singleton sharedInstance].dictLocal setObject:@"(null)"  forKey:jFieldData];
//                [Singleton sharedInstance].dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:[Singleton sharedInstance].dictLocal]];
//            }
//            else
//            {
//                [[Singleton sharedInstance].dictLocal setObject:currentString  forKey:jFieldData];
//            }
            NSMutableDictionary *dictLocal = [[NSMutableDictionary alloc] init];
            [dictLocal setObject:dictSelectedChoices forKey:jSelectedChoices];
            [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID] forKey:jID];
            [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle] forKey:jTitle];
            [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] forKey:jType];
            if ([currentString isEqualToString:@""])
            {
                [dictLocal setObject:@"(null)"  forKey:jFieldData];
                dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
            }
            else
            {
                [dictLocal setObject:currentString  forKey:jFieldData];
            }

            [[Singleton sharedInstance].dictMainForFields setObject:dictLocal forKey: [[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]];
            
            ////send
            if ( (flagTypeOfAry == fImg) || (flagTypeOfAry == fAudio) || (flagTypeOfAry == fSignImg) )
            {
                NSMutableDictionary *dictLocal = [[NSMutableDictionary alloc] init];
                
                //                if (flagTypeOfAry == fImg)
                //                {
                //
                //                }
                //                else if (flagTypeOfAry == fAudio)
                //                {
                //
                //                }
                //                else if (flagTypeOfAry == fSignImg)
                //                {
                //
                //                }
                [dictLocal setObject:@"(null)"  forKey:jField_data];
                dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID] forKey:jField_id];
                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] forKey:jField_type];
//                 [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jName] forKey:JField_name];
                

                [[Singleton sharedInstance].aryMainForFields addObject:dictLocal];
//                NSLog(@"%@",dictLocal);
                [[Singleton sharedInstance].dictSendMainForFields setObject:dictLocal forKey:[NSString stringWithFormat:@"%d",j]];
                
            }
            else
            {
                NSMutableDictionary *dictLocal = [[NSMutableDictionary alloc] init];
                
                if ([currentString isEqualToString:@""] || currentString == nil)
                {
                    [dictLocal setObject:@"(null)"  forKey:jField_data];
                    dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
                }
                else
                {
                    if (flagTypeOfAry == fOther)
                    {
                        [dictLocal setObject:currentString  forKey:jField_data];
                    }
                    
                }
                if (flagTypeOfAry == fMulti)
                {
                    aryChoices = [[NSMutableArray alloc] initWithArray:[dictSelectedChoices allValues]];
                    if ([aryChoices count]>0)
                    {
                        choicesStr = [Utilities addingArraysForMultiSelection:aryChoices Key:jID];
                        [dictLocal setObject:choicesStr  forKey:jField_data];
                    }
                    else
                    {
                        [dictLocal setObject:@"(null)"  forKey:jField_data];
                        dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
                    }
                    
                }
                else if (flagTypeOfAry == fSingle)
                {
                    aryChoices = [[NSMutableArray alloc] initWithArray:[dictSelectedChoices allValues]];
                    if ([aryChoices count]>0)
                    {
                        choicesStr = [dictSelectedChoices valueForKey:jID];
                        [dictLocal setObject:choicesStr  forKey:jField_data];
                    }
                    else
                    {
                        [dictLocal setObject:@"(null)"  forKey:jField_data];
                        dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
                    }
                    
                }
                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID] forKey:jField_id];
                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] forKey:jField_type];
//                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jName] forKey:JField_name];
                

                
                [[Singleton sharedInstance].aryMainForFields addObject:dictLocal];
//                NSLog(@"%@",dictLocal);
                [[Singleton sharedInstance].dictSendMainForFields setObject:dictLocal forKey:[NSString stringWithFormat:@"%d",j]];
                //====
                
            }
        }
        else if (flagSaveSend == fSend)
        {
            if ( (flagTypeOfAry == fImg) || (flagTypeOfAry == fAudio) || (flagTypeOfAry == fSignImg) )
            {
                
                //=====
                NSMutableDictionary *dictLocal = [[NSMutableDictionary alloc] init];
                
                //                if (flagTypeOfAry == fImg)
                //                {
                //
                //                }
                //                else if (flagTypeOfAry == fAudio)
                //                {
                //
                //                }
                //                else if (flagTypeOfAry == fSignImg)
                //                {
                //
                //                }
                [dictLocal setObject:@"(null)"  forKey:jField_data];
                dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID] forKey:jField_id];
                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] forKey:jField_type];
//                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jName] forKey:JField_name];
                
                
                [[Singleton sharedInstance].aryMainForFields addObject:dictLocal];
//                NSLog(@"%@",dictLocal);
                [[Singleton sharedInstance].dictSendMainForFields setObject:dictLocal forKey:[NSString stringWithFormat:@"%d",j]];
            }
            else
            {
                NSMutableDictionary *dictLocal = [[NSMutableDictionary alloc] init];
                
                if ([currentString isEqualToString:@""])
                {
                    [dictLocal setObject:@"(null)"  forKey:jField_data];
                    dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
                }
                else
                {
                    if (flagTypeOfAry == fOther)
                    {
                        [dictLocal setObject:currentString  forKey:jField_data];
                    }
                    
                }
                ////////////////////////////////////////////
                //                if (flagTypeOfAry == fOther)
                //                {
                //                    [dictLocal setObject:@"(null)"  forKey:jField_data];
                //                    dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
                //                }
                //                else
                if (flagTypeOfAry == fMulti)
                {
                    aryChoices = [[NSMutableArray alloc] initWithArray:[dictSelectedChoices allValues]];
                    if ([aryChoices count]>0)
                    {
                        choicesStr = [Utilities addingArraysForMultiSelection:aryChoices Key:jID];
                        [dictLocal setObject:choicesStr  forKey:jField_data];
                    }
                    else
                    {
                        [dictLocal setObject:@"(null)"  forKey:jField_data];
                        dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
                    }
                    
                }
                else if (flagTypeOfAry == fSingle)
                {
                    aryChoices = [[NSMutableArray alloc] initWithArray:[dictSelectedChoices allValues]];
                    if ([aryChoices count]>0)
                    {
                        choicesStr = [dictSelectedChoices valueForKey:jID];
                        [dictLocal setObject:choicesStr  forKey:jField_data];
                    }
                    else
                    {
                        [dictLocal setObject:@"(null)"  forKey:jField_data];
                        dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
                    }
                    
                }
                
                
                
                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID] forKey:jField_id];
                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] forKey:jField_type];
//                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jName] forKey:JField_name];
                
                
                
                
//                if ([[[Singleton sharedInstance].aryFields objectAtIndex:j] isEqual:[NSNull null]]) {
//                                          [dictLocal setObject:@"" forKey:JField_name];                                }
//                                    else
//                                    {
//                                        
//                                        [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jName] forKey:JField_name];
//                                        
//
//                                    }
               
                
                
//                if (!jName == [NSNull null]) {
//                    [dictLocal setObject:@"" forKey:JField_name];
//                }
//                else
//                                    {
//                                        
//                                        
//                                        [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jName] forKey:JField_name];
//                                }

                 //               for (NSArray * arr in aryFields) {
                    
                    //
                    
                    ////                    if ([[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jName] !== @"" ] || [[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jName]!= nil) {
                    
                    ////
                    
                    //                    if (![[arr valueForKey:jName] isEqual: @""] || [arr valueForKey:jName] != nil) {
                    
                    //
                    
                    //                        [dictLocal setObject:@"" forKey:JField_name];
                    
                    //
                    
                    //
                    
                    //                    }
                    
                    //                    else{
                    
                    //                        [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jName] forKey:JField_name];
                    
                    //                        
                    
                    //                    }
                    
                    //                    
                    
                    //
                    
                    //                }
                    
                    ////                else
                    
                    ////                {
                    
                    ////                    [dictLocal setObject:@"" forKey:JField_name];
                    
                    ////                }
                    
                    //////
                    

//                if ([[[Singleton sharedInstance].aryFields objectAtIndex:j] isEqual:jName]) {
//                    [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jName] forKey:JField_name];
//
//                }
//                else
//                {
//                    [dictLocal setObject:@"" forKey:JField_name];
//                }
                
                
                [[Singleton sharedInstance].aryMainForFields addObject:dictLocal];
                NSLog(@"%@",dictLocal);
                [[Singleton sharedInstance].dictSendMainForFields setObject:dictLocal forKey:[NSString stringWithFormat:@"%d",j]];
            }
                
//            if ([dictSelectedChoices count]>0)
//            {
//                if ([[dictSelectedChoices valueForKey:jID] isKindOfClass:[NSDictionary class]])
//                {
//                    if ([dictSelectedChoices valueForKey:jID])
//                    {
//                        NSLog(@"%@",[dictSelectedChoices valueForKey:jID]);
//                    }
//                }
//                else
//                {
//                    aryChoices = [[NSMutableArray alloc] initWithArray:[dictSelectedChoices allValues]];
//                    if ([aryChoices count]>0)
//                    {
//                        if ([[aryChoices objectAtIndex:0] valueForKey:jID])
//                        {
//                            [Utilities addingArraysForMultiSelection:aryChoices Key:jID];
//                        }
//                        
//                    }
//                 }
//            
//            
//              }
            
            
            
            
        }
        
        
//        NSLog(@"%@ = %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType],dictLocal);
        
//        [aryMainForFields addObject:dictLocal];
        
        

    }
    
    
    
    if (flagSaveSend == fSave)
    {
//        NSLog(@" ary fields %@",aryMainForFields);
        NSMutableDictionary *dictLast = [[NSMutableDictionary alloc] init];
        [dictLast setObject:formID forKey:jFormID];
        //    [dictLast setObject:aryMainForFields forKey:jFieldAry];
        [dictLast setObject:[Singleton sharedInstance].dictMainForFields forKey:jFieldAry];
        ///=========
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictLast
                                                           options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString;
        
        if (! jsonData)
        {}
        else
        {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//            NSLog(@"%@", jsonString);
            
            if([[UserInfo sharedInstance].companyType isEqualToString:@"1"])
            {
                [self setDbDataESaveData:jsonString];

            }
            else
                [self setDbDataSaveData:jsonString];

        }
    }
    else if (flagSaveSend == fSend)
    {
//#define jUser_id                     @"user_id"
//#define jUser_agent                  @"user_agent"
//#define jLongitude                   @"longitude"
//#define jLatitude                    @"latitude"
//#define jForm_id                     @"form_id"
        
        NSMutableDictionary *dictLast = [[NSMutableDictionary alloc] init];
        [dictLast setObject:[UserInfo sharedInstance].userID forKey:jUser_id];
        [dictLast setObject:formID forKey:jForm_id];
        [dictLast setObject:@"iPhone" forKey:jUser_agent];
        if(([LocationManager sharedInstance].latitude) && ([LocationManager sharedInstance].longitude) )
        {
            [dictLast setObject:[LocationManager sharedInstance].latitude forKey:jLatitude];
            [dictLast setObject:[LocationManager sharedInstance].longitude forKey:jLongitude];
        }
        else
        {
            [dictLast setObject:@"0.0" forKey:jLatitude];
            [dictLast setObject:@"0.0" forKey:jLongitude];
        }
        
        
        [dictLast setObject:[[Singleton sharedInstance].dictSendMainForFields allValues] forKey:jFields];
        
//        [[Singleton sharedInstance].aryMainForFields addObject:dictLocal];
//        [[Singleton sharedInstance].dictSendMainForFields setObject:dictLocal forKey:[NSString stringWithFormat:@"%d",j]];
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictLast
                                                   options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString;
        
        if (! jsonData)
        {}
        else
        {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//            NSLog(@"%@", jsonString);
            
            [self sendDataRequest:jsonString];
        }
    }
    else if (flagSaveSend == fNext)
    {
        
        if ([[Singleton sharedInstance].aryFields count]>0)
        {
            DynamicVC *dynamicVC;
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
            {
                dynamicVC = [[DynamicVC alloc] initWithNibName:@"DynamicVC" bundle:nil];
            }
            else
            {
                dynamicVC = [[DynamicVC alloc] initWithNibName:@"DynamicVC_iPad" bundle:nil];
            }
            
            dynamicVC.formID = formID;
            dynamicVC.formTitle = formTitle;
            dynamicVC.startAddControls = indBreak;
            [Utilities hudWasHidden:myHud];
            [self.navigationController pushViewController:dynamicVC animated:YES];
        }
    }

}
-(void)ESaveData:(int)flagSaveSend
{
    int flagTypeOfAry;
    //    NSMutableArray *aryMainForFields = [[NSMutableArray alloc] init];
    //    NSMutableDictionary *dictMainForFields = [[NSMutableDictionary alloc] init];
    NSString * choicesStr;
    
    for (int j = startAddControls; j< [[Singleton sharedInstance].aryFields count];j++ )
    {
        int i = j+1;
        NSMutableArray *aryChoices = [[NSMutableArray alloc] init];
        
        NSMutableDictionary *dictSelectedChoices = [[NSMutableDictionary alloc] init];
        NSString *currentString = @"";
        if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jText])//Text
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromTextField:self.view MyTag:i];
            if (currentString == nil) {
                currentString = @"";
            }
            if (currentString)
            {
                //                NSLog(@"Text = %@",currentString);
            }
            else
            {
                
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }
            //            NSLog(@"Text = %@",currentString);
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jNumber])//Number
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromTextField:self.view MyTag:i];
            if (currentString)
            {
                //                NSLog(@"Number = %@",currentString);
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }
            
            //            NSLog(@"Number = %@",currentString);
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jTextArea])//TextArea
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromTextView:self.view MyTag:i];
            if (currentString)
            {
                //                NSLog(@"Text Area = %@",currentString);
            }
            else
            {
                
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }
            
            //            NSLog(@"Text Area = %@",currentString);
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jCheckbox])//Multi Selection
        {
            flagTypeOfAry = fMulti;
            if ([[Singleton sharedInstance].dictMultiSelectedStrings valueForKey:[NSString stringWithFormat:@"%d",j]])
            {
                dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictMultiSelectedStrings valueForKey:[NSString stringWithFormat:@"%d",j]]];
                //                 NSLog(@"yes multi %@",dictSelectedChoices);
                currentString = @"";
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    //                    dictSelectedChoices = [[NSMutableDictionary alloc] init];
                    dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictMultiSelectedStrings valueForKey:[NSString stringWithFormat:@"%d",j]]];
                    currentString = @"";
                    //                     NSLog(@"Multi Empty = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictMultiSelectedStrings valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                }
            }
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jRadio])//Radio
        {
            flagTypeOfAry = fSingle;
            if ([[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]])
            {
                //                NSLog(@"Radio %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
                currentString =[[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]] valueForKey:jChoice];
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    //                    dictSelectedChoices = [[NSMutableDictionary alloc] init];
                    dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
                    currentString =[[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]] valueForKey:jChoice];
                    //                    NSLog(@"Radio Empty %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                }
            }
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jSelect])//Select
        {
            flagTypeOfAry = fSingle;
            if ([[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]])
            {
                //                NSLog(@"Radio %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]] ;
                currentString =[[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]] valueForKey:jChoice];
                
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    //                    dictSelectedChoices = [[NSMutableDictionary alloc] init];
                    dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
                    currentString =[[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]] valueForKey:jChoice];
                    //                    NSLog(@"Radio Empty %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                }
            }
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jSection])//Section
        {
            flagTypeOfAry = fOther;
            currentString = [[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle];
            if (!currentString)
            {
                currentString = @"";
            }
            //            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
            //            {
            //               [Utilities simpleOkAlertBox:avTitleError Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
            //            }
            //            else
            //            {
            //                 NSLog(@"save");
            //            }
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jPage])//Page
        {
            //            if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
            //            {
            //                [Utilities simpleOkAlertBox:avTitleError Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
            //            }
            //            else
            //            {
            //                NSLog(@"save");
            NSMutableDictionary *dictLocal = [[NSMutableDictionary alloc] init];
            [dictLocal setObject:dictSelectedChoices forKey:jSelectedChoices];
            [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID] forKey:jID];
            [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle] forKey:jTitle];
            [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] forKey:jType];
            if ([currentString isEqualToString:@""])
            {
                [dictLocal setObject:@"(null)"  forKey:jFieldData];
                dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
            }
            else
            {
                [dictLocal setObject:currentString  forKey:jFieldData];
            }
            
            [[Singleton sharedInstance].dictMainForFields setObject:dictLocal forKey: [[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]];
            break;
            //            }
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jShortname])//Shortname
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromTextField:self.view MyTag:i];
            if (currentString)
            {
                //                NSLog(@"Shortname = %@",currentString);
                //                if ([Utilities validateFirstAndLastNameCharsOnly:currentString])
                //                {
                //                    ///save
                //                }
                //                else
                //                {
                //                    [Utilities simpleOkAlertBox:avTitleError Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisNotValid]];
                //                }
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }
            //           NSLog(@"Shortname = %@",currentString);
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jSignature])//Sign
        {
            flagTypeOfAry = fSignImg;
            if ([[Singleton sharedInstance].dictSingnContainer valueForKey:[NSString stringWithFormat:@"%d",j]])
            {
                //                NSLog(@"image = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
                currentString = [[Singleton sharedInstance].dictSingnContainer valueForKey:[NSString stringWithFormat:@"%d",j]];
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    //                    NSLog(@"image Empty = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                    //                    dictSelectedChoices = [[NSMutableDictionary alloc] init];
                    dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
                    currentString = @"";
                }
            }
            //            if ([[Singleton sharedInstance].dictImageContainer valueForKey:[NSString stringWithFormat:@"%d",j]])
            //            {
            //                //                NSLog(@"image = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
            //                dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
            //                currentString = [[Singleton sharedInstance].dictImageContainer valueForKey:[NSString stringWithFormat:@"%d",j]];
            //            }
            //            else
            //            {
            //                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
            //                {
            //                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
            //                    currentString = @"";
            //                    return;
            //                }
            //                else
            //                {
            //                    //                    NSLog(@"image Empty = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
            //                    //                    dictSelectedChoices = [[NSMutableDictionary alloc] init];
            //                    dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
            //                    currentString = @"";
            //                }
            //            }
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jImage])//Image
        {
            flagTypeOfAry = fImg;
            if ([[Singleton sharedInstance].dictImageContainer valueForKey:[NSString stringWithFormat:@"%d",j]])
            {
                //                NSLog(@"image = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
                currentString = [[Singleton sharedInstance].dictImageContainer valueForKey:[NSString stringWithFormat:@"%d",j]];
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    //                    NSLog(@"image Empty = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                    //                    dictSelectedChoices = [[NSMutableDictionary alloc] init];
                    dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
                    currentString = @"";
                }
            }
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jAudio])//Audio
        {
            flagTypeOfAry = fAudio;
            if ([[Singleton sharedInstance].dictAudio valueForKey:[NSString stringWithFormat:@"%d",j]])
            {
                //                NSLog(@"image = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
                currentString = [[Singleton sharedInstance].dictAudio valueForKey:[NSString stringWithFormat:@"%d",j]];
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    //                    NSLog(@"image Empty = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]]);
                    //                    dictSelectedChoices = [[NSMutableDictionary alloc] init];
                    dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:[NSString stringWithFormat:@"%d",j]]];
                    currentString = @"";
                }
            }
            
            //            if ([[Singleton sharedInstance].dictAudio valueForKey:[NSString stringWithFormat:@"%d",j]])
            //            {
            ////                NSLog(@"Audio = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictAudio valueForKey:[NSString stringWithFormat:@"%d",j]]]);
            //                dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictAudio valueForKey:[NSString stringWithFormat:@"%d",j]]];
            //                currentString = [[Singleton sharedInstance].dictAudio valueForKey:[NSString stringWithFormat:@"%d",j]];
            //            }
            //            else
            //            {
            //                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
            //                {
            //                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
            //                    currentString = @"";
            //                    return;
            //                }
            //                else
            //                {
            ////                    dictSelectedChoices = [[NSMutableDictionary alloc] init];
            //                    dictSelectedChoices = [[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictAudio valueForKey:[NSString stringWithFormat:@"%d",j]]];
            //                    currentString = @"";
            ////                     NSLog(@"Audio = %@",[[NSMutableDictionary alloc] initWithDictionary:[[Singleton sharedInstance].dictAudio valueForKey:[NSString stringWithFormat:@"%d",j]]]);
            //                }
            //            }
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jAddress])//Address
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromTextField:self.view MyTag:i];
            if (currentString)
            {
                //                NSLog(@"Address = %@",currentString);
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }
            
            //            NSLog(@"Address = %@",currentString);
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jDate])//Date
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromButton:self.view MyTag:i];
            if ([currentString isEqualToString:@"   Set Date"])
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    //                    currentString = @"\"\"";
                    currentString = @"";
                }
            }
            else
            {
                currentString = [Utilities stringFromButton:self.view MyTag:i];
                currentString = [currentString stringByReplacingOccurrencesOfString:@"   " withString:@""];
            }
            //            NSLog(@"Date = %@",currentString);
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jEmail])//Email
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromTextField:self.view MyTag:i];
            if (currentString)
            {
                if ([Utilities validateEmailWithString:currentString])
                {
                    //save for json
                }
                else
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisNotValid]];
                    currentString = @"";
                    return;
                }
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }
            
            //            NSLog(@"Email = %@",[Utilities stringFromTextField:self.view MyTag:i]);
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jTime])//Time
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromButton:self.view MyTag:i];
            if ([currentString isEqualToString:@"   Set Time"])
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }
            else
            {
                currentString = [Utilities stringFromButton:self.view MyTag:i];
                currentString = [currentString stringByReplacingOccurrencesOfString:@"   " withString:@""];
            }
            //            NSLog(@"Time = %@",currentString);
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jPhone])//Phone
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromTextField:self.view MyTag:i];
            if (currentString)
            {
                
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }
            //            NSLog(@"Phone = %@",currentString);
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jURL])//URL
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromTextField:self.view MyTag:i];
            if (currentString)
            {
                
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }
            //            NSLog(@"URL = %@",currentString);
            
        }
        else if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] isEqualToString:jMoney])//Money
        {
            flagTypeOfAry = fOther;
            currentString = [Utilities stringFromTextField:self.view MyTag:i];
            if (currentString)
            {
                
            }
            else
            {
                if ([[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jIs_required] boolValue])
                {
                    [Utilities simpleOkAlertBox:avWarning Body:[NSString stringWithFormat:@"%@ %@",[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle],avMsgisRequiredToSubmitTheForm]];
                    currentString = @"";
                    return;
                }
                else
                {
                    currentString = @"";
                }
            }
            //            NSLog(@"Money = %@",currentString);
        }
        
        if (flagSaveSend == fSave)
        {
            NSMutableDictionary *dictLocal = [[NSMutableDictionary alloc] init];
            [dictLocal setObject:dictSelectedChoices forKey:jSelectedChoices];
            [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID] forKey:jID];
            [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle] forKey:jTitle];
            [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] forKey:jType];
            if ([currentString isEqualToString:@""])
            {
                [dictLocal setObject:@"(null)"  forKey:jFieldData];
                dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
            }
            else
            {
                [dictLocal setObject:currentString  forKey:jFieldData];
            }
            //            [dictMainForFields setObject:dictLocal forKey: [[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]];
            //            [[Singleton sharedInstance].dictLocal setObject:dictSelectedChoices forKey:jSelectedChoices];
            //            [[Singleton sharedInstance].dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID] forKey:jID];
            //            [[Singleton sharedInstance].dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle] forKey:jTitle];
            //            [[Singleton sharedInstance].dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] forKey:jType];
            //            if ([currentString isEqualToString:@""])
            //            {
            //                [[Singleton sharedInstance].dictLocal setObject:@"(null)"  forKey:jFieldData];
            //                [Singleton sharedInstance].dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:[Singleton sharedInstance].dictLocal]];
            //            }
            //            else
            //            {
            //                [[Singleton sharedInstance].dictLocal setObject:currentString  forKey:jFieldData];
            //            }
            
            [[Singleton sharedInstance].dictMainForFields setObject:dictLocal forKey: [[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]];
        }
        else if (flagSaveSend == fNext)
        {
            
            //            [[Singleton sharedInstance].dictLocal setObject:dictSelectedChoices forKey:jSelectedChoices];
            //            [[Singleton sharedInstance].dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID] forKey:jID];
            //            [[Singleton sharedInstance].dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle] forKey:jTitle];
            //            [[Singleton sharedInstance].dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] forKey:jType];
            //            if ([currentString isEqualToString:@""])
            //            {
            //                [[Singleton sharedInstance].dictLocal setObject:@"(null)"  forKey:jFieldData];
            //                [Singleton sharedInstance].dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:[Singleton sharedInstance].dictLocal]];
            //            }
            //            else
            //            {
            //                [[Singleton sharedInstance].dictLocal setObject:currentString  forKey:jFieldData];
            //            }
            NSMutableDictionary *dictLocal = [[NSMutableDictionary alloc] init];
            [dictLocal setObject:dictSelectedChoices forKey:jSelectedChoices];
            [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID] forKey:jID];
            [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jTitle] forKey:jTitle];
            [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] forKey:jType];
            if ([currentString isEqualToString:@""])
            {
                [dictLocal setObject:@"(null)"  forKey:jFieldData];
                dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
            }
            else
            {
                [dictLocal setObject:currentString  forKey:jFieldData];
            }
            
            [[Singleton sharedInstance].dictMainForFields setObject:dictLocal forKey: [[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID]];
            
            ////send
            if ( (flagTypeOfAry == fImg) || (flagTypeOfAry == fAudio) || (flagTypeOfAry == fSignImg) )
            {
                NSMutableDictionary *dictLocal = [[NSMutableDictionary alloc] init];
                
                //                if (flagTypeOfAry == fImg)
                //                {
                //
                //                }
                //                else if (flagTypeOfAry == fAudio)
                //                {
                //
                //                }
                //                else if (flagTypeOfAry == fSignImg)
                //                {
                //
                //                }
                [dictLocal setObject:@"(null)"  forKey:jField_data];
                dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID] forKey:jField_id];
                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] forKey:jField_type];
                //                 [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jName] forKey:JField_name];
                
                
                [[Singleton sharedInstance].aryMainForFields addObject:dictLocal];
                //                NSLog(@"%@",dictLocal);
                [[Singleton sharedInstance].dictSendMainForFields setObject:dictLocal forKey:[NSString stringWithFormat:@"%d",j]];
                
            }
            else
            {
                NSMutableDictionary *dictLocal = [[NSMutableDictionary alloc] init];
                
                if ([currentString isEqualToString:@""] || currentString == nil)
                {
                    [dictLocal setObject:@"(null)"  forKey:jField_data];
                    dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
                }
                else
                {
                    if (flagTypeOfAry == fOther)
                    {
                        [dictLocal setObject:currentString  forKey:jField_data];
                    }
                    
                }
                if (flagTypeOfAry == fMulti)
                {
                    aryChoices = [[NSMutableArray alloc] initWithArray:[dictSelectedChoices allValues]];
                    if ([aryChoices count]>0)
                    {
                        choicesStr = [Utilities addingArraysForMultiSelection:aryChoices Key:jID];
                        [dictLocal setObject:choicesStr  forKey:jField_data];
                    }
                    else
                    {
                        [dictLocal setObject:@"(null)"  forKey:jField_data];
                        dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
                    }
                    
                }
                else if (flagTypeOfAry == fSingle)
                {
                    aryChoices = [[NSMutableArray alloc] initWithArray:[dictSelectedChoices allValues]];
                    if ([aryChoices count]>0)
                    {
                        choicesStr = [dictSelectedChoices valueForKey:jID];
                        [dictLocal setObject:choicesStr  forKey:jField_data];
                    }
                    else
                    {
                        [dictLocal setObject:@"(null)"  forKey:jField_data];
                        dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
                    }
                    
                }
                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID] forKey:jField_id];
                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] forKey:jField_type];
                //                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jName] forKey:JField_name];
                
                
                
                [[Singleton sharedInstance].aryMainForFields addObject:dictLocal];
                //                NSLog(@"%@",dictLocal);
                [[Singleton sharedInstance].dictSendMainForFields setObject:dictLocal forKey:[NSString stringWithFormat:@"%d",j]];
                //====
                
            }
        }
        else if (flagSaveSend == fSend)
        {
            if ( (flagTypeOfAry == fImg) || (flagTypeOfAry == fAudio) || (flagTypeOfAry == fSignImg) )
            {
                
                //=====
                NSMutableDictionary *dictLocal = [[NSMutableDictionary alloc] init];
                
                //                if (flagTypeOfAry == fImg)
                //                {
                //
                //                }
                //                else if (flagTypeOfAry == fAudio)
                //                {
                //
                //                }
                //                else if (flagTypeOfAry == fSignImg)
                //                {
                //
                //                }
                [dictLocal setObject:@"(null)"  forKey:jField_data];
                dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID] forKey:jField_id];
                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] forKey:jField_type];
                //                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jName] forKey:JField_name];
                
                
                [[Singleton sharedInstance].aryMainForFields addObject:dictLocal];
                //                NSLog(@"%@",dictLocal);
                [[Singleton sharedInstance].dictSendMainForFields setObject:dictLocal forKey:[NSString stringWithFormat:@"%d",j]];
            }
            else
            {
                NSMutableDictionary *dictLocal = [[NSMutableDictionary alloc] init];
                
                if ([currentString isEqualToString:@""])
                {
                    [dictLocal setObject:@"(null)"  forKey:jField_data];
                    dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
                }
                else
                {
                    if (flagTypeOfAry == fOther)
                    {
                        [dictLocal setObject:currentString  forKey:jField_data];
                    }
                    
                }
                ////////////////////////////////////////////
                //                if (flagTypeOfAry == fOther)
                //                {
                //                    [dictLocal setObject:@"(null)"  forKey:jField_data];
                //                    dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
                //                }
                //                else
                if (flagTypeOfAry == fMulti)
                {
                    aryChoices = [[NSMutableArray alloc] initWithArray:[dictSelectedChoices allValues]];
                    if ([aryChoices count]>0)
                    {
                        choicesStr = [Utilities addingArraysForMultiSelection:aryChoices Key:jID];
                        [dictLocal setObject:choicesStr  forKey:jField_data];
                    }
                    else
                    {
                        [dictLocal setObject:@"(null)"  forKey:jField_data];
                        dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
                    }
                    
                }
                else if (flagTypeOfAry == fSingle)
                {
                    aryChoices = [[NSMutableArray alloc] initWithArray:[dictSelectedChoices allValues]];
                    if ([aryChoices count]>0)
                    {
                        choicesStr = [dictSelectedChoices valueForKey:jID];
                        [dictLocal setObject:choicesStr  forKey:jField_data];
                    }
                    else
                    {
                        [dictLocal setObject:@"(null)"  forKey:jField_data];
                        dictLocal = [[NSMutableDictionary alloc] initWithDictionary:[Utilities NewDictionarySimpleReplacingNSNullWithEmptyNSStringMutable:dictLocal]];
                    }
                    
                }
                
                
                
                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jID] forKey:jField_id];
                [dictLocal setObject:[[[Singleton sharedInstance].aryFields objectAtIndex:j] valueForKey:jType] forKey:jField_type];
                
                
                [[Singleton sharedInstance].aryMainForFields addObject:dictLocal];
                NSLog(@"%@",dictLocal);
                [[Singleton sharedInstance].dictSendMainForFields setObject:dictLocal forKey:[NSString stringWithFormat:@"%d",j]];
            }
            
            
        }
        
    }
    
    
    
    if (flagSaveSend == fSave)
    {
        //        NSLog(@" ary fields %@",aryMainForFields);
        NSMutableDictionary *dictLast = [[NSMutableDictionary alloc] init];
        [dictLast setObject:formID forKey:jFormID];
        //    [dictLast setObject:aryMainForFields forKey:jFieldAry];
        [dictLast setObject:[Singleton sharedInstance].dictMainForFields forKey:jFieldAry];
        ///=========
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictLast
                                                           options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString;
        
        if (! jsonData)
        {}
        else
        {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            //            NSLog(@"%@", jsonString);
            
            if ([[UserInfo sharedInstance].companyType isEqualToString:@"1"]) {
                [self setDbDataESaveData:jsonString];
            }
            else
                [self setDbDataSaveData:jsonString];
            
            [self setDbDataESaveData:jsonString];
            FormsTableVCViewController * frm = [[FormsTableVCViewController alloc]init];
            [[Singleton sharedInstance].aryTableList objectAtIndex:frm.selectedInd];
            
        }
    }
    else if (flagSaveSend == fSend)
    {
        //#define jUser_id                     @"user_id"
        //#define jUser_agent                  @"user_agent"
        //#define jLongitude                   @"longitude"
        //#define jLatitude                    @"latitude"
        //#define jForm_id                     @"form_id"
        
        NSMutableDictionary *dictLast = [[NSMutableDictionary alloc] init];
        [dictLast setObject:[UserInfo sharedInstance].userID forKey:jUser_id];
        [dictLast setObject:formID forKey:jForm_id];
        [dictLast setObject:@"iPhone" forKey:jUser_agent];
        if(([LocationManager sharedInstance].latitude) && ([LocationManager sharedInstance].longitude) )
        {
            [dictLast setObject:[LocationManager sharedInstance].latitude forKey:jLatitude];
            [dictLast setObject:[LocationManager sharedInstance].longitude forKey:jLongitude];
        }
        else
        {
            [dictLast setObject:@"0.0" forKey:jLatitude];
            [dictLast setObject:@"0.0" forKey:jLongitude];
        }
        
        
        [dictLast setObject:[[Singleton sharedInstance].dictSendMainForFields allValues] forKey:jFields];
        
        //        [[Singleton sharedInstance].aryMainForFields addObject:dictLocal];
        //        [[Singleton sharedInstance].dictSendMainForFields setObject:dictLocal forKey:[NSString stringWithFormat:@"%d",j]];
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictLast
                                                           options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString;
        
        if (! jsonData)
        {}
        else
        {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            //            NSLog(@"%@", jsonString);
            
            [self sendDataRequest:jsonString];
        }
    }
    else if (flagSaveSend == fNext)
    {
        
        if ([[Singleton sharedInstance].aryFields count]>0)
        {
            DynamicVC *dynamicVC;
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
            {
                dynamicVC = [[DynamicVC alloc] initWithNibName:@"DynamicVC" bundle:nil];
            }
            else
            {
                dynamicVC = [[DynamicVC alloc] initWithNibName:@"DynamicVC_iPad" bundle:nil];
            }
            
            dynamicVC.formID = formID;
            dynamicVC.formTitle = formTitle;
            dynamicVC.startAddControls = indBreak;
            [Utilities hudWasHidden:myHud];
            [self.navigationController pushViewController:dynamicVC animated:YES];
        }
    }
    
}

#pragma mark - DB get set

// first save that form

- (void) saveFormForEform : (NSString*)str // created by shoaib
{
    if ([[Singleton sharedInstance].aryTableList objectAtIndex:_selectedInd])
    {
        FormsListDTO *formsListObj = [[Singleton sharedInstance].aryTableList objectAtIndex:_selectedInd];
        
        [self deleteDbEForm]; // so that in-view duplicate avoided.
        
        EForm *formDTO = [[EForm alloc] init];
        formDTO.formID = formsListObj.formID;
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        
        NSDictionary *fields = [json valueForKey:@"fields"];
        NSArray *keys = [fields allKeys];
        NSString *file = @"";
        NSString *title = @"";
        for (int i = 0; i<[keys count]; i++) {
            NSDictionary *dic = [fields valueForKey:[keys objectAtIndex:i]];
            if (dic) {
                if ([dic valueForKey:@"title"])
                {
                    if ([[dic valueForKey:@"title"] isEqualToString:@"File Number"])
                    {
                        if ([dic valueForKey:@"fieldData"])
                        {
                            file = [dic valueForKey:@"fieldData"];
                            break;
                        }
                    }
                }
            }
        }
        
        NSDate *date = [NSDate date];
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"MM-dd-yyyy"];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        [dict setObject:file forKey:@"fileName"];
        
        if (_isSavedForm) {
            json = [NSJSONSerialization JSONObjectWithData:[formsListObj.title dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];

            title = [json objectForKey:@"formName"];
        }
        else
            title = formsListObj.title;
        
        
        [dict setObject:title forKey:@"formName"];
        [dict setObject:[formater stringFromDate:date] forKey:@"fileDate"];
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        
        if (jsonData)
        {
            formDTO.formTitle = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        
        
//        title = [title stringByAppendingString:[NSString stringWithFormat:@"(%@)",[formater stringFromDate:date]]];
        
        
//        formDTO.formTitle = [NSString stringWithFormat:@"%@ %@",formsListObj.title,title];
        
        formDTO.formKey = [NSString stringWithFormat:@"%li",(long)key];
        
        formDTO.formCounter = @"0"; // counter identify later
        
        formDTO.json = [self createJson:[Singleton sharedInstance].aryFields];
        [self setDbEForm:formDTO];
        
    }
}

-(void)setDbEForm:(EForm*)eFormObj
{
    FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
    [db insertEFrom:eFormObj];
    
}

-(NSString*)createJson:(NSMutableArray*)ary
{
    NSMutableDictionary *dictLast = [[NSMutableDictionary alloc] init];
    [dictLast setObject:ary forKey:jFieldAry];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictLast
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString = @"";
    
    if (! jsonData)
    {
        //jsonString = @"";
    }
    else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@", jsonString);
        
        return jsonString;
    }
    return @"";
}

-(void)setDbDataSaveData:(NSString*)jSon
{
    FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
    LocalFormDataDTO *localFormDataObj = [[LocalFormDataDTO alloc] init];
    localFormDataObj.formID = formID;
    localFormDataObj.json = jSon;
    
    if ([db insertIntoSaveFormData:localFormDataObj])
    {
        [Utilities simpleOkAlertBox:avSuccess Body:avMsgDataSavedSuccessfully];
    }
    else
    {
        [Utilities simpleOkAlertBox:avWarning Body:avMsgUnableToSaveData];
    }
//    [self getDbData];
//    localFormDataObj = nil;
}

-(void)setDbDataESaveData:(NSString*)jSon
{
    FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
    LocalEFormData *localEFormDataObj = [[LocalEFormData alloc] init];
    localEFormDataObj.formID = formID;
    localEFormDataObj.json = jSon;
    localEFormDataObj.formKey = [NSString stringWithFormat:@"%li",(long)key];
    
    [self saveFormForEform:jSon];
    
    if ([db insertIntoESaveFormData:localEFormDataObj])
    {
        [Utilities simpleOkAlertBox:avSuccess Body:avMsgDataSavedSuccessfully];
    }
    else
    {
        [Utilities simpleOkAlertBox:avWarning Body:avMsgUnableToSaveData];
    }
    //    [self getDbData];
    //    localFormDataObj = nil;
}

-(void)getDbData
{
    FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
//    LocalFormDataDTO *localFormDataObj = [[LocalFormDataDTO alloc] init];
    LocalFormDataDTO *localFormDataObj = [db getSaveFormData:formID];
//    localFormDataObj = [db getInBite:formID];
//    NSLog(@"%@ ",localFormDataObj.formID);
//    NSLog(@"%@ ",localFormDataObj.json);
}
-(void)deleteDbData: (NSString*)myFormID
{
    FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
    LocalFormDataDTO *localFormDataObj = [db getSaveFormData:myFormID];
    if (localFormDataObj.json)
    {
        FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
        [db deleteSaveFormData:myFormID];
    }


}

- (void)deleteDBEformData // added by shoaib
{
    FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
    EForm *form = [[Singleton sharedInstance].aryTableList objectAtIndex:_selectedInd];
    
    [db deleteESaveFormData:form.formID key:form.formKey];
}

-(void)deleteDbEForm // added by shoaib
{
    FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
    EForm *form = [[Singleton sharedInstance].aryTableList objectAtIndex:_selectedInd];
    if (form.formKey) {
        
        [db deleteESaveFormData:form.formID key:form.formKey];
        [db deteEForm:form.formID key:form.formKey];
        
    }
}


#pragma mark Call Api

-(void)sendDataRequest:(NSString *)jSon
{
    if([Utilities connected])
    {
        myHud = [[MBProgressHUD alloc] init];
        if ((sendImageDone == 1) && (sendSignImageDone == 1) && (sendAudioDone == 1))
        {
            sendIndex = 0;
            sendImageDone = 1;
            sendSignImageDone = 1;
            sendAudioDone = 1;
            [Utilities hudWasHidden:myHud];
            [Utilities simpleOkAlertBox:avWarning Body:avMsgFormIsAlreadyUploded];

        }
        else
        {
            
            [Utilities showHudOnView:self.view HUDObj:myHud labelText:hudHead detailLabelText:hudDetail dimBackGround:YES];
            
            NSArray *data = [[NSArray alloc] initWithObjects:jSon, nil];
            
            NSArray  *keys = [[NSArray alloc] initWithObjects:@"form_answer", nil];
            
            [[sendRequests sharedInstance] sendRequestWithUrl:data Keys:keys MyURL:[NSString stringWithFormat:@"%@%@",liveBaseUrl , FormsAnswerUrl]delegate:self requestCompleteHandler:@selector(sendDataRequestComplete:)requestFailHandler:@selector(sendDataRequestFailed:)];
        }
        
    }
    else
    {
        //        [Utilities hudWasHidden:myHud];
        [Utilities simpleOkAlertBox:avWarning Body:avMsgInternetConnectionNotAvaliable];
    }
    
    
    
}
-(void)sendDataRequestComplete:(NSDictionary *)data
{
    if([[data   valueForKey:jStatus] isEqualToString:jFailure])
    {
        [Utilities hudWasHidden:myHud];
        [Utilities simpleOkAlertBox:avTitleError Body:[data valueForKey:@"error"]];
    }
    else if([[data   valueForKey:jStatus] isEqualToString:jSuccess])
    {
//        [Utilities hudWasHidden:myHud];
        [Singleton sharedInstance].entity_id = [data valueForKey:jEntity_id];
        if ([[Singleton sharedInstance].dictImageContainer count] > 0)
        {
            sendIndex = 0;
            sendImageDone = 0;
            sendSignImageDone = 0;
            sendAudioDone = 0;
            [self sendImagesData];
        }
        else if ([[Singleton sharedInstance].dictSingnContainer count] > 0)
        {
            sendIndex = 0;
            sendImageDone = 1;
            sendSignImageDone = 0;
            sendAudioDone = 0;
            [self sendSignImagesData];
        }
        else if ([[Singleton sharedInstance].dictAudio count] > 0)
        {
            sendIndex = 0;
            sendImageDone = 1;
            sendSignImageDone = 1;
            sendAudioDone = 0;
            [self sendAudioData];
        }
        else
        {
            sendIndex = 0;
            sendImageDone = 1;
            sendSignImageDone = 1;
            sendAudioDone = 1;
            
            if ([[UserInfo sharedInstance].companyType isEqualToString:@"1"]) {
                if (!_isSavedForm) {
                    [self SaveData:fSave];
                }
            }
            else
            {
                [self deleteDbData:formID];
            }
            
            [Utilities hudWasHidden:myHud];
            [Utilities simpleOkAlertBox:avSuccess Body:avMsgFormUplodedSuss];
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];


        }
    }
}
-(void)sendDataRequestFailed:(NSError*)error
{
    [Utilities hudWasHidden:myHud];
//    NSLog(@"login fail due to: %@", [error localizedDescription]);
//    NSLog(@"login fail due to: %d",[error code]);
    if ([error code] == 400)
    {
        NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:[error userInfo]];
//        NSLog(@"%@",[dict valueForKey:@"error"]);
        NSString *msg = [dict valueForKey:@"error"];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:avTitleError message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:avTitleError message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    
    
}

#pragma mark - Upload image
-(void)sendImagesData
{
//    sendIndex;
    if ((sendIndex+1) <= [[Singleton sharedInstance].dictImageContainer count])
    {
         
        [self uploadImage:[[[Singleton sharedInstance].dictImageContainer allValues] objectAtIndex:sendIndex] UserID:[UserInfo sharedInstance].userID FormID:formID EntityID:[Singleton sharedInstance].entity_id FieldID:[[Singleton sharedInstance].dictImageContainerID valueForKey:[[[Singleton sharedInstance].dictImageContainer allValues] objectAtIndex:sendIndex]]];
    }
//    else if ([[Singleton sharedInstance].dictSingnContainer count]>0)
//    {
//        sendIndex = 0;
//        sendImageDone = 1;
//        sendSignImageDone = 0;
//        sendAudioDone = 0;
//        [self sendSignImagesData];
//    }
//    else if ([[Singleton sharedInstance].dictAudio count]>0)
//    {
//        sendIndex = 0;
//        sendImageDone = 1;
//        sendSignImageDone = 1;
//        sendAudioDone = 0;
//        [self sendAudioData];
//    }
//    else
//    {
//        sendIndex = 0;
//        sendImageDone = 1;
//        sendSignImageDone = 1;
//        sendAudioDone = 1;
//        [Utilities hudWasHidden:myHud];
//        [Utilities simpleOkAlertBox:@"Success" Body:@"Form uploaded successfully."];
//    }

}
#pragma mark - Upload Sign Image
-(void)sendSignImagesData
{
    if ((sendIndex+1) <= [[Singleton sharedInstance].dictSingnContainer count])
    {
        [self uploadImage:[[[Singleton sharedInstance].dictSingnContainer allValues] objectAtIndex:sendIndex] UserID:[UserInfo sharedInstance].userID FormID:formID EntityID:[Singleton sharedInstance].entity_id FieldID:[[Singleton sharedInstance].dictSingnContainerID valueForKey:[[[Singleton sharedInstance].dictSingnContainer allValues] objectAtIndex:sendIndex]]];
    }
//    else if ([[Singleton sharedInstance].dictAudio count]>0)
//    {
//        sendIndex = 0;
//        sendImageDone = 1;
//        sendSignImageDone = 1;
//        sendAudioDone = 0;
//        [self sendAudioData];
//    }
//    else
//    {
//        sendIndex = 0;
//        sendImageDone = 1;
//        sendSignImageDone = 1;
//        sendAudioDone = 1;
//        [Utilities hudWasHidden:myHud];
//        [Utilities simpleOkAlertBox:@"Success" Body:@"Form uploaded successfully."];
//    }

}
#pragma mark - Upload Audio
-(void)sendAudioData 
{
    if ((sendIndex+1) <= [[Singleton sharedInstance].dictAudio count])
    {
        [self uploadAudio:[[[Singleton sharedInstance].dictAudio allValues] objectAtIndex:sendIndex] UserID:[UserInfo sharedInstance].userID FormID:formID EntityID:[Singleton sharedInstance].entity_id FieldID:[[Singleton sharedInstance].dictAudioID valueForKey:[[[Singleton sharedInstance].dictAudio allValues] objectAtIndex:sendIndex]]];
    }
//    else
//    {
//        sendIndex = 0;
//        sendImageDone = 1;
//        sendSignImageDone = 1;
//        sendAudioDone = 1;
//        [Utilities hudWasHidden:myHud];
//        [Utilities simpleOkAlertBox:avSuccess Body:avMsgFormUplodedSuss];
//    }

}
-(void)uploadAudio:(NSString*)filePath UserID:(NSString*)userID FormID:(NSString*)iformID EntityID:(NSString*)entityID FieldID:(NSString*)fieldID
{

    NSURL *audiourl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",liveBaseUrl , FormsAnswerAudioUrl]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:audiourl];
    //NSData *postData = [NSData dataWithContentsOfURL:[NSURL URLWithString:filePath]];
    NSData *postData = [[NSData alloc] initWithContentsOfFile:filePath];
    [request setPostValue:userID forKey:@"user_id"];
    [request setPostValue:iformID forKey:@"form_id"];
    [request setPostValue:entityID forKey:@"entity_id"];
    [request setPostValue:fieldID forKey:@"field_id"];
    
    //SoundPath is your audio url path of NSDocumentDirectory.
    [request addData:postData withFileName:@"myAudio.caf" andContentType:@"audio/caf" forKey:@"audio"];

    
    
    [request setDelegate:self];
    [request setTimeOutSeconds:3600];
    [request setUserInfo:[NSDictionary dictionaryWithObject:@"UploadAudio" forKey:@"requestType"]];
    NSLog(@"Uploading Audio...");
    [request startSynchronous];
//    NSLog(@"responseStatusCode %i",[request responseStatusCode]);
//    NSLog(@"responseString %@",[request responseString]);
}
-(void)uploadImage:(NSString*)path UserID:(NSString*)userID FormID:(NSString*)iformID EntityID:(NSString*)entityID FieldID:(NSString*)fieldID
{

    NSURL *url = [[NSURL alloc] initWithString:path];
    
    typedef void (^ALAssetsLibraryAssetForURLResultBlock)(ALAsset *asset);
    typedef void (^ALAssetsLibraryAccessFailureBlock)(NSError *error);
    NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",liveBaseUrl , FormsAnswerImageUrl]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url1];
    [request setDelegate:self];
    
    [request setPostValue:userID forKey:@"user_id"];
    [request setPostValue:formID forKey:@"form_id"];
    [request setPostValue:entityID forKey:@"entity_id"];
    [request setPostValue:fieldID forKey:@"field_id"];
    
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset){
        
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
        UIImage *myImage;
        
        if (iref){
            //long size = [myasset defaultRepresentation].size;
            myImage = [UIImage imageWithCGImage:iref scale:[rep scale] orientation:(UIImageOrientation)[rep orientation]];
            //upload the image
            NSData *imageData = UIImageJPEGRepresentation(myImage,0.1);
            if (imageData)
            {
                [request setData:imageData withFileName:@"myphoto.jpg" andContentType:@"image/jpeg" forKey:@"image"];
                [request setTimeOutSeconds:3600];
                [request setUserInfo:[NSDictionary dictionaryWithObject:@"UploadImage" forKey:@"requestType"]];
                NSLog(@"Uploading Image...");
                [request startSynchronous];
            }
            
        }
        else
        {
           
           
            imagePickerVC = [[ImagePickerVC alloc]init];
        myImage  = [imagePickerVC getImage];
            
            
            
        
            NSData *imageData = UIImageJPEGRepresentation(myImage,0.1);
            if (imageData)
            {
                [request setData:imageData withFileName:@"myphoto.jpg" andContentType:@"image/jpeg" forKey:@"image"];
                [request setTimeOutSeconds:3600];
                [request setUserInfo:[NSDictionary dictionaryWithObject:@"UploadImage" forKey:@"requestType"]];
                NSLog(@"Uploading Image...");
                [request startSynchronous];
            }
            

        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        [Utilities simpleOkAlertBox:avTitleError Body:@"Unable to find image.This image is deleted or moved some where else."];
    };
    
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:url
                   resultBlock:resultblock
     
                  failureBlock:failureblock];
   
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    
    if ([[request.userInfo objectForKey:@"requestType"] isEqualToString:@"imageAmazon"]) {
        NSLog(@"Sent to Amazon: success");
        return;
    }
    if ([[request.userInfo objectForKey:@"requestType"] isEqualToString:@"audioAmazon"]) {
        NSLog(@"Sent to Amazon: success");
        return;
    }
    
    
    NSDictionary *responseDict;
    
    NSString *responseString = [request responseString];
    
    
    responseString = [responseString stringByReplacingOccurrencesOfString: @"<string xmlns=\"http://tempuri.org/\">"
                                                               withString:@""];
    
    responseString = [responseString stringByReplacingOccurrencesOfString: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                                                               withString:@""];
    
    responseString = [responseString stringByReplacingOccurrencesOfString: @"</string>"
                                                               withString:@""];
    
    responseString = [responseString stringByReplacingOccurrencesOfString: @"\r\n" withString:@""];
    
    
    NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError*error;
    responseDict = [NSJSONSerialization JSONObjectWithData:data //1
                                                   options:0
                                                     error:&error];
    
    
    
    //    NSLog(@"%@", responseString);
//    NSLog(@"image response = %@", responseDict);
//    [Utilities hudWasHidden:myHud];
    
//    sendImageDone;
//    int sendSignImageDone;
//    int sendAudioDone;
    
    //NSLog(@"responcedictstatus----%@",[responseDict   valueForKey:jStatus]);
    if ([[responseDict valueForKey:@"status"] isEqualToString:@"Success"])
    {
//        [Utilities simpleOkAlertBox:@"Success" Body:@"Image uploaded successfully."];
        if ([[request.userInfo objectForKey:@"requestType"] isEqualToString:@"UploadImage"]) {
            NSLog(@"Image Uploaded");
            NSString *resimageName = [responseDict valueForKey:@"imageName"];
            NSString *resformId = [responseDict valueForKey:@"formId"];
            NSString *resentityId = [responseDict valueForKey:@"entityId"];
            NSString *resfieldId = [responseDict valueForKey:@"fieldId"];
            
            NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",liveBaseUrl , FormsAnswerImageAmazon]];
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url1];
            [request setDelegate:self];
            
            //[request setPostValue:userID forKey:@"user_id"];
            [request setPostValue:resformId forKey:@"form_id"];
            [request setPostValue:resentityId forKey:@"entity_id"];
            [request setPostValue:resfieldId forKey:@"field_id"];
            [request setPostValue:resimageName forKey:@"imageName"];
            
            [request setUserInfo:[NSDictionary dictionaryWithObject:@"imageAmazon" forKey:@"requestType"]];
            NSLog(@"Sending to amazon...");
            [request startSynchronous];
            
            
        }
        if ([[request.userInfo objectForKey:@"requestType"] isEqualToString:@"UploadAudio"]) {
            NSLog(@"Audio Uploaded");
            NSString *resaudioName = [responseDict valueForKey:@"audioName"];
            NSString *resformId = [responseDict valueForKey:@"formId"];
            NSString *resentityId = [responseDict valueForKey:@"entityId"];
            NSString *resfieldId = [responseDict valueForKey:@"fieldId"];
            
            NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",liveBaseUrl , FormsAnswerAudioAmazon]];
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url1];
            [request setDelegate:self];
            
            //[request setPostValue:userID forKey:@"user_id"];
            [request setPostValue:resformId forKey:@"form_id"];
            [request setPostValue:resentityId forKey:@"entity_id"];
            [request setPostValue:resfieldId forKey:@"field_id"];
            [request setPostValue:resaudioName forKey:@"audioName"];
            
            [request setUserInfo:[NSDictionary dictionaryWithObject:@"audioAmazon" forKey:@"requestType"]];
            NSLog(@"Sending to amazon...");
            [request startSynchronous];
            
            
        }
        
        
        sendIndex++;
        if (sendSignImageDone == 1) // updated by shoaib
        {
            if ((sendIndex+1) >[[Singleton sharedInstance].dictAudio count])
            {
                sendIndex = 0;
                sendImageDone = 1;
                sendSignImageDone = 1;
                sendAudioDone = 1;
                
                if ([[UserInfo sharedInstance].companyType isEqualToString:@"1"]) {
                    if (!_isSavedForm) {
                        [self SaveData:fSave];
                    }
                }
                else
                {
                    [self deleteDbData:formID];
                }
                [Utilities hudWasHidden:myHud];
                [Utilities simpleOkAlertBox:avSuccess Body:avMsgFormUplodedSuss];
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            }
            else
            {
                [self sendAudioData];
            }
        }
        else if (sendImageDone == 1) // updated by shoaib
        {
            if ((sendIndex+1) >[[Singleton sharedInstance].dictSingnContainer count])
            {
                sendSignImageDone = 1;
                sendIndex = 0;
                if ([[Singleton sharedInstance].dictAudio count]>0)
                {
                    [self sendAudioData];
                }
                else
                {
                    sendIndex = 0;
                    sendImageDone = 1;
                    sendSignImageDone = 1;
                    sendAudioDone = 1;
                    
                    if ([[UserInfo sharedInstance].companyType isEqualToString:@"1"]) {
                        if (!_isSavedForm) {
                            [self SaveData:fSave];
                        }
                    }
                    else
                    {
                        [self deleteDbData:formID];
                    }
                    
                    [Utilities hudWasHidden:myHud];
                    [Utilities simpleOkAlertBox:avSuccess Body:avMsgFormUplodedSuss];
                    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
                }
            }
            else
            {
                [self sendSignImagesData];
            }
        }
        else if (sendImageDone == 0) // updated by shoaib
        {
            if ((sendIndex+1) >[[Singleton sharedInstance].dictImageContainer count])
            {
                sendImageDone = 1;
                sendIndex = 0;
                if ([[Singleton sharedInstance].dictSingnContainer count]>0)
                {
                    [self sendSignImagesData];
                }
                else if ([[Singleton sharedInstance].dictAudio count]>0)
                {
                    sendSignImageDone = 1;
                    [self sendAudioData];
                }
                else
                {
                    sendIndex = 0;
                    sendImageDone = 1;
                    sendSignImageDone = 1;
                    sendAudioDone = 1;

                    if ([[UserInfo sharedInstance].companyType isEqualToString:@"1"]) {
                        if (!_isSavedForm) {
                            [self SaveData:fSave];
                        }
                    }
                    else
                    {
                        [self deleteDbData:formID];
                    }
                    
                    [Utilities hudWasHidden:myHud];
                    [Utilities simpleOkAlertBox:avSuccess Body:avMsgFormUplodedSuss];
                    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
                }
            }
            else
            {
                [self sendImagesData];
            }
        }
        
    }
    else if([[responseDict   valueForKey:jStatus] isEqualToString:jFailure])
    {
        [Utilities hudWasHidden:myHud];
        [Utilities simpleOkAlertBox:avTitleError Body:[responseDict valueForKey:@"error"]];
    }
    else
    {
        sendIndex = 0;
        sendImageDone = 0;
        sendSignImageDone = 0;
        sendAudioDone = 0;
        [Utilities hudWasHidden:myHud];
        
        [Utilities simpleOkAlertBox:avTitleError Body:avMsgUnableToUploadFiles];
        
    }
    //        if (responseDict)
    //        {
    //            NSError *errorr = [ [NSError alloc] initWithDomain:@"Error" code:400 userInfo:responseDict];
    ////            NSLog(@"No response from delegate");
    //        }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [Utilities hudWasHidden:myHud];
    NSError *error = [request error];
//    NSLog(@"%@",error);
    if ([error code] == 400)
    {
        NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:[error userInfo]];
//        NSLog(@"%@",[dict valueForKey:@"error"]);
        NSString *msg = [dict valueForKey:@"error"];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
}
@end