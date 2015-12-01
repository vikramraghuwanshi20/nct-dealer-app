//
//  iRecords.m
//  MobileMoney
//
//  Created by supermandt on 3/20/13.
//  Copyright (c) 2013 Dash Technologies. All rights reserved.
//

#import "iRecord.h"

@implementation iRecord


+(BOOL)IsSuccess:(NSString *)sdata
{
    if(sdata == nil )
        return false;
    
    return  [self StringInString:sdata stringtofind:RESPONSE_SUCCESS];
}

+(BOOL)StringInString:(NSString *)str stringtofind:(NSString *)strfind
{
	if (str == nil || [str length] ==0)
	{
		return FALSE;
	}
	NSRange rng = [str rangeOfString:strfind];
	return rng.length > 0;
	
}

+(NSInteger) GetTotalRecords:(NSString *)sdata
{
    if (sdata == nil)
    {
        return 0;
    }
    
    NSString *t = [self GetStringBetween:sdata string1:HTMLTAG_TOTALRECORDS_START string2:HTMLTAG_TOTALRECORDS_END ];
    if (t == nil || [t length] == 0)
    {
        return 0;
    }
    return [t intValue];
    
}


+(NSString *) CreateTotalRecordsString:(NSInteger)nRecords
{
    return [NSString stringWithFormat:@"%@%d%@",HTMLTAG_TOTALRECORDS_START,nRecords,HTMLTAG_TOTALRECORDS_END];
}

+(NSString *)GetStringBetween:(NSString *)s string1:(NSString *)s1 string2:(NSString *)s2
{
	NSMutableString *string1 = [NSMutableString stringWithString: s];
	NSString *string2;
	NSRange match1;
	NSRange match2;
	
	match1 = [string1 rangeOfString: s1];
	match2 = [string1 rangeOfString: s2];
	
    if (match1.length ==0 || match2.length==0)
    {
        return @"";
    }
    
	NSInteger loc = match1.location+match1.length;
	NSInteger len = match2.location-loc;
	
	string2 = [string1 substringWithRange: NSMakeRange (loc,len)];
	
	return string2;
}


+(NSString *) GetField:(NSString *)fld  withdata:(NSString *)sdata
{
    if(sdata == nil )
        return @"";
    
    NSString *s1 = [NSString stringWithFormat:@"<%@>",fld];
    NSString *s2 = [NSString stringWithFormat:@"</%@>",fld];
    
    
    return [self GetStringBetween:sdata string1:s1 string2:s2];
}



+(NSString *) CreateField:(NSString *)fld  withdata:(NSString *)sdata
{
    if(sdata == nil )
        return @"";
    
    return [NSString stringWithFormat:@"<%@>%@</%@>",fld,sdata,fld];
}


+(NSString *) CreateRecord:(NSInteger)nRec  withrec:(NSString *)sRec
{
    if (sRec == nil)
        return @"";
    
    return [NSString stringWithFormat:@"<irecord%d>%@</irecord%d>",nRec,sRec,nRec];
    
}

+(NSString *) GetRecord:(NSInteger)nRec withdata:(NSString *)sdata
{
    
    NSString *irecstart = [NSString stringWithFormat:@"<irecord%d>",nRec];
    NSString *irecend = [NSString stringWithFormat:@"</irecord%d>",nRec];
    
    return [self GetStringBetween:sdata string1:irecstart string2:irecend];
}

+(NSString *) EncodeHtml:(NSString *)xmldata
{
    
    if (xmldata == nil)
    {
        return @"";
    }
    return [xmldata stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}
+(NSString *) DecodeHtml:(NSString *)xmldata
{
    
    NSString *results = @"";
    
    if (xmldata == nil)
    {
        return results;
    }
    
    NSString *s = [NSString stringWithFormat:@"%@",[xmldata stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    s = [NSString stringWithFormat:[s stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"]];
    s = [NSString stringWithFormat:[s stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"]];
    
    return  s;
    
    
    //    results = [results stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    //    results = [results stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    //    return  results;
}

+(NSString *) FixEscapeCodes:(NSString *)xmldata
{
    NSString *s = [NSString stringWithFormat:[xmldata stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"]];
    s = [NSString stringWithFormat:[s stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"]];
    return s;
}




//EXAMPLE CALL
//
//dataWebService = [[NSMutableData alloc] init];
//NSString *yourPostString = [NSString stringWithFormat:@"%@%@%@%@%@",
//                            [iRecord CreateField:@"apiusername" withdata:APICODE_TESTUSER],
//                            [iRecord CreateField:@"apiuserpass" withdata:APICODE_TESTPASS],
//                            [iRecord CreateField:@"apicode" withdata:APICODE_CREDITCUSTOMERBALANCEBYCARDNUMBER],
//                            [iRecord CreateField:@"cardnumber" withdata:@"201203001850"],
//                            [iRecord CreateField:@"invoiceamount" withdata:@"50.99"]
//                            ];
//
//NSString *xmlParameters = [iRecord CreateRecord:1 withrec:yourPostString];
//[iRecord CallNCloud:xmlParameters setdelegate:self];
//
+(void)CallNCloud:(NSString *)xmlParameters setdelegate:(id)dele
{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.ncloudsvc.com/ncloudservice.svc/APIStream"]];
    
    NSString *postLength =  [NSString stringWithFormat:@"%d", [xmlParameters length]];
    //   [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
    [request addValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[xmlParameters dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *myConnection = [NSURLConnection connectionWithRequest:request delegate:dele];
    [myConnection start];
    
}

+(void)CallNCloudLIVE:(NSString *)xmlParameters setdelegate:(id)dele
{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.ncloudsvc.com/ncloudservice.svc/APIStreamLIVE"]];
    
    NSString *postLength =  [NSString stringWithFormat:@"%d", [xmlParameters length]];
    //   [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
    [request addValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[xmlParameters dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *myConnection = [NSURLConnection connectionWithRequest:request delegate:dele];
    [myConnection start];
    
}




//    dataWebService = [[NSMutableData alloc] init];
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    [dataWebService setLength:0];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    [dataWebService appendData:data];
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//
//    NSString *responseString = [[NSString alloc] initWithData:dataWebService encoding:NSUTF8StringEncoding];
//    _txtWSResults.text = [iRecord DecodeHtml:responseString];
//    if ([iRecord IsSuccess:_txtWSResults.text])
//    {
//        GlobalStuff *g = [GlobalStuff sharedManager];
//        [g ShowMessageBox:@"$50.99 has been credited to this account." title:@"SUCCESS!"];
//
//    }
//
//}
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    _txtWSResults.text = [error description];
//
//
//
//}



@end
