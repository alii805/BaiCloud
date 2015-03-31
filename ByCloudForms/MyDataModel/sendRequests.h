//
//  sendRequests.h
//  Ryvalry
//
//  Created by Fahad Arshad on 5/14/13.
//  Copyright (c) 2013 iLobia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utilities.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"

@interface sendRequests : NSObject
{
    
	
	NSMutableData		*receivedData;
	NSMutableURLRequest	*theRequest;
	NSURLConnection		*theConnection;
    __weak          id	delegate;
	SEL					callback;
	SEL					errorCallback;
	int					flag;
	int					statusFlag;
    NSString *urlStr;
	
	
}

@property(nonatomic, strong) NSMutableData *receivedData;
@property(nonatomic, weak) id			    delegate;
@property(nonatomic) SEL					callback;
@property(nonatomic) SEL					errorCallback;

+(sendRequests *)sharedInstance;
-(id)init;
-(void)sendingRequestToURL:(NSArray *)data Keys:(NSArray *)keys;
#pragma mark - Requests
//Requests
- (void)sendRequestWithUrl:(NSArray *)data
                                Keys:(NSArray*)keys
                                MyURL:(NSString*)currentURL
                            delegate:(id)requestDelegate
              requestCompleteHandler:(SEL)requestHandler
                  requestFailHandler:(SEL)requestFailHandler;
;

@end
