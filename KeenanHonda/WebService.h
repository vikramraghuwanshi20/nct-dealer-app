//
//  WebService.h
//  Municipality
//
//  Created by Ankur Sarda on 2/25/14.
//  Copyright (c) 2014 CIS. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^WebServiceCalled)(NSDictionary*,NSError*, BOOL);

@interface WebService : NSObject

+ (void)getDataFromJson:(NSData *)postString WebMethod:(NSString *)methodName requestType:(NSString *)methodType ContentType:(NSString *)contentType getData:(WebServiceCalled) consumer;

@end
