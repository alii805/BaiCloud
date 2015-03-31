//
//  DatePickerVC.h
//  ByCloudForms
//
//  Created by Fahad Arshad on 6/14/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol pickerViewDateProtocol <NSObject>
@optional

-(void)btnCancelDateClicked:(NSInteger)row;
-(void)btnDoneDateClicked:(NSString*)str;
-(void)selectedDateIndex:(NSString*)str;
@end

@interface DatePickerVC : UIViewController
{
    id <pickerViewDateProtocol> delegate;
    __weak IBOutlet UIDatePicker *pickerDate;
    __weak IBOutlet UIButton *btnCancel;
    __weak IBOutlet UIButton *btnDone;
    int flag;
    __weak IBOutlet UILabel *lblSelectedTitle;
}

@property (weak, nonatomic) IBOutlet UIDatePicker *pickerDate;
@property(nonatomic,strong) id delegate;
@property(assign,readwrite) int flag;

- (IBAction)btnCancel:(id)sender;
- (IBAction)btnDone:(id)sender;

@end
