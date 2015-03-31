//
//  DynamicVC.h
//  ByCloudForms
//
//  Created by Fahad Arshad on 6/11/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerViewController.h"
#import "Utilities.h"
#import "AddComponents.h"
#import "BCF_Defines.h"
#import "MultiSelectionViewController.h"
#import "DatePickerVC.h"
#import "Singleton.h"
#import "ImagePickerVC.h"
#import "sendRequests.h"
#import "UserInfo.h"
#import "FMDBDataAccess.h"
#import "LocalFormDataDTO.h"
#import "FormDTO.h"
#import "AudioVC.h"
#import "FormsListDTO.h"
#import "UserInfo.h"
#import "SignaturePopoverViewController.h"
#import "AudioRecVC.h"
#import "ASIHTTPRequest.h"
#import "FormsTableVCViewController.h"
#import "LocationManager.h"
#import "ImagePickerVC.h"

@interface DynamicVC : UIViewController <pickerViewProtocol,MultiSelectionViewProtocol,pickerViewDateProtocol,UITextFieldDelegate,UITextViewDelegate>
{
    __weak IBOutlet UIView *viewHolderSubView;
    __weak IBOutlet UIScrollView *viwHolderScroll;
    NSInteger x,y;
    UITextField *txtField;
    UITextView *txtView;
    int txtCurrentfieldTag;
    int btnPickerTag;
    int btnDatePickerTag;
    int falgDate0Time1;
    int btnMultiSelectionTag;
    MBProgressHUD *myHud;
    NSString *formID;
    NSString *formTitle;
    NSArray *aryFields;
    NSString *screenName;
    int startAddControls;
    int indBreak;
    int sendIndex;
    int sendImageDone;
    int sendSignImageDone;
    int sendAudioDone;
    
    NSInteger key;
    
    
}
@property (strong, nonatomic) UITextField *txtField;
@property (strong, nonatomic) UITextView *txtView;
@property(nonatomic,strong)  PickerViewController *pickerViewController;
@property(nonatomic,strong)  DatePickerVC *datePickerVC;
@property (readwrite, strong) NSString *formID;
@property (readwrite, strong) NSString *formTitle;
@property (readwrite) int startAddControls;
@property (readwrite, strong) NSString *screenName;
@property(nonatomic,strong)  ImagePickerVC *imagePickerVC;

// Shoaib
@property (readwrite) int selectedInd;
@property (readwrite,assign) BOOL isSavedForm;

//-(void) hideKeyBoard:(id) sender;
//#pragma mark Call Api
//-(void)sendFormByIdRequest;
//-(void)formByIdComplete:(NSMutableDictionary *)data;
//-(void)formByIdRequestFailed:(NSError*)error;
//-(void)readWriteData:(NSMutableDictionary *)data;
//-(void)AddControlls:(NSArray*)aryFields;
//
//#pragma mark - Add Text View
//-(void)AddTextView:(int)tag Title:(NSString*)txtTitle KeyBoardType:(int)kbType;
//#pragma mark Text View Delegates
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
//
//#pragma mark - Add Text Fields
//-(void)AddTextFields:(int)tag Title:(NSString*)txtTitle KeyBoardType:(int)kbType;
//
//#pragma mark Text Field Delegates
//- (BOOL)textFieldShouldReturn:(UITextField *)textField;
//
//-(void)textFieldDidBeginEditing:(UITextField *)textField;
//
//-(void)textFieldDidEndEditing:(UITextField *)textField;
//
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
//
//#pragma mark - touchesBegan
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
//
//#pragma mark - Add Lables
//-(void)AddLable:(int)tag Title:(NSString*)lblTitle;
//#pragma mark - Add Buttons
//-(void)AddButton:(int)tag Title:(NSString*)btnTitle;
//- (void) btnAction:(id)sender;
//#pragma mark - Add Remove Picker View
//-(void)AddPickerButton:(int)tag Title:(NSString*)btnTitle;
//- (void) btnActionPicker:(id)sender;
//-(void)AddPicker;
//-(void)removePicker;
//
//#pragma mark Custom PickerView Delegates
//-(void)btnCancelClicked:(NSInteger)row;
//-(void)btnDoneClicked:(NSInteger)row;
//-(void)selectedIndex:(NSString*)str;
//#pragma mark - Add Remove Date Picker View
//-(void)AddDatePickerButton:(int)tag Title:(NSString*)btnTitle;
//- (void) btnActionDatePicker:(id)sender;
//-(void)AddDatePicker;
//#pragma mark Custom Date PickerView Delegates
//
//-(void)btnCancelDateClicked:(NSInteger)row;
//-(void)btnDoneDateClicked:(NSString*)str;
//-(void)selectedDateIndex:(NSString*)str;
//
//#pragma mark Custom Multiple Values Delegates
//-(void)AddMultiSelectionButton:(int)tag Title:(NSString*)btnTitle;
//- (void) btnActionMultiSelection:(id)sender;
//
//-(void)btnCancelMultiClicked:(NSInteger)row;
//-(void)btnDoneMultiClicked:(NSInteger)row;
//-(void)selectedValues:(NSString *)str;
//#pragma mark - Add Image View
//-(void)AddImageButtons:(int)tag Title:(NSString*)btnTitle;
//- (void) btnActionAddImage:(id)sender;
//- (void) btnViewImage:(id)sender;

@end

