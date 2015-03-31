//
//  AddComponents.h
//  ByCloudForms
//
//  Created by Fahad Arshad on 6/12/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddComponents : NSObject
{
}
+(UIButton *)addButton:(NSString *)title Frame:(CGRect)frame Selector:(SEL)selector  delegate:(id)actionDelegate Tag:(int)tag;
+(UILabel *)addLable:(NSString *)title Frame:(CGRect)frame;
+(UITextField *)addTextField:(NSString *)title Frame:(CGRect)frame  delegate:(id)actionDelegate Tag:(int)tag KeyBoardType:(int)kbType;
+(UIButton *)addPickerButton:(NSString *)title Frame:(CGRect)frame Selector:(SEL)selector  delegate:(id)actionDelegate Tag:(int)tag;
+(UITextView *)addTextView:(NSString *)title Frame:(CGRect)frame  delegate:(id)actionDelegate Tag:(int)tag;
+(UILabel *)addSectionLable:(NSString *)title Frame:(CGRect)frame Color:(UIColor *)color Size:(int)size;
+(UIView *)addSectionLine:(CGRect)frame Color:(UIColor *)color;
@end
