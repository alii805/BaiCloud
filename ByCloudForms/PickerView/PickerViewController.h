//
//  PickerViewController.h
//  SampleForDynamic
//
//  Created by Fahad Arshad on 6/11/13.
//  Copyright (c) 2013 Fahad Arshad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@protocol pickerViewProtocol <NSObject>
@optional

-(void)btnCancelClicked:(NSInteger)row;
-(void)btnDoneClicked:(NSInteger)row;
-(void)selectedIndex:(NSString*)str;

@end
@interface PickerViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>
{
    id <pickerViewProtocol> delegate;
    
    NSMutableArray * dataAry;
    __weak IBOutlet UIPickerView *pickerView;
    __weak IBOutlet UIView *viewHolderPicker;
    __weak IBOutlet UIButton *btnCancel;
    __weak IBOutlet UIButton *btnDone;
    __weak IBOutlet UILabel *lblSelectedTitle;
    NSString *fieldID;
    int ind;
}

@property(nonatomic,strong) id delegate;
@property(nonatomic,strong) NSMutableArray *dataAry;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (readwrite, strong) NSString *fieldID;
- (IBAction)btnCancel:(id)sender;
- (IBAction)btnDone:(id)sender;


@end
