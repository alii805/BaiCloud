//
//  PickerViewController.m
//  SampleForDynamic
//
//  Created by Fahad Arshad on 6/11/13.
//  Copyright (c) 2013 Fahad Arshad. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController ()

@end

@implementation PickerViewController
@synthesize delegate,pickerView,dataAry,fieldID;
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
    // Do any additional setup after loading the view from its nib.
//    dataAry = [[NSMutableArray alloc] initWithObjects:@"one",@"Two",@"Three",@"Four",@"Five", nil];
    if ([[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:fieldID])
    {
        lblSelectedTitle.text = [[[Singleton sharedInstance].dictSingleSelectedIDs valueForKey:fieldID] valueForKey:jChoice];
    }
    else
    {
        lblSelectedTitle.text = [NSString stringWithFormat:@"%@",[[dataAry objectAtIndex:0] valueForKey:jChoice]];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Picker delegates
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    NSLog(@"Selected = %@",[dataAry objectAtIndex:row]);
    if (delegate)
    {
        [delegate selectedIndex:[[dataAry objectAtIndex:row] valueForKey:jChoice]];
    }
    lblSelectedTitle.text = [NSString stringWithFormat:@"%@",[[dataAry objectAtIndex:row] valueForKey:jChoice]];
    ind = row;
//    [[Singleton sharedInstance].dictMultiSelectedStrings setObject:selectedDict forKey:fieldID];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
   return [dataAry count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[dataAry objectAtIndex:row] valueForKey:jChoice];
}

#pragma mark - IBActions
- (IBAction)btnCancel:(id)sender
{
    if (delegate)
    {
        [delegate btnCancelClicked:[sender tag]];
    }
}

- (IBAction)btnDone:(id)sender
{
    [[Singleton sharedInstance].dictSingleSelectedIDs setObject:[dataAry objectAtIndex:ind] forKey:fieldID];
    if (delegate)
    {
        [delegate btnDoneClicked:[sender tag]];
    }
}
@end
