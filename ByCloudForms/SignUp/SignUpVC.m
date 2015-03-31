//
//  SignUpVC.m
//  ByCloudForms
//
//  Created by Fahad Arshad on 6/19/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import "SignUpVC.h"

@interface SignUpVC ()

@end

@implementation SignUpVC

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
    [self setTitleBarItems];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setTitleBarItems
{
//    btnBackNav = [[UIBarButtonItem alloc]
//                    initWithTitle:@"Back"
//                    style:UIBarButtonItemStyleBordered
//                    target:self
//                    action:@selector(btnSignUp)];
//    self.navigationItem.leftBarButtonItem = btnBackNav;
    
    btnRegisterNav = [[UIBarButtonItem alloc]
                    initWithTitle:@"Register"
                    style:UIBarButtonItemStyleBordered
                    target:self
                    action:@selector(btnRegister)];
    self.navigationItem.rightBarButtonItem = btnRegisterNav;
    
    
    
}
- (void)btnRegister
{
    
}
- (void)btnBack
{
}
#pragma mark Text Field Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    if ([textField tag] == 1)
//    {
//        [textField resignFirstResponder];
//        [self sendSignInRequest];
//    }
//    else
//    {
//        [txtPassword becomeFirstResponder];
//    }
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
//    [txtPassword resignFirstResponder];
//    [txtUsername resignFirstResponder];
}

@end
