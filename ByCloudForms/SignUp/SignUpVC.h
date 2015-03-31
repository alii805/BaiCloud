//
//  SignUpVC.h
//  ByCloudForms
//
//  Created by Fahad Arshad on 6/19/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utilities.h"
#import "MBProgressHUD.h"
#import "sendRequests.h"
#import "FormsTableVCViewController.h"

@interface SignUpVC : UIViewController <UITextFieldDelegate>
{
    UIBarButtonItem *btnRegisterNav,*btnBackNav;
    MBProgressHUD *myHud;
}
@end
