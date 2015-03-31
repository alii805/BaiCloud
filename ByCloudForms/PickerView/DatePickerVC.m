//
//  DatePickerVC.m
//  ByCloudForms
//
//  Created by Fahad Arshad on 6/14/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import "DatePickerVC.h"

@interface DatePickerVC ()

@end

@implementation DatePickerVC
@synthesize pickerDate,flag,delegate;
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
    
    if (flag == 0)//Date
    {
        pickerDate.datePickerMode = UIDatePickerModeDate;
    }
    else if (flag == 1)//Time
    {
        pickerDate.datePickerMode = UIDatePickerModeTime;
    }
    
    [pickerDate addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    if (delegate)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
        
        
        
        if (flag == 0)//Date
        {
            dateFormatter.dateFormat = @"MM/dd/yyyy";
        }
        else if (flag == 1)//Time
        {
            dateFormatter.dateFormat = @"hh:mm:ss a";
        }
        [delegate selectedDateIndex:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:pickerDate.date]]];
        lblSelectedTitle.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:pickerDate.date]];
//        [delegate btnDoneDateClicked:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:pickerDate.date]]];
    }
//    pickerDate.datePickerMode = UIDatePickerModeTime;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) changeDate:(id) sender
{
//    [datePickerDate ];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    

    
    if (flag == 0)//Date
    {
        dateFormatter.dateFormat = @"MM/dd/yyyy";
    }
    else if (flag == 1)//Time
    {
        dateFormatter.dateFormat = @"hh:mm:ss a";
    }

//    NSLog(@"%@",[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:pickerDate.date]]);
    lblSelectedTitle.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:pickerDate.date]];
    if (delegate)
    {
        [delegate selectedDateIndex:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:pickerDate.date]]];
    }
}
#pragma mark - IBActions
- (IBAction)btnCancel:(id)sender
{
    if (delegate)
    {
        [delegate btnCancelDateClicked:[sender tag]];
    }
}

- (IBAction)btnDone:(id)sender
{
    if (delegate)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
        
        
        
        if (flag == 0)//Date
        {
            dateFormatter.dateFormat = @"MM/dd/yyyy";
        }
        else if (flag == 1)//Time
        {
            dateFormatter.dateFormat = @"hh:mm:ss a";
        }

        [delegate btnDoneDateClicked:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:pickerDate.date]]];
    }
}
@end
