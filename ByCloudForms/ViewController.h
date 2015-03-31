//
//  ViewController.h
//  ByCloudForms
//
//  Created by Fahad Arshad on 6/11/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicVC.h"
#import "Utilities.h"
#import "MBProgressHUD.h"
#import "sendRequests.h"
#import "SignUpVC.h"
#import "FormsTableVCViewController.h"
#import "UserInfo.h"

#import "DatePickerVC.h"
#import "ImagePickerVC.h"

@interface ViewController : UIViewController <UITextFieldDelegate>
{
    UIBarButtonItem *btnSignUpNav,*btnSignInNav;
    __weak IBOutlet UITextField *txtUsername;
    __weak IBOutlet UITextField *txtPassword;
    MBProgressHUD *myHud;
}


-(void)setTitleBarItems;
@end
