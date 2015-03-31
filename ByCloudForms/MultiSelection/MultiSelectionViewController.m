//
//  MultiSelectionViewController.m
//  ByCloudForms
//
//  Created by Fahad Arshad on 6/13/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import "MultiSelectionViewController.h"

@interface MultiSelectionViewController ()

@end

@implementation MultiSelectionViewController
@synthesize delegate,aryData,aryDataSelected,fieldID,selectedDict;

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
//    selectedDict = [[NSMutableDictionary alloc] init];
    aryDataSelected = [[NSMutableArray alloc] init];
//    aryData = [[NSMutableArray alloc] initWithObjects:@"one",@"Two",@"Three",@"Four",@"Five",@"Six",@"Seven",@"Eight",@"Nine",@"Ten",@"Eleven",@"Twelve",@"Thirteen",@"Fourteen",@"Fifteen",@"Sixteen",@"Eighteen",@"Ninteen",@"Twenty", nil];
    
//    aryData = [[NSMutableArray alloc] init];
//    for (int i = 0; i<100; i++)
//    {
//        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//        [dict setObject:[NSString stringWithFormat:@"Select %d",i] forKey:jChoice];
//        [dict setObject:[NSString stringWithFormat:@"%d",i] forKey:jID];
//        [aryData addObject:dict];
//        
//    }

    [self setTitleBarItems];
}
#pragma mark - setTitleBarItems
-(void)setTitleBarItems
{
    btnCancelNav = [[UIBarButtonItem alloc]
                                initWithTitle:@"Cancel"
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(btnCancel)];
    self.navigationItem.leftBarButtonItem = btnCancelNav;
    
    btnDoneNav = [[UIBarButtonItem alloc]
                                initWithTitle:@"Done"
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(btnDone)];
    self.navigationItem.rightBarButtonItem = btnDoneNav;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"ryvalry_titleBar.png"]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 38, 32)];
//    [btnLeft setImage:[UIImage imageNamed:@"leftTop.png"] forState:UIControlStateNormal];
//    [btnLeft addTarget:self action:@selector(btnCancel) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
//    [self.navigationItem setLeftBarButtonItem:left];
//    
//    
//    UIButton *btnRight = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 38, 32)];
////    [btnRight setImage:[UIImage imageNamed:@"searchRightTop"] forState:UIControlStateNormal];
//    [btnRight addTarget:self action:@selector(btnDone) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
//    [self.navigationItem setRightBarButtonItem:right];
    //---------
    //========
    //    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"Left"
    //                                                             style:UIBarButtonItemStylePlain
    //                                                            target:self
    //                                                            action:@selector(showLeft)];
    //    self.navigationItem.leftBarButtonItem = PP_AUTORELEASE(left);
    //
    //    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"Right"
    //                                                              style:UIBarButtonItemStylePlain
    //                                                             target:self
    //                                                             action:@selector(showRight)];
    //    self.navigationItem.rightBarButtonItem = PP_AUTORELEASE(right);
    
    
}


- (void)btnCancel
{
    if (delegate)
    {
        [delegate selectedValues:@"Select Choices"];
        
    }
    
//    if (delegate)
//    {
//        [delegate btnCancelMultiClicked:[sender tag]];
//    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) btnDone
{
//    if (delegate)
//    {
//        [delegate btnDoneMultiClicked:[sender tag]];
//    }
//    aryDataSelected = [[NSMutableArray alloc] initWithArray:[selectedDict allValues]];
    [[Singleton sharedInstance].dictMultiSelectedStrings setObject:selectedDict forKey:fieldID];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableView Data Source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [aryData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

	if (nil == cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
	}
    
//  tableList is an array on dictionary elements.
//    NSDictionary *item = (NSDictionary *)[aryData objectAtIndex:indexPath.row];
    cell.textLabel.text = [[aryData objectAtIndex:indexPath.row] valueForKey:jChoice];
    if ([selectedDict count]>0)
    {
//        if ([[[selectedDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] valueForKey:jID] isEqualToString:[[aryData objectAtIndex:indexPath.row] valueForKey:jID]])
//        {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        }
//        else
//        {
//            cell.accessoryType = UITableViewCellAccessoryNone;
//        }
//        NSLog(@"%@",[[selectedDict valueForKey:[[aryData objectAtIndex:indexPath.row] valueForKey:jID]] valueForKey:jID]);
        if ([[[selectedDict valueForKey:[[aryData objectAtIndex:indexPath.row] valueForKey:jID]] valueForKey:jID] isEqualToString:[[aryData objectAtIndex:indexPath.row] valueForKey:jID]])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
     return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    aryDataSelected = nil;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
//        [selectedDict removeObjectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
        [selectedDict removeObjectForKey:[[aryData objectAtIndex:indexPath.row] valueForKey:jID]];
//        NSLog(@"Unselected");
    }
    else
    {    
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        [selectedDict setValue:[NSString stringWithFormat:@"%@",[aryData objectAtIndex:indexPath.row]] forKey:[NSString stringWithFormat:@"%d",indexPath.row]];
//        [selectedDict setValue:[aryData objectAtIndex:indexPath.row] forKey:[NSString stringWithFormat:@"%d",indexPath.row]];
        [selectedDict setValue:[aryData objectAtIndex:indexPath.row] forKey:[[aryData objectAtIndex:indexPath.row] valueForKey:jID]];
//        [[Singleton sharedInstance].dictImageContainer setObject:[NSString stringWithFormat:@"%@",resourceURL] forKey:myTag];
//        NSLog(@"Selected");
    }
    aryDataSelected = [[NSMutableArray alloc] initWithArray:[selectedDict allValues]];
    
    
//    NSLog(@">>>>>%@",aryDataSelected);
//    if ([aryDataSelected count]>0)
//    {
//        if (delegate)
//        {
//            [delegate selectedValues:[Utilities addingArraysForMultiSelection:aryDataSelected Key:jChoice]];
//        }
//    }
    
//    [tableView reloadData]; 
//    [tableView setNeedsDisplay];
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
//{
//    NSDictionary *item = (NSDictionary *)[aryData objectAtIndex:indexPath.row];
//    NSString *SelectedState = (NSString*)[item objectForKey:@"objSelected"];
//    if([SelectedState isEqualToString: @"YES"])
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    else
//        cell.accessoryType = UITableViewCellAccessoryNone;
//}

#pragma mark IBActions
//- (IBAction)btnCancel:(id)sender
//{
//    if (delegate)
//    {
//        [delegate btnCancelMultiClicked:[sender tag]];
//    }
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (IBAction)btnDone:(id)sender
//{
//    if (delegate)
//    {
//        [delegate btnDoneMultiClicked:[sender tag]];
//    }
//    [self.navigationController popViewControllerAnimated:YES];
//}
@end
