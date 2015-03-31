//
//  ViewController.m
//  ByCloudForms
//
//  Created by Fahad Arshad on 6/11/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import "ViewController.h"
#import "MultiSelectionViewController.h"
#import "FormsTableVCViewController.h"

@interface ViewController ()
{

}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setTitleBarItems];
//    txtUsername.text = @"fahad@lobiasoft.com";
    
//    txtUsername.text = @"muaz.ishfaq";
//    txtPassword.text = @"123456";
  
//    txtUsername.text = @"matloob";
//    txtPassword.text = @"123456";
    
//    txtUsername.text = @"";
//    txtPassword.text = @"";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - setTitleBarItems
-(void)setTitleBarItems
{
//    btnSignUpNav = [[UIBarButtonItem alloc]
//                    initWithTitle:@"Sign Up"
//                    style:UIBarButtonItemStyleBordered
//                    target:self
//                    action:@selector(btnSignUp)];
//    self.navigationItem.leftBarButtonItem = btnSignUpNav;
    self.navigationItem.hidesBackButton = YES;
    
    btnSignInNav = [[UIBarButtonItem alloc]
                  initWithTitle:@"Sign In"
                  style:UIBarButtonItemStyleBordered
                  target:self
                  action:@selector(btnLogin)];
    self.navigationItem.rightBarButtonItem = btnSignInNav;
   
    
    
}
- (void)btnSignUp
{
    SignUpVC *signUpVC;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        signUpVC = [[SignUpVC alloc] initWithNibName:@"SignUpVC" bundle:nil];
    }
    else
    {
        signUpVC = [[SignUpVC alloc] initWithNibName:@"SignUpVC_iPad" bundle:nil];
    }
    [self.navigationController pushViewController:signUpVC animated:YES];
}
- (void) btnLogin
{
    [self sendSignInRequest];
}

#pragma mark Text Field Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField tag] == 1)
    {
        [textField resignFirstResponder];
        [self sendSignInRequest];
    }
    else
    {
        [txtPassword becomeFirstResponder];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//    myTag = textField.tag;
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
    return true;
}

#pragma mark - touchesBegan
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [txtPassword resignFirstResponder];
    [txtUsername resignFirstResponder];
}
#pragma mark Call Api
-(void)sendSignInRequest
{
    if([Utilities connected])
    {
        if ( ([txtPassword.text length] <= 0 ) || ([txtUsername.text length] <= 0 ) )
        {
            [Utilities simpleOkAlertBox:avWarning Body:avMsgFieldsShouldBeFilled];
        }
        else
        {
            [txtUsername resignFirstResponder];
            [txtPassword resignFirstResponder];
            myHud = [[MBProgressHUD alloc] init];
            [Utilities showHudOnView:self.view HUDObj:myHud labelText:hudHead detailLabelText:hudDetail dimBackGround:YES];
            
            NSArray *data = [[NSArray alloc] initWithObjects:txtUsername.text,txtPassword.text, nil];
            
            NSArray  *keys = [[NSArray alloc] initWithObjects:@"username",@"password", nil];
            
            [[sendRequests sharedInstance] sendRequestWithUrl:data Keys:keys MyURL:[NSString stringWithFormat:@"%@%@",liveBaseUrl , SignInUrl]delegate:self requestCompleteHandler:@selector(signInComplete:)requestFailHandler:@selector(signInRequestFailed:)];
        }
    }
    else
    {
//        [Utilities hudWasHidden:myHud];
        [Utilities simpleOkAlertBox:avWarning Body:avMsgInternetConnectionNotAvaliable];
    }
    

   
}

