//
//  FormsTableVCViewController.h
//  ByCloudForms
//
//  Created by Fahad Arshad on 6/19/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicVC.h"
#import "Utilities.h"
#import "MBProgressHUD.h"
#import "sendRequests.h"
#import "UserInfo.h"
#import "FormsListDTO.h"
#import "FMDBDataAccess.h"
#import "LocalFormDataDTO.h"
#import "FormDTO.h"
#import "EFormListDTO.h"


@interface FormsTableVCViewController : UIViewController <UITabBarDelegate,UITableViewDataSource>
{
    UIBarButtonItem *btnLogOutNav;
    UIBarButtonItem *btnAboutNav;
    __weak IBOutlet UITableView *tblFormsView;
    MBProgressHUD *myHud;
    int selectedInd;
    NSString *currentFormID;
    BOOL isApiCalled;
    UIButton * saveFilesButton;

}
@property(nonatomic,strong)IBOutlet UIButton * saveFilesButton;
@property(nonatomic,assign) int selectedInd;
#pragma mark Call Api
-(void)sendFormListRequest;
-(void)formListComplete:(NSMutableDictionary *)data;
-(void)formListRequestFailed:(NSError*)error;
-(void)readWriteData:(NSMutableDictionary *)data;

@end
