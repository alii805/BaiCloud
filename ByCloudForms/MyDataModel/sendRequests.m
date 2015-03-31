//
//  sendRequests.m
//  Ryvalry
//
//  Created by Fahad Arshad on 5/14/13.
//  Copyright (c) 2013 iLobia. All rights reserved.
//

#import "sendRequests.h"

@implementation sendRequests

@synthesize receivedData;
@synthesize delegate;
@synthesize callback;
@synthesize errorCallback;


static sendRequests *sharedInstance;
+(sendRequests *)sharedInstance{
	
	//if (sharedInstance == nil)
    sharedInstance = [[sendRequests alloc] init];
    
	return sharedInstance;
    
}

-(id)init{
	
	if (self = [super init])
	{
		receivedData	= nil;
		delegate		= nil;
		callback		= nil;
		errorCallback	= nil;
        receivedData = [[NSMutableData alloc] init];
        urlStr = @"";
//        BaseURLString = @"http://www.leadconcept.com/ryvalry/ws/registerService/register";
//        BaseURLString = @"http://leadconcept.com/ryvalry/user/register";
	}
	return self;
}
#pragma mark - Apis
//SignUp
- (void)sendRequestWithUrl:(NSArray *)data
                      Keys:(NSArray*)keys
                     MyURL:(NSString*)currentURL
                  delegate:(id)requestDelegate
    requestCompleteHandler:(SEL)requestHandler
        requestFailHandler:(SEL)requestFailHandler
{
    urlStr = currentURL;
    delegate = requestDelegate;
    callback = requestHandler;
    errorCallback = requestFailHandler;
	[self sendingRequestToURL:data Keys:keys];
}

#pragma mark - callbacks

-(void)loginCallBack:(NSData *)data
{
    NSLog(@"\n\n\nresponse XML: \n\n%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}
-(void)loginErrorCallBack:(NSError*)erro
{
    NSLog(@"%@", [erro localizedDescription]);
}


- (void)connection:(NSURLConnection *)connection  didFailWithError:(NSError *)error
{
    
	if(errorCallback){
		
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [delegate performSelector:errorCallback withObject:error];
#pragma clang diagnostic pop
    }
}

-(void) dealloc
{
    theConnection = nil;
    theRequest = nil;
    receivedData = nil;
}
//======================================
-(void)sendingRequestToURL:(NSArray *)data Keys:(NSArray *)keys
{
    if ([Utilities connected])
    {
        
        NSLog(@"%@", urlStr);
        
        NSURL * url = [NSURL URLWithString:urlStr];
        
        ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:url];
        [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
        request.shouldAttemptPersistentConnection   = NO;
        [request setRequestMethod:@"POST"];
        for (int i = 0; i < [data count];i++ )
        {
            NSLog(@"keys====%@",[data objectAtIndex:i]);
            [request setPostValue:[data objectAtIndex:i] forKey:[keys objectAtIndex:i]];
        }
        
        [request setDelegate:self];
        [request setTimeOutSeconds:1000];

        [request startAsynchronous];
        
    }
    else
    {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [delegate performSelector:errorCallback withObject:nil];
#pragma clang diagnostic pop
        
        //        [Utilities simpleOkAlertBox:TV_SampleTitle Body:CONNECTIVITY delegate:nil];
    }

   
    
}

#pragma mark APi Responce Check-In


-(void)requestFinished:(ASIHTTPRequest*)request
{
    NSDictionary *responseDict;
    if (request.responseStatusCode == 400)
    {
        
        NSString *responseString = [request responseString];
        
        
        responseString = [responseString stringByReplacingOccurrencesOfString: @"<string xmlns=\"http://tempuri.org/\">"
                                                                   withString:@""];
        
        responseString = [responseString stringByReplacingOccurrencesOfString: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                                                                   withString:@""];
        
        responseString = [responseString stringByReplacingOccurrencesOfString: @"</string>"
                                                                   withString:@""];
        
        responseString = [responseString stringByReplacingOccurrencesOfString: @"\r\n" withString:@""];
        
        
        NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError*error;
        responseDict = [NSJSONSerialization JSONObjectWithData:data //1
                                                       options:0
                                                         error:&error];

        NSLog(@"%@", responseString);
        NSLog(@"%@", responseDict);
        if (responseDict)
        {
            NSError *errorr = [ [NSError alloc] initWithDomain:@"Error" code:400 userInfo:responseDict];
            if(delegate && callback)
            {
                #pragma clang diagnostic push
                #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [delegate performSelector:errorCallback withObject:errorr];
                #pragma clang diagnostic pop
                
                //		[delegate performSelector:callback withObject:receivedData];
                NSLog(@"I got Response...");
            }
            else
                NSLog(@"No response from delegate");
        }
        
    }
    else if (request.responseStatusCode == 200)
    {
        NSString *responseString = [request responseString];
        
        
        responseString = [responseString stringByReplacingOccurrencesOfString: @"<string xmlns=\"http://tempuri.org/\">"
                                                                   withString:@""];
        
        responseString = [responseString stringByReplacingOccurrencesOfString: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                                                                   withString:@""];
        
        responseString = [responseString stringByReplacingOccurrencesOfString: @"</string>"
                                                                   withString:@""];
        
        responseString = [responseString stringByReplacingOccurrencesOfString: @"\r\n" withString:@""];
        
        
        NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError*error;
        responseDict = [NSJSONSerialization JSONObjectWithData:data //1
                                                                     options:0
                                                                       error:&error];
    
        
        NSLog(@"%@", responseString);
        NSLog(@"%@", responseDict);
        if(delegate && callback)
        {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:self.callback withObject:responseDict];
            #pragma clang diagnostic pop
            
            //		[delegate performSelector:callback withObject:receivedData];
            NSLog(@"I got Response...");
        }
        else
            NSLog(@"No response from delegate");
        

    }
    else if (request.responseStatusCode == 500)
    {
        if(errorCallback){
            NSError *error = [request error];
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:errorCallback withObject:error];
            #pragma clang diagnostic pop
        }
    }

}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"Request failed : %@", error);
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[request.error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [alertView show];
    
    if(errorCallback)
    {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [delegate performSelector:errorCallback withObject:error];
        #pragma clang diagnostic pop
    }
    
}


@end
