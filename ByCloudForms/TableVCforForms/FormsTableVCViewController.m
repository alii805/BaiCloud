//
//  FormsTableVCViewController.m
//  ByCloudForms
//
//  Created by Fahad Arshad on 6/19/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import "FormsTableVCViewController.h"

@interface FormsTableVCViewController ()

@end

@implementation FormsTableVCViewController
@synthesize saveFilesButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if ([[UserInfo sharedInstance].companyType isEqualToString:@"2"]) {
        btnLogOutNav = [[UIBarButtonItem alloc]
                        initWithTitle:@"Log Out"
                        style:UIBarButtonItemStyleBordered
                        target:self
                        action:@selector(btnLogOut)];
        self.navigationItem.rightBarButtonItem = btnLogOutNav;
        
        btnLogOutNav = [[UIBarButtonItem alloc]
                        initWithTitle:@"About"
                        style:UIBarButtonItemStyleBordered
                        target:self
                        action:@selector(aboutVersion)];
        self.navigationItem.leftBarButtonItem = btnLogOutNav;
    }
    else{
        
        btnLogOutNav = [[UIBarButtonItem alloc]
                        initWithTitle:@"Log Out"
                        style:UIBarButtonItemStyleBordered
                        target:self
                        action:@selector(btnLogOut)];
        self.navigationItem.rightBarButtonItem = btnLogOutNav;
        
        btnLogOutNav = [[UIBarButtonItem alloc]
                        initWithTitle:@"About"
                        style:UIBarButtonItemStyleBordered
                        target:self
                        action:@selector(aboutVersion)];
        self.navigationItem.leftBarButtonItem = btnLogOutNav;
        
        saveFilesButton= [UIButton buttonWithType:UIButtonTypeSystem];
        [saveFilesButton setFrame:CGRectMake(50, 0, 44, 44)];
        [saveFilesButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [saveFilesButton setTitle:@"SaveFiles" forState:UIControlStateNormal];
        [saveFilesButton addTarget:self action:@selector(saveFiles) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.titleView = saveFilesButton;
        
    }
    
    //    [Singleton sharedInstance].aryTEableList = [[NSMutableArray alloc]initWithObjects:@"Shoaib",@"Khan",nil];
    
   }
- (void)btnLogOut
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)aboutVersion
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"About" message:@"Version 2.0" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];

}
-(void)saveFiles
{
    saveFilesButton.selected = !saveFilesButton.selected;
    [self removeDataFromSingleton];
    if ((saveFilesButton.selected == YES))
    {
        [self readFromDataBase];
        
    }
    else
    {
        saveFilesButton.enabled = NO;
        [self sendFormListRequest];
        isApiCalled = NO;
        
    }
    [tblFormsView reloadData];

}
-(void)backButton
{
    btnLogOutNav = [[UIBarButtonItem alloc]
                    initWithTitle:@"Log Out"
                    style:UIBarButtonItemStyleBordered
                    target:self
                    action:@selector(btnLogOut)];
    self.navigationItem.rightBarButtonItem = btnLogOutNav;
    
    btnLogOutNav = [[UIBarButtonItem alloc]
                    initWithTitle:@"About"
                    style:UIBarButtonItemStyleBordered
                    target:self
                    action:@selector(aboutVersion)];
    self.navigationItem.leftBarButtonItem = btnLogOutNav;
    
    saveFilesButton= [UIButton buttonWithType:UIButtonTypeSystem];
    [saveFilesButton setFrame:CGRectMake(50, 0, 44, 44)];
    [saveFilesButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [saveFilesButton setTitle:@"SaveFiles" forState:UIControlStateNormal];
    [saveFilesButton addTarget:self action:@selector(saveFiles) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = saveFilesButton;
    [tblFormsView reloadData];

}
-(void)viewWillAppear:(BOOL)animated
{
//    self.navigationController.navigationBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
    [self removeDataFromSingleton];
    if ((saveFilesButton.selected == YES))
    {
        [self readFromDataBase];
    }
    else
    {
        [self sendFormListRequest];
        isApiCalled = NO;
    }
    
    
}
-(void)removeDataFromSingleton
{
    [[Singleton sharedInstance].dictAudio removeAllObjects];
    [[Singleton sharedInstance].dictAudioID removeAllObjects];
    [[Singleton sharedInstance].dictImageContainer removeAllObjects];
    [[Singleton sharedInstance].dictImageContainerID removeAllObjects];
    [[Singleton sharedInstance].dictSingnContainer removeAllObjects];
    [[Singleton sharedInstance].dictSingnContainerID removeAllObjects];
    [[Singleton sharedInstance].dictMultiSelectedStrings removeAllObjects];
    [[Singleton sharedInstance].dictSingleSelectedIDs removeAllObjects];
    [[Singleton sharedInstance].dictMainForFields removeAllObjects];
    [[Singleton sharedInstance].dictLocal removeAllObjects];
    [[Singleton sharedInstance].dictSendMainForFields removeAllObjects];
    [[Singleton sharedInstance].aryMainForFields removeAllObjects];
    [[Singleton sharedInstance].aryTableList removeAllObjects];
//    [[Singleton sharedInstance].aryTEableList removeAllObjects];
    [Singleton sharedInstance].entity_id = @"";
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ((saveFilesButton.selected == YES)) {
//        NSArray* newArray = [NSArray arrayWithArray:oldArray]
//        [[Singleton sharedInstance].aryTEableList  arrayByAddingObjectsFromArray:[Singleton sharedInstance].aryTableList];
//        NSLog(@"arry chamge%@",[Singleton sharedInstance].aryTEableList);
//         [[Singleton sharedInstance].aryTableList removeAllObjects];
//      [[s]]
//        LocalEFormData *localEFormDataObj;
//        [[Singleton sharedInstance].aryTableList addObject:localEFormDataObj];
        
        
        if ([[Singleton sharedInstance].aryTableList count]>0)
        {
            return [[Singleton sharedInstance].aryTableList count];
        }
        return 0;
    }
    else
    {
    if ([[Singleton sharedInstance].aryTableList count]>0)
    {
        return [[Singleton sharedInstance].aryTableList count];
    }
    return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath // updated by shoaib
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.imageView.image = [UIImage imageNamed:@"dumyFormImage.png"];
    
    FormsListDTO *formsListObj = [[Singleton sharedInstance].aryTableList objectAtIndex:indexPath.row];
    if (saveFilesButton.selected) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:[formsListObj.title dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        NSString *formFileDate = [NSString stringWithFormat:@"%@ %@(%@)",[json objectForKey:@"formName"],[json objectForKey:@"fileName"],[json objectForKey:@"fileDate"]];
        cell.textLabel.text = formFileDate;
        cell.textLabel.minimumScaleFactor = 0.5;
        cell.textLabel.adjustsLetterSpacingToFitWidth = YES;
    }
    else
        cell.textLabel.text = formsListObj.title;
    
    return cell;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    // updated by shoaib
{

    FormsListDTO *formsListObj = [[Singleton sharedInstance].aryTableList objectAtIndex:indexPath.row];
    selectedInd = (int)indexPath.row;
    currentFormID = formsListObj.formID;
    
    if (saveFilesButton.selected) {
        // saved forms
        [self sendFormRequestByFormDeatil:formsListObj];
    }
    else
        [self sendFormByIdRequest:formsListObj.formID];
    
}

#pragma mark Call Api
-(void)sendFormListRequest
{
    myHud = [[MBProgressHUD alloc] init];
    [Utilities showHudOnView:self.view HUDObj:myHud labelText:hudHead detailLabelText:hudDetail dimBackGround:YES];
    
    if([Utilities connected])
    {
        if ([[UserInfo sharedInstance].userID length] > 0)
        {
            NSArray *data = [[NSArray alloc] initWithObjects:[UserInfo sharedInstance].userID, nil];
            NSArray  *keys = [[NSArray alloc] initWithObjects:@"user_id", nil];
            
            [[sendRequests sharedInstance] sendRequestWithUrl:data Keys:keys MyURL:[NSString stringWithFormat:@"%@%@",liveBaseUrl , FormsListUrl]delegate:self requestCompleteHandler:@selector(formListComplete:)requestFailHandler:@selector(formListRequestFailed:)];
        }
        else
        {
        }
    }
    else
    {
        //NSString* finalPath = [[NSBundle mainBundle] pathForResource:@"FormListPList" ofType:@"plist"];
        //NSMutableDictionary *dict =[[NSMutableDictionary alloc] init];
        //NSMutableDictionary *data =[[NSMutableDictionary alloc] init];
        //dict =  [NSDictionary dictionaryWithContentsOfFile:finalPath];
        NSMutableDictionary *dict  = [Utilities readFromPlist:nil and:@"FormListPList"];
//        NSLog(@"%@",dict);
        if (dict)
        {
            //data = [[NSMutableDictionary alloc] init];
            NSMutableDictionary *data = [dict valueForKey:@"dataArray" ];
            [self readWriteData:data];
        }
        saveFilesButton.enabled = YES;
    }
    
    
    
    
}
//-(void)sendEFormListRequest
//{
//    myHud = [[MBProgressHUD alloc] init];
//    [Utilities showHudOnView:self.view HUDObj:myHud labelText:hudHead detailLabelText:hudDetail dimBackGround:YES];
//    
//    if([Utilities connected])
//    {
//        if ([[UserInfo sharedInstance].userID length] > 0)
//        {
//            NSArray *data = [[NSArray alloc] initWithObjects:[UserInfo sharedInstance].userID, nil];
//            NSArray  *keys = [[NSArray alloc] initWithObjects:@"user_id", nil];
//            
//            [[sendRequests sharedInstance] sendRequestWithUrl:data Keys:keys MyURL:[NSString stringWithFormat:@"%@%@",liveBaseUrl , FormsListUrl]delegate:self requestCompleteHandler:@selector(EFormListComplete:)requestFailHandler:@selector(eFormListRequestFailed:)];
//        }
//        else
//        {
//        }
//    }
//    else
//    {
//        //NSString* finalPath = [[NSBundle mainBundle] pathForResource:@"FormListPList" ofType:@"plist"];
//        //NSMutableDictionary *dict =[[NSMutableDictionary alloc] init];
//        //NSMutableDictionary *data =[[NSMutableDictionary alloc] init];
//        //dict =  [NSDictionary dictionaryWithContentsOfFile:finalPath];
//        NSMutableDictionary *dict  = [Utilities readFromPlist:nil and:@"FormListPList"];
//        //        NSLog(@"%@",dict);
//        if (dict)
//        {
//            //data = [[NSMutableDictionary alloc] init];
//            NSMutableDictionary *data = [dict valueForKey:@"dataArray" ];
//            [self readEWriteData:data];
//        }
//    }
//    
//    
//    
//    
//}
//-(void)eFormListComplete:(NSMutableDictionary *)data
//{
//    [self readEWriteData:data];
//}
-(void)formListComplete:(NSMutableDictionary *)data
{
    [self readWriteData:data];
    saveFilesButton.enabled = YES;
}
-(void)formListRequestFailed:(NSError*)error
{
    [Utilities hudWasHidden:myHud];
//    NSLog(@"login fail due to: %@", [error localizedDescription]);
//    NSLog(@"login fail due to: %d",[error code]);
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
    saveFilesButton.enabled = YES;
}
//-(void)eFormListRequestFailed:(NSError*)error
//{
//    [Utilities hudWasHidden:myHud];
//    //    NSLog(@"login fail due to: %@", [error localizedDescription]);
//    //    NSLog(@"login fail due to: %d",[error code]);
//    if ([error code] == 400)
//    {
//        NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:[error userInfo]];
//        //        NSLog(@"%@",[dict valueForKey:@"error"]);
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
-(void)readWriteData:(NSMutableDictionary *)data
{
    if([[data   valueForKey:jStatus] isEqualToString:jFailure])
    {
        [Utilities hudWasHidden:myHud];
        [Utilities simpleOkAlertBox:avTitleError Body:[data valueForKey:@"error"]];
    }
    else if([[data   valueForKey:jStatus] isEqualToString:jSuccess])
    {
        [Utilities hudWasHidden:myHud];
        
        //saving in Plist
        [Utilities createPlist:FormListPList];
        [Utilities writeIntoPlist:data and:FormListPList];
        
        //NSString* finalPath = [[NSBundle mainBundle] pathForResource:FormListPList ofType:PListExt];
        //NSDictionary *dict =[[NSDictionary alloc] init];
        //NSDictionary *dict =  [NSDictionary dictionaryWithContentsOfFile:finalPath];
        
        NSDictionary *dict = [Utilities readFromPlist:nil and:FormListPList];
//        NSLog(@"%@",dict);
        if (dict)
        {
            //data = [[NSMutableDictionary alloc] init];
            data = [dict valueForKey:jDataArray ];
        }
        [[Singleton sharedInstance].aryTableList removeAllObjects];
        //        [Singleton sharedInstance].aryTableList = [[NSMutableArray alloc]init];
        for (int i = 0; i < [[data valueForKey:jForms] count]; i++)
        {
            FormsListDTO *formsListObj = [[FormsListDTO alloc] init];
            formsListObj.formID = [[[data valueForKey:jForms] objectAtIndex:i] valueForKey:jID];
            formsListObj.description = [[[data valueForKey:jForms] objectAtIndex:i] valueForKey:jDescription];
            formsListObj.title = [[[data valueForKey:jForms] objectAtIndex:i] valueForKey:jTitle];
            
            /*
//            formsListObj.field_name = [[[data valueForKey:jForms] objectAtIndex:i] valueForKey:JField_name];
//            if ([[data valueForKey:JField_name ]isEqual:[NSNull null]]) {
//                
//                  [data setObject:@"" forKey:JField_name];
//            }
//            else
//            {
//                formsListObj.field_name = [[[data valueForKey:jForms] objectAtIndex:i] valueForKey:JField_name];
//            }
            
//            formsListObj.counter = [data   valueForKey:jFormEditCount];
            */
            
            [[Singleton sharedInstance].aryTableList addObject:formsListObj];
            
        }
        
//        FormsListDTO *formsListObj = [[Singleton sharedInstance].aryTableList objectAtIndex:0];
//        NSLog(@"%@",formsListObj.description);
        
        [tblFormsView reloadData];
        
        
    }

}

- (void)readFromDataBase // written by shoaib
{
    NSMutableArray *forms = [self getDbEForm];
    
    [[Singleton sharedInstance].aryTableList removeAllObjects];
    //        [Singleton sharedInstance].aryTableList = [[NSMutableArray alloc]init];
    for (int i = 0; i < [forms count]; i++)
    {
        EForm *eFormObj = [forms objectAtIndex:i];
        FormsListDTO *formsListObj = [[FormsListDTO alloc] init];
        
//        NSString *json = eFormObj.json;
//        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
//        NSError* error;
//        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data
//                                                             options:kNilOptions
//                                                               error:&error];
        
        formsListObj.description = eFormObj.json;
        formsListObj.title = eFormObj.formTitle;
        formsListObj.formID = eFormObj.formID;
        formsListObj.counter = eFormObj.formCounter;
        formsListObj.formKey = eFormObj.formKey;
        
        [[Singleton sharedInstance].aryTableList addObject:formsListObj];
        
    }
    
    //        FormsListDTO *formsListObj = [[Singleton sharedInstance].aryTableList objectAtIndex:0];
    //        NSLog(@"%@",formsListObj.description);
    
    [tblFormsView reloadData];
    
}


#pragma mark Call Api for Form
-(void)sendFormByIdRequest:(NSString*)formID // updated by shoaib
{
    myHud = [[MBProgressHUD alloc] init];
    [Utilities showHudOnView:self.view HUDObj:myHud labelText:hudHead detailLabelText:hudDetail dimBackGround:YES];
    if([Utilities connected])
    {
        if ([[UserInfo sharedInstance].userID length] > 0)
        {
            NSArray *data = [[NSArray alloc] initWithObjects:[UserInfo sharedInstance].userID, formID,nil];
            NSArray  *keys = [[NSArray alloc] initWithObjects:@"user_id",@"form_id", nil];
            
            [[sendRequests sharedInstance] sendRequestWithUrl:data Keys:keys MyURL:[NSString stringWithFormat:@"%@%@",liveBaseUrl , FormsByIdUrl]delegate:self requestCompleteHandler:@selector(formByIdComplete:)requestFailHandler:@selector(formByIdRequestFailed:)];
        }
        else
        {
        }
    }
    else
    {
//        [Utilities hudWasHidden:myHud];
//        [Utilities simpleOkAlertBox:avWarning Body:avMsgInternetConnectionNotAvaliable];
        FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
        FormDTO *formObj = [db getForm:formID];
        if (formObj.formID)
        {
            //        [Singleton sharedInstance].aryFields = [[NSMutableArray alloc] initWithArray:formObj]
            NSData *data = [formObj.json dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error;
            NSMutableDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data //1
                                                                                options:0
                                                                                  error:&error];
            if (responseDict)
            {
                [Singleton sharedInstance].aryFields = [[NSMutableArray alloc] initWithArray:[responseDict valueForKey:jFieldAry]];
                if ([[Singleton sharedInstance].aryFields count]>0)
                {
                    DynamicVC *dynamicVC;
                    //FormsListDTO *formsListObj = [[FormsListDTO alloc] init];
                    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
                    {
                        dynamicVC = [[DynamicVC alloc] initWithNibName:@"DynamicVC" bundle:nil];
                    }
                    else
                    {
                        dynamicVC = [[DynamicVC alloc] initWithNibName:@"DynamicVC_iPad" bundle:nil];
                    }
                    
                    if ([[Singleton sharedInstance].aryTableList objectAtIndex:selectedInd])
                    {
                        FormsListDTO *formsListObj = [[Singleton sharedInstance].aryTableList objectAtIndex:selectedInd];
                        dynamicVC.formID = formsListObj.formID;
                        dynamicVC.formTitle = formsListObj.title;
                        dynamicVC.selectedInd = selectedInd;
                        dynamicVC.isSavedForm = NO;
                        
                    }
                    dynamicVC.screenName = @"Dynamic";
                    dynamicVC.startAddControls = 0;
                    [Utilities hudWasHidden:myHud];
                    [self.navigationController pushViewController:dynamicVC animated:YES];
                }
                else
                {
                    [Utilities hudWasHidden:myHud];
                }
            }
            if (error)
            {
//                NSLog(@"hahahahaha error in JSONSerialization %@",[error description]);
            }
            else
            {
                
            }
        }
    }
 
    
}

- (void) sendFormRequestByFormDeatil:(FormsListDTO *)formObj // creted by shoaib
{
    
    
    if (formObj.formID)
    {
        //        [Singleton sharedInstance].aryFields = [[NSMutableArray alloc] initWithArray:formObj]
        NSData *data = [formObj.description dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSMutableDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data //1
                                                                            options:0
                                                                              error:&error];
        if (responseDict)
        {
            [Singleton sharedInstance].aryFields = [[NSMutableArray alloc] initWithArray:[responseDict valueForKey:jFieldAry]];
            if ([[Singleton sharedInstance].aryFields count]>0)
            {
                DynamicVC *dynamicVC;
                //FormsListDTO *formsListObj = [[FormsListDTO alloc] init];
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
                {
                    dynamicVC = [[DynamicVC alloc] initWithNibName:@"DynamicVC" bundle:nil];
                }
                else
                {
                    dynamicVC = [[DynamicVC alloc] initWithNibName:@"DynamicVC_iPad" bundle:nil];
                }
                
                if ([[Singleton sharedInstance].aryTableList objectAtIndex:selectedInd])
                {
                    FormsListDTO *formsListObj = [[Singleton sharedInstance].aryTableList objectAtIndex:selectedInd];
                    dynamicVC.formID = formsListObj.formID;
                    dynamicVC.formTitle = formsListObj.title;
                    dynamicVC.selectedInd = selectedInd;
                    dynamicVC.isSavedForm = YES;
                }
                dynamicVC.screenName = @"Dynamic";
                dynamicVC.startAddControls = 0;
                [Utilities hudWasHidden:myHud];
                [self.navigationController pushViewController:dynamicVC animated:YES];
            }
            else
            {
                [Utilities hudWasHidden:myHud];
            }
        }
        if (error)
        {
            //                NSLog(@"hahahahaha error in JSONSerialization %@",[error description]);
        }
        else
        {
            
        }
    }
    
}

-(void)formByIdComplete:(NSMutableDictionary *)data
{
    isApiCalled = YES;
    [self readWriteFormData:data];
}
//-(void)eFormByIdComplete:(NSMutableDictionary *)data
//{
//    isApiCalled = YES;
//    [self readWriteEFormData:data];
//}
-(void)formByIdRequestFailed:(NSError*)error
{
    [Utilities hudWasHidden:myHud];
//    NSLog(@"login fail due to: %@", [error localizedDescription]);
//    NSLog(@"login fail due to: %d",[error code]);
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
//-(void)eFormByIdRequestFailed:(NSError*)error
//{
//    [Utilities hudWasHidden:myHud];
//    //    NSLog(@"login fail due to: %@", [error localizedDescription]);
//    //    NSLog(@"login fail due to: %d",[error code]);
//    if ([error code] == 400)
//    {
//        NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:[error userInfo]];
//        //        NSLog(@"%@",[dict valueForKey:@"error"]);
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
-(void)readWriteFormData:(NSMutableDictionary *)data
{
    
    if([[data   valueForKey:jStatus] isEqualToString:jFailure])
    {
        [Utilities hudWasHidden:myHud];
        [Utilities simpleOkAlertBox:avTitleError Body:[data valueForKey:@"error"]];
    }
    else if([[data   valueForKey:jStatus] isEqualToString:jSuccess])
    {
        
        if ([data valueForKey:jFormData])
        {
            
            [Singleton sharedInstance].aryFields = [[NSMutableArray alloc] initWithArray:[[data valueForKey:jFormData] valueForKey:jFields]];
//            NSLog(@" fahad = %@",[Singleton sharedInstance].aryFields);
            if ([[Singleton sharedInstance].aryFields count]>0)
            {
                DynamicVC *dynamicVC;
                //FormsListDTO *formsListObj = [[FormsListDTO alloc] init];
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                    dynamicVC = [[DynamicVC alloc] initWithNibName:@"DynamicVC" bundle:nil];
                } else {
                    dynamicVC = [[DynamicVC alloc] initWithNibName:@"DynamicVC_iPad" bundle:nil];
                }
                
                if ([[Singleton sharedInstance].aryTableList objectAtIndex:selectedInd])
                {
                    FormsListDTO *formsListObj = [[Singleton sharedInstance].aryTableList objectAtIndex:selectedInd];
                    dynamicVC.formID = formsListObj.formID;
                    dynamicVC.formTitle = formsListObj.title;
                    dynamicVC.selectedInd = selectedInd;
                    dynamicVC.isSavedForm = NO;
                    
                    if (isApiCalled == YES)
                    {
                        FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
                        //    LocalFormDataDTO *localFormDataObj = [[LocalFormDataDTO alloc] init];
                        FormDTO *formObj = [db getForm:formsListObj.formID];
                        if (formObj.formID)
                        {   
                            if ([[data   valueForKey:jFormEditCount] floatValue] > [formObj.formCounter floatValue])
                            {
                                [self deleteFormAnswerFromDb:formsListObj.formID];
                            }
//                            else if ([[data   valueForKey:jFormEditCount] floatValue] == [formObj.formCounter floatValue])
//                            {
//                                NSLog(@"equallll");
//                            }
                        }
                        
                    
                    }
                    FormDTO *formDTO = [[FormDTO alloc] init];
                    formDTO.formID = formsListObj.formID;
                    formDTO.formTitle = formsListObj.title;
                    if ([[data   valueForKey:jFormEditCount] floatValue])
                    {
                       formDTO.formCounter = [NSString stringWithFormat:@"%f",[[data   valueForKey:jFormEditCount] floatValue]];
                    }
                    else
                    {
                        formDTO.formCounter = @"0";
                    }
                    
                    formDTO.json = [self createJson:[Singleton sharedInstance].aryFields];
                    [self setDbForm:formDTO];
//                    //=======
//                    FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
//                    FormDTO *formObj = [db getForm:currentFormID];
//                    if (formObj.formID)
//                    {
//                        //        [Singleton sharedInstance].aryFields = [[NSMutableArray alloc] initWithArray:formObj]
//                        NSData *data = [formObj.json dataUsingEncoding:NSUTF8StringEncoding];
//                        NSError *error;
//                        NSMutableDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data //1
//                                                                                            options:0
//                                                                                              error:&error];
//                        if (responseDict)
//                        {
//                            [Singleton sharedInstance].aryFields = [[NSMutableArray alloc] initWithArray:[responseDict valueForKey:jFieldAry]];
//                            if ([[Singleton sharedInstance].aryFields count]>0)
//                            {
//                                DynamicVC *dynamicVC;
//                                FormsListDTO *formsListObj = [[FormsListDTO alloc] init];
//                                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//                                {
//                                    dynamicVC = [[DynamicVC alloc] initWithNibName:@"DynamicVC" bundle:nil];
//                                }
//                                else
//                                {
//                                    dynamicVC = [[DynamicVC alloc] initWithNibName:@"DynamicVC_iPad" bundle:nil];
//                                }
//                                
//                                if ([[Singleton sharedInstance].aryTableList objectAtIndex:selectedInd])
//                                {
//                                    formsListObj = [[Singleton sharedInstance].aryTableList objectAtIndex:selectedInd];
//                                    dynamicVC.formID = formsListObj.formID;
//                                    dynamicVC.formTitle = formsListObj.title;
//                                }
//                                dynamicVC.startAddControls = 0;
//                                [Utilities hudWasHidden:myHud];
//                                [self.navigationController pushViewController:dynamicVC animated:YES];
//                            }
//                            else
//                            {
//                                [Utilities hudWasHidden:myHud];
//                            }
//                        }
//                        if (error)
//                        {
//                            NSLog(@"hahahahaha error in JSONSerialization %@",[error description]);
//                        }
//                        else
//                        {
//                            
//                        }
//                        
//                    }
//                    
//                    //=======
                }
                
                [Utilities hudWasHidden:myHud];
                [self.navigationController pushViewController:dynamicVC animated:YES];
            }
            else
            {
                [Utilities hudWasHidden:myHud];
            }
        }
        else
        {
            [Utilities hudWasHidden:myHud];
        }
        
    }
    //===============
       
}
//-(void)readWriteEFormData:(NSMutableDictionary *)data
//{
//    
//    if([[data   valueForKey:jStatus] isEqualToString:jFailure])
//    {
//        [Utilities hudWasHidden:myHud];
//        [Utilities simpleOkAlertBox:avTitleError Body:[data valueForKey:@"error"]];
//    }
//    else if([[data   valueForKey:jStatus] isEqualToString:jSuccess])
//    {
//        
//        if ([data valueForKey:jFormData])
//        {
//            
//            [Singleton sharedInstance].aryFields = [[NSMutableArray alloc] initWithArray:[[data valueForKey:jFormData] valueForKey:jFields]];
//            //            NSLog(@" fahad = %@",[Singleton sharedInstance].aryFields);
//            if ([[Singleton sharedInstance].aryFields count]>0)
//            {
//                DynamicVC *dynamicVC;
//                //FormsListDTO *formsListObj = [[FormsListDTO alloc] init];
//                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//                    dynamicVC = [[DynamicVC alloc] initWithNibName:@"DynamicVC" bundle:nil];
//                } else {
//                    dynamicVC = [[DynamicVC alloc] initWithNibName:@"DynamicVC_iPad" bundle:nil];
//                }
//                
//                if ([[Singleton sharedInstance].aryTEableList objectAtIndex:selectedInd])
//                {
//                    EFormListDTO *eFormListDTO = [[Singleton sharedInstance].aryTEableList objectAtIndex:selectedInd];
//                    dynamicVC.formID = eFormListDTO.formID;
//                    dynamicVC.formTitle = eFormListDTO.title;
//                    
//                    if (isApiCalled == YES)
//                    {
//                        FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
//                        //    LocalFormDataDTO *localFormDataObj = [[LocalFormDataDTO alloc] init];
//                        EForm * eFormObj = [db getEForm:eFormListDTO.formID];
//                        if (eFormObj.formID)
//                        {
//                            if ([[data   valueForKey:jFormEditCount] floatValue] > [eFormObj.formCounter floatValue])
//                            {
//                                [self deleteFormAnswerEFromDb:eFormListDTO.formID];
//                            }
//                            //                            else if ([[data   valueForKey:jFormEditCount] floatValue] == [formObj.formCounter floatValue])
//                            //                            {
//                            //                                NSLog(@"equallll");
//                            //                            }
//                        }
//                        
//                        
//                    }
//                    EForm *eForm = [[EForm alloc] init];
//                    eForm.formID = eFormListDTO.formID;
//                    eForm.formTitle = eFormListDTO.title;
//                    if ([[data   valueForKey:jFormEditCount] floatValue])
//                    {
//                        eForm.formCounter = [NSString stringWithFormat:@"%f",[[data   valueForKey:jFormEditCount] floatValue]];
//                    }
//                    else
//                    {
//                        eForm.formCounter = @"0";
//                    }
//                    
//                    eForm.json = [self createJson:[Singleton sharedInstance].aryFields];
//                    [self setDbEForm:eForm];
//                    //                    //=======
//                    //                    FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
//                    //                    FormDTO *formObj = [db getForm:currentFormID];
//                    //                    if (formObj.formID)
//                    //                    {
//                    //                        //        [Singleton sharedInstance].aryFields = [[NSMutableArray alloc] initWithArray:formObj]
//                    //                        NSData *data = [formObj.json dataUsingEncoding:NSUTF8StringEncoding];
//                    //                        NSError *error;
//                    //                        NSMutableDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data //1
//                    //                                                                                            options:0
//                    //                                                                                              error:&error];
//                    //                        if (responseDict)
//                    //                        {
//                    //                            [Singleton sharedInstance].aryFields = [[NSMutableArray alloc] initWithArray:[responseDict valueForKey:jFieldAry]];
//                    //                            if ([[Singleton sharedInstance].aryFields count]>0)
//                    //                            {
//                    //                                DynamicVC *dynamicVC;
//                    //                                FormsListDTO *formsListObj = [[FormsListDTO alloc] init];
//                    //                                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//                    //                                {
//                    //                                    dynamicVC = [[DynamicVC alloc] initWithNibName:@"DynamicVC" bundle:nil];
//                    //                                }
//                    //                                else
//                    //                                {
//                    //                                    dynamicVC = [[DynamicVC alloc] initWithNibName:@"DynamicVC_iPad" bundle:nil];
//                    //                                }
//                    //
//                    //                                if ([[Singleton sharedInstance].aryTableList objectAtIndex:selectedInd])
//                    //                                {
//                    //                                    formsListObj = [[Singleton sharedInstance].aryTableList objectAtIndex:selectedInd];
//                    //                                    dynamicVC.formID = formsListObj.formID;
//                    //                                    dynamicVC.formTitle = formsListObj.title;
//                    //                                }
//                    //                                dynamicVC.startAddControls = 0;
//                    //                                [Utilities hudWasHidden:myHud];
//                    //                                [self.navigationController pushViewController:dynamicVC animated:YES];
//                    //                            }
//                    //                            else
//                    //                            {
//                    //                                [Utilities hudWasHidden:myHud];
//                    //                            }
//                    //                        }
//                    //                        if (error)
//                    //                        {
//                    //                            NSLog(@"hahahahaha error in JSONSerialization %@",[error description]);
//                    //                        }
//                    //                        else
//                    //                        {
//                    //                            
//                    //                        }
//                    //                        
//                    //                    }
//                    //                    
//                    //                    //=======
//                }
//                [Utilities hudWasHidden:myHud];
//                [self.navigationController pushViewController:dynamicVC animated:YES];
//            }
//            else
//            {
//                [Utilities hudWasHidden:myHud];
//            }
//        }
//        else
//        {
//            [Utilities hudWasHidden:myHud];
//        }
//        
//    }
//    //===============
//    
//}
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

#pragma mark - DB get set
-(void)setDbForm:(FormDTO*)formObj 
{
    FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
    [db insertForm:formObj];
//    if ([db insertForm:formObj])
//    {
//        [Utilities simpleOkAlertBox:avSuccess Body:avMsgDataSavedSuccessfully];
//    }
//    else
//    {
//        [Utilities simpleOkAlertBox:avWarning Body:avMsgUnableToSaveData];
//    }
//    [self getDbForm:formObj.formID];
    //    localFormDataObj = nil;
}
-(void)getDbForm:(NSString*)formID
{
    FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
    //    LocalFormDataDTO *localFormDataObj = [[LocalFormDataDTO alloc] init];
    FormDTO *formObj = [db getForm:formID];
    //    localFormDataObj = [db getInBite:formID];
    NSLog(@"%@ ",formObj.formID);
    NSLog(@"%@ ",formObj.json);
}
-(void)deleteDbForm:(NSString*)formID
{
    FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
    FormDTO *formObj = [db getForm:formID];
    if (formObj.formID)
    {
        FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
        [db deleteForm:formID];
    }
}
#pragma mark - DB deleteForm
-(void)deleteFormAnswerFromDb: (NSString*)myFormID
{
    FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
    [db deleteSaveFormData:myFormID];
}
#pragma mark - EDB get set
-(void)setDbEForm:(EForm*)eFormObj
{
    FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
    [db insertEFrom:eFormObj];
    
}
-(NSMutableArray*)getDbEForm // written by shoaib
{
    FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
    //    LocalFormDataDTO *localFormDataObj = [[LocalFormDataDTO alloc] init];
    NSMutableArray *forms = [db getEForm:nil];
    return forms;
    
}
-(void)deleteDbEForm:(NSString*)formID
{
    FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
    EForm *eFormObj = [db getEForm:formID];
    if (eFormObj.formID)
    {
        FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
//        [db deteEForm:formID];
    }
}
#pragma mark - DB deleteForm
-(void)deleteFormAnswerEFromDb: (NSString*)myFormID
{
    FMDBDataAccess *db = [[FMDBDataAccess alloc] init];
    [db insertIntoESaveFormData:myFormID];
}


@end