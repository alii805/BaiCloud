//
//  BCF_Defines.h
//  ByCloudForms
//
//  Created by Fahad Arshad on 6/12/13.
//  Copyright (c) 2013 LobiaSoft. All rights reserved.
//

#ifndef ByCloudForms_BCF_Defines_h
#define ByCloudForms_BCF_Defines_h



#endif

#pragma mark - URL's
// Url's

#define liveBaseUrl                 @"http://www.bainternational.org/ws/"
                                    //@"http://leadconcept.com/cloudforms/ws/"
//#define liveBaseUrl                 @"http://cloudforms.leadconcept.net/ws/"
//#define liveBaseUrl                 @"http://www.bainternational.org/ws/"
#define SignUpUrl                   @"userService/register"
#define SignInUrl                   @"userService/login"
#define FormsListUrl                @"formService/formList"
#define FormsByIdUrl                @"formService/formFieldsData"
#define FormsAnswerUrl              @"formService/formAnswer"
#define FormsAnswerImageUrl         @"formService/imageUpload"
#define FormsAnswerAudioUrl         @"formService/audioUpload"
#define FormsAnswerImageAmazon      @"formService/imageSaveAmazon"
#define FormsAnswerAudioAmazon      @"formService/audioSaveAmazon"



#pragma mark - Plists
//Plist

#define PListExt                      @"plist"
#define FormListPList                 @"FormListPList"

#pragma mark - KeyboardType
//KeyboardType
#define kbTypeDefault                 0
#define kbTypeAlphabet                1
#define kbTypeDecimalPad              2
#define kbTypeEmailAddress            3
#define kbTypeNamePhonePad            4
#define kbTypeNumberPad               5
#define kbTypeNumbersAndPunctuation   6
#define kbTypePhonePad                7
#define kbTypeTwitter                 8
#define kbTypeTypeURL                 9


#pragma mark - FieldsTypes
//FieldsTypes
#define jText                         @"text"
#define jNumber                       @"number"
#define jTextArea                     @"textarea"
#define jCheckbox                     @"checkbox"
#define jRadio                        @"radio"
#define jSelect                       @"select"
#define jSection                      @"section"
#define jPage                         @"page"
#define jShortname                    @"shortname"
#define jImage                        @"image"
#define jAddress                      @"address"
#define jDate                         @"date"
#define jEmail                        @"email"
#define jTime                         @"time"
#define jPhone                        @"phone"
#define jURL                          @"url"
#define jMoney                        @"money"
#define jAudio                        @"audio"
#define jSignature                    @"signature"



#pragma mark - ValueForKeys
//ValueForKeys
#define jFailure                     @"Failure"
#define jSuccess                     @"Success"
#define jStatus                      @"status"
//flags
#define fSave                        0
#define fSend                        1
#define fNext                        2

#define fOther                       0
#define fMulti                       1
#define fSingle                      2
#define fImg                         3

#define fSignImg                     5
#define fAudio                       4
#define fSignView                    1
#define fLibrary                     1

#define jStatus                      @"status"
#define jUserInfo                    @"userInfo"
#define jCompanyId                   @"companyId"
#define jCompanyType                 @"companyType"
#define jCompanyName                 @"companyName"
#define jGroupId                     @"groupId"
#define jGroupName                   @"groupName"
#define jID                          @"id"
#define jUserName                    @"userName"


#define jDataArray                   @"dataArray"
#define jForms                       @"forms"

#define jDescription                 @"description"
#define jTitle                       @"title"
#define jFormEditCount               @"formEditCount"

#define jFormData                    @"formData"
#define jFields                      @"fields"
#define jInstructions                @"instructions"
#define jIs_randomized               @"is_randomized"
#define jIs_required                 @"is_required"
#define jType                        @"type"
#define jChoices                     @"choices"
#define jChoice                      @"choice"
//#define jName                        @"field_name"

#define jField_id                    @"field_id"
#define jField_data                  @"field_data"
#define jField_type                  @"field_type"
//#define JField_name                  @"field_name"

#define jUser_id                     @"user_id"
#define jUser_agent                  @"user_agent"
#define jLongitude                   @"longitude"
#define jLatitude                    @"latitude"
#define jForm_id                     @"form_id"
#define jEntity_id                   @"entity_id"

//Keys for local
#define jFieldData                   @"fieldData"
#define jSelectedChoices             @"selectedChoices"
#define jFieldAry                    @"fields"
#define jFormID                      @"formID"



#define kBufferDurationSeconds .5

#pragma mark - Image View
// Image View

#define captureImage 1
#define camrarollImage 0
#define viewImageOnly 2

#pragma mark - Buttons for image
// Buttons for image

// iPhone
#define btnImgHeightIphone 36
#define btnImgWidthIphone 70

// iPad
#define btnImgHeightIpad 40
#define btnImgWidthIpad 200

#pragma mark - Buttons
// Buttons

// iPhone
#define btnHeightIphone 36
#define btnWidthIphone 280

// iPad
#define btnHeightIpad 40
#define btnWidthIpad 740

#pragma mark - Lables
// Lables

// iPhone
#define lblHeightIphone 22
#define lblWidthIphone 280

// iPad
#define lblHeightIpad 28
#define lblWidthIpad 740

#pragma mark - Text Fields
// Text Fields

// iPhone
#define txtHeightIphone 34
#define txtWidthIphone 280

// iPad
#define txtHeightIpad 36
#define txtWidthIpad 740

#pragma mark - Text View
// Text View

// iPhone
#define txtViewHeightIphone 60
#define txtViewWidthIphone 280

// iPad
#define txtViewHeightIpad 70
#define txtViewWidthIpad 740

// iPhone
#define sectionHeightIphone 2
#define sectionWidthIphone 320

// iPad
#define sectionHeightIpad 3
#define sectionWidthIpad 768

#define lblSectionFontSize 22

#pragma mark - Alert View
// Alert View
#define avSuccess                           @"Success"
#define avWarning                           @"Warning"
#define avMsgInternetConnectionNotAvaliable @"Internet connection not avaliable."
#define avMsgFieldsShouldBeFilled           @"Fields should be filled."
#define avTitleError                        @"Error"


#define avMsgisRequiredToSubmitTheForm      @"is required to submit the form."
#define avMsgisNotValid                     @"is not valid."
#define avMsgDataSavedSuccessfully          @"Data saved successfully."
#define avMsgUnableToSaveData               @"Unable to save data."
#define avMsgFileNotFound                   @"File not found."
#define avMsgAudioSavedSuccessfully         @"Audio saved successfully."
#define avMsgFormIsAlreadyUploded           @"Form is already uploaded."
#define avMsgFormUplodedSuss                @"Form uploaded successfully."
#define avMsgUnableToUploadFiles            @"Unable to upload the files pleae try later."
#define avMsgUnableToConnectInternet        @"Unable to connect internet please connect your internet."
#pragma mark - MBProgressHUD
// MBProgressHUD
#define hudHead                         @"Processing.."
#define hudDetail                       @"Please wait"
