//
//  AddComponents.m
//  ByCloudForms
//
//  Created by Fahad Arshad on 6/12/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import "AddComponents.h"

@implementation AddComponents
{
}
+(UIButton *)addPickerButton:(NSString *)title Frame:(CGRect)frame Selector:(SEL)selector  delegate:(id)actionDelegate Tag:(int)tag
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = frame;
    [btn addTarget:actionDelegate action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:[NSString stringWithFormat:@"   %@",title] forState:UIControlStateNormal];
    //    [btn setImage:image forState:UIControlStateNormal];
    //    btn.backgroundColor = [UIColor whiteColor];
    //    [btn setTintColor:[UIColor blueColor]];
//    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [[btn titleLabel] textAlignment];
    btn.tag = tag;
    
    return btn;
    
}
+(UIButton *)addButton:(NSString *)title Frame:(CGRect)frame Selector:(SEL)selector  delegate:(id)actionDelegate Tag:(int)tag
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = frame;
    [btn addTarget:actionDelegate action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setImage:image forState:UIControlStateNormal];
//    btn.backgroundColor = [UIColor whiteColor];
//    [btn setTintColor:[UIColor blueColor]];
    btn.tag = tag;
    
    return btn;
    
}
+(UITextField *)addTextField:(NSString *)title Frame:(CGRect)frame  delegate:(id)actionDelegate Tag:(int)tag KeyBoardType:(int)kbType
{
    
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = frame;
    textField.tag = tag;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:15];
    textField.placeholder = title;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if (kbType == kbTypeDefault)
    {
        textField.keyboardType = UIKeyboardTypeDefault;
    }
    else if (kbType == kbTypeAlphabet)
    {
        textField.keyboardType = UIKeyboardTypeAlphabet;
    }
    else if (kbType == kbTypeDecimalPad)
    {
        textField.keyboardType = UIKeyboardTypeDecimalPad;
    }
    else if (kbType == kbTypeEmailAddress)
    {
        textField.keyboardType = UIKeyboardTypeEmailAddress;
    }
    else if (kbType == kbTypeNamePhonePad)
    {
        textField.keyboardType = UIKeyboardTypeNamePhonePad;
    }
    else if (kbType == kbTypeNumberPad)
    {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    else if (kbType == kbTypeNumbersAndPunctuation)
    {
        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }else if (kbType == kbTypePhonePad)
    {
        textField.keyboardType = UIKeyboardTypePhonePad;
    }
    else if (kbType == kbTypeTwitter)
    {
        textField.keyboardType = UIKeyboardTypeTwitter;
    }else if (kbType == kbTypeTypeURL)
    {
        textField.keyboardType = UIKeyboardTypeURL;
    }
    
    
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.delegate = actionDelegate;
    return textField;
    
}
+(UITextView *)addTextView:(NSString *)title Frame:(CGRect)frame  delegate:(id)actionDelegate Tag:(int)tag
{
    
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = frame;
    textView.tag = tag;
//    textView.borderStyle = UITextBorderStyleRoundedRect;
    textView.font = [UIFont systemFontOfSize:15];
//    textField.placeholder = title;
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    textView.keyboardType = UIKeyboardTypeDefault;
    textView.returnKeyType = UIReturnKeyDone;
    textView.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:0.5];
    textView.scrollEnabled = YES;
//    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textView.delegate = actionDelegate;
    return textView;
    
}
+(UILabel *)addLable:(NSString *)title Frame:(CGRect)frame
{
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.text = title;
//    label.backgroundColor = [UIColor redColor];
    [label setFont:[UIFont systemFontOfSize:17]];
    return label;
}
+(UILabel *)addSectionLable:(NSString *)title Frame:(CGRect)frame Color:(UIColor *)color Size:(int)size
{
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.text = title;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];
    [label setFont:[UIFont systemFontOfSize:size]];
    return label;
}
+(UIView *)addSectionLine:(CGRect)frame Color:(UIColor *)color
{
    UIView *sectionView = [[UIView alloc] initWithFrame:frame];
    sectionView.backgroundColor = color;
    return sectionView;
}

@end
