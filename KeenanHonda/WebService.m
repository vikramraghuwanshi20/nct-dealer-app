//
//  WebService.m
//  Municipality
//
//  Created by Ankur Sarda on 2/25/14.
//  Copyright (c) 2014 CIS. All rights reserved.
//

#import "WebService.h"

#define MAIN_URL_PAYMENT @"https://secure.total-apps-gateway.com/api/transact.php?"
#define MAIN_URL @"http://ncompassmkt.com/WebServices/DealerDash/IosServices.svc/"

@implementation WebService

//HTTP Web service method
+ (void)getDataFromJson:(NSData *)postString WebMethod:(NSString *)methodName requestType:(NSString *)methodType  ContentType:(NSString *)contentType getData:(WebServiceCalled) consumer
{
    //Web URL
    NSString * tempURL = [methodName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * strWebServiceURL;
    if ([contentType isEqualToString:@"x-www-form-urlencoded"]) {
        strWebServiceURL = [MAIN_URL_PAYMENT stringByAppendingString:tempURL];
    }else{
        strWebServiceURL = [MAIN_URL stringByAppendingString:tempURL];
    }

    
    NSURL *url = [NSURL URLWithString:strWebServiceURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:methodType];
    [request setValue:[NSString stringWithFormat:@"application/%@",contentType] forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postString];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
        NSInteger statusCode = [HTTPResponse statusCode];
        NSLog(@"Response string==%@, %ld",error.localizedDescription,statusCode);
        if (statusCode==200)
        {
            
            NSError* error;
             if ([contentType isEqualToString:@"x-www-form-urlencoded"]) {
                
                NSString *responseString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"Response string==%@",responseString);
                NSArray *json = [responseString componentsSeparatedByString:@"&"];
                NSMutableDictionary * dicResult = [self custom_convertToDictionary:json];
                consumer(dicResult,nil,TRUE);
                
            }else{
            
                NSDictionary *json = [NSJSONSerialization
                                 JSONObjectWithData:data
                                 options:kNilOptions
                                 error:&error];
                
                
                if ([[json valueForKey:@"status"] boolValue]) {
                    consumer(json,nil,TRUE);
                }else{
                    consumer(nil,error,FALSE);
                }
            }
            
        }
        else
        {
            consumer(nil,error,FALSE);
        }
    }];
}


//Method to convert NSArray into NSDictionary
+(NSMutableDictionary *)custom_convertToDictionary :(NSArray *)arrValues{
    
    NSMutableDictionary * responseDIC = [[NSMutableDictionary alloc] init];
    
    for (NSString * value in arrValues) {
        
        //split key & value
        NSArray * tempArray = [value componentsSeparatedByString:@"="];
        
        //add key & value in dic
        [responseDIC setValue:[tempArray objectAtIndex:1] forKey:[tempArray objectAtIndex:0]];
    }
    
    return responseDIC;
}


@end
