//
//  MultiSelectionViewController.h
//  ByCloudForms
//
//  Created by Fahad Arshad on 6/13/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utilities.h"
#import "Singleton.h"

@protocol MultiSelectionViewProtocol <NSObject>
@optional

-(void)btnCancelMultiClicked:(NSInteger)row;
-(void)btnDoneMultiClicked:(NSInteger)row;
-(void)selectedValues:(NSString*)str;

@end
@interface MultiSelectionViewController : UIViewController <UITabBarDelegate,UITableViewDataSource>
{
    id <MultiSelectionViewProtocol> delegate;
    __weak IBOutlet UIButton *btnCancel;
    __weak IBOutlet UIButton *btnDone;
    __weak IBOutlet UITableView *tblMultiSelection;
    NSMutableDictionary *selectedDict;
    NSMutableArray *aryData;
    NSString *fieldID;
    UIBarButtonItem *btnCancelNav,*btnDoneNav;
}
@property(nonatomic,strong) id delegate;
@property(nonatomic,strong) NSMutableArray *aryData;
@property(nonatomic,strong) NSMutableArray *aryDataSelected;
@property(nonatomic,strong) NSMutableDictionary *selectedDict;
@property (readwrite, strong) NSString *fieldID;
//- (IBAction)btnCancel:(id)sender;
//- (IBAction)btnDone:(id)sender;


@end