-(void)signInComplete:(NSDictionary *)data
{
    NSLog(@"jStatus is %@",[data   valueForKey:jStatus]);
    if([[data   valueForKey:jStatus] isEqualToString:jFailure])
    {
        [Utilities hudWasHidden:myHud];
        [Utilities simpleOkAlertBox:avTitleError Body:[data valueForKey:@"error"]];
    }
    else if([[data   valueForKey:jStatus] isEqualToString:jSuccess])
    {
        [Utilities hudWasHidden:myHud];
        [UserInfo sharedInstance].companyID = [[data valueForKey:jUserInfo] valueForKey:jCompanyId];
        [UserInfo sharedInstance].companyName = [[data valueForKey:jUserInfo] valueForKey:jCompanyName];
        [UserInfo sharedInstance].groupID = [[data valueForKey:jUserInfo] valueForKey:jGroupId];
        [UserInfo sharedInstance].groupName = [[data valueForKey:jUserInfo] valueForKey:jGroupName];
        [UserInfo sharedInstance].userID = [[data valueForKey:jUserInfo] valueForKey:jID];
        [UserInfo sharedInstance].userName = [[data valueForKey:jUserInfo] valueForKey:jUserName];
        [UserInfo sharedInstance].companyType = [[data valueForKey:jUserInfo] valueForKey:jCompanyType];
        
        if ([[UserInfo sharedInstance].companyType isEqualToString:@"2"])  {
            
            
            NSLog(@"%@",[UserInfo sharedInstance].companyType);
        }
        
        
        FormsTableVCViewController *formsTableVCViewController;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            formsTableVCViewController = [[FormsTableVCViewController alloc] initWithNibName:@"FormsTableVCViewController" bundle:nil];
        } else {
            formsTableVCViewController = [[FormsTableVCViewController alloc] initWithNibName:@"FormsTableVCViewController_iPad" bundle:nil];
        }
        
        formsTableVCViewController.navigationController.navigationBar.hidden = YES;
        [self.navigationController pushViewController:formsTableVCViewController animated:YES];
        
        
        txtUsername.text = @"";
        txtPassword.text = @"";
//        NSUserDefaults *sessionID = [NSUserDefaults standardUserDefaults];
//        [sessionID setValue:[[data   valueForKey:@"userInfo"] valueForKey:@"session_id"] forKey:sessionIDKey];
//        model = [ModelLocator getInstance];
//        model.signinObj = [[SigninVO alloc] init];
//        model.signinObj.sessionId = [[data   valueForKey:@"userInfo"] valueForKey:@"session_id"];
//        NSLog(@"%@",model.signinObj.sessionId);
        
        //        NSLog(@"%@",model.signinObj.sessionId);
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //        HomeController *homeController = [[HomeController alloc] initWithNibName:@"HomeController" bundle:nil];
        //        [self.navigationController pushViewController:homeController animated:YES];
//        [defaults setValue:swNo forKey:leftViewApiCall];
//        if ([[defaults valueForKey:nsCategory] isEqualToString:nsCategoryALL])
//        {
//            HomeController *homeController = [[HomeController alloc] initWithNibName:@"HomeController" bundle:nil];
//            [self.navigationController pushViewController:homeController animated:YES];
//        }
//        else
//        {
//            HomeControllerWithoutMap *homeControllerWithoutMap = [[HomeControllerWithoutMap alloc] initWithNibName:@"HomeControllerWithoutMap" bundle:nil];
//            [self.navigationController pushViewController:homeControllerWithoutMap animated:YES];
//        }
        
    }
    
}
-(void)signInRequestFailed:(NSError*)error
{
    [Utilities hudWasHidden:myHud];
    NSLog(@"login fail due to: %@", [error localizedDescription]);
    NSLog(@"login fail due to: %d",[error code]);
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

#pragma mark - IBActions
- (IBAction)btnAction:(id)sender
{
//    MultiSelectionViewController *dynamicVC;
//
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        dynamicVC = [[MultiSelectionViewController alloc] initWithNibName:@"MultiSelectionViewController" bundle:nil];
//    } else {
//        dynamicVC = [[MultiSelectionViewController alloc] initWithNibName:@"MultiSelectionViewController_iPad" bundle:nil];
//    }
    
    DynamicVC *dynamicVC;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        dynamicVC = [[DynamicVC alloc] initWithNibName:@"DynamicVC" bundle:nil];
    } else {
        dynamicVC = [[DynamicVC alloc] initWithNibName:@"DynamicVC_iPad" bundle:nil];
    }
//    ImagePickerVC *dynamicVC;
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        dynamicVC = [[ImagePickerVC alloc] initWithNibName:@"ImagePickerVC" bundle:nil];
//        dynamicVC.flag = 0 ;
//        dynamicVC.myTag = @"0";
//    } else {
//        dynamicVC = [[ImagePickerVC alloc] initWithNibName:@"ImagePickerVC_iPad" bundle:nil];
//    }

    [self.navigationController pushViewController:dynamicVC animated:YES];
}




@end
