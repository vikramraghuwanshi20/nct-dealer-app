//
//  GlobalStuff.m
//  LoveAtTheMovies
//
//  Created by supermandt on 9/6/12.
//  Copyright (c) 2012 LoveATTheMovies.com. All rights reserved.
//


#import "GlobalStuff.h"
#include <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

static GlobalStuff *sharedGlobalStuff = nil;

@implementation GlobalStuff

@synthesize website,usrDef,aTerminalItems,aButtons,sServerAddress,aHistory,sBarcode,nScanType,alert,alertwaiting,gAppData,nPageToGoTo,dd;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedGlobalStuff == nil) {
            sharedGlobalStuff = [[self alloc] init];
        }
    });
    return sharedGlobalStuff;
}

- (id)init {
    if (self = [super init])
    {
        nPageToGoTo = PAGE_MAIN;
        website = @"http://www.dashyapps.com";
        usrDef = [NSUserDefaults standardUserDefaults];
        gAppData = @"";
       
        [self ClearHistory];
        if ([self GetServerAddress] == nil )
        {
            [self SaveServerAddress:@"http://www.nctcash.com"];
        }
        sBarcode = nil;
        nScanType = SCANTYPE_CARDNUMBER;
        dd = [[ oDealerData alloc] init];
        
        
    }
    return self;
}


-(void)ClearBarcode
{
    self.sBarcode = nil;
    
}

-(void)SaveSettings
{
    [usrDef synchronize];
}

-(NSInteger)GetTotalTerminalItems
{
    if (aTerminalItems != nil)
    {
        return [aTerminalItems count];
    }
    return 0;
}

-(void)AddHistoryItem:(NSString *)cardnumber  item:(NSString *)newitem  qty:(NSString *)newqty amount:(NSString *)newamount
{
    [aHistory addObject:[NSString stringWithFormat:@"%@\t%@\t%@\t%@",cardnumber,newitem,newqty,newamount]];
}
-(void)AddHistoryItem:(NSString *)rec
{
    [aHistory addObject:rec];
}

-(void)ClearHistory
{
  aHistory = [[NSMutableArray alloc ] init];
}

-(NSString *) LoadHistoryFromWeb:(NSString *)acct
{
    NSString *custdataurl = [NSString stringWithFormat:@"%@/Mobile/GetCustomerTransactions.aspx?number=%@&maxrecs=100",[self GetServerAddress],acct];
    return [self webQueryString:custdataurl];
}



-(NSString *)GetUserName
{
        return [usrDef objectForKey:KEY_USERNAME];
}
-(NSString *)GetUserPassword
{
       return [usrDef objectForKey:KEY_USERPASS];
    
}


-(NSString *)GetServerAddress
{
    return [usrDef objectForKey:KEY_SERVERADDRESS];
}
-(void) SaveServerAddress:(NSString *)saddr
{
    [usrDef setObject:saddr forKey:KEY_SERVERADDRESS];
}




-(void)SetUserName:(NSString *)uname
{
    [usrDef setObject:uname forKey:KEY_USERNAME];
}
-(void)SetUserPassword:(NSString *)upass
{
    [usrDef setObject:upass forKey:KEY_USERPASS];
}


- (void)dealloc {
    // Should never be called, but just here for clarity really.
}


-(BOOL)StringInString:(NSString *)str stringtofind:(NSString *)strfind
{
	if (str == nil || [str length] ==0)
	{
		return FALSE;
	}
	NSRange rng = [str rangeOfString:strfind];
	return rng.length > 0;
	
}



-(UIImage *)GetImageFromWeb:(NSString *)path
{
	NSURL *url = [NSURL URLWithString:path];
	NSData *data = [NSData dataWithContentsOfURL:url];
	UIImage *img = [[UIImage alloc] initWithData:data];
	
	if (img != nil)
	{
        // Image was loaded successfully.
		return img;
		
	}
    else
		return nil;
	
}


-(NSString *)webQueryString:(NSString *)url
{
	
	NSString *encstring = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *theURL = [NSURL URLWithString:encstring];
	//get the data from the web page
	NSString *results = [NSString stringWithContentsOfURL:theURL encoding:NSUTF8StringEncoding error:nil];
	
	return results;
}



- (NSString *)GetDataPath:(NSString *)filename
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:filename];
}


-(NSString *)GetTodaysDateMDY
{
	NSDate *now = [[NSDate alloc] init];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat: @"MM/dd/yyyy"]; // 2009-02-01 19:50:41 PST
	NSString *dateString = [dateFormat stringFromDate:now];
	return dateString;
	
}

-(void)webLoadHtml:(UIWebView *)web html:(NSString *)txtfile
{
	
	NSString *urlAddress = [[NSBundle mainBundle] pathForResource:txtfile ofType:@"html"];
	
	NSURL *url = [NSURL fileURLWithPath:urlAddress];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[web loadRequest:requestObj];
	
}

- (int)CountString:(NSString *)stringToCount inText:(NSString *)text
{
    int foundCount=0;
    NSRange range = NSMakeRange(0, text.length);
    range = [text rangeOfString:stringToCount options:NSCaseInsensitiveSearch range:range locale:nil];
    while (range.location != NSNotFound) {
        foundCount++;
        range = NSMakeRange(range.location+range.length, text.length-(range.location+range.length));
        range = [text rangeOfString:stringToCount options:NSCaseInsensitiveSearch range:range locale:nil];
    }
    
    return foundCount;
}

-(NSString *)GetStringBetween:(NSString *)s string1:(NSString *)s1 string2:(NSString *)s2
{
	NSMutableString *string1 = [NSMutableString stringWithString: s];
	NSString *string2;
	NSRange match1;
	NSRange match2;
	
	match1 = [string1 rangeOfString: s1];
	match2 = [string1 rangeOfString: s2];
	
	NSInteger loc = match1.location+match1.length;
	NSInteger len = match2.location-loc;
	
	string2 = [string1 substringWithRange: NSMakeRange (loc,len)];
	
	return string2;
}

-(UIImage *)MakeThumbnailOfSize:(UIImage *)img newsize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newThumbnail = UIGraphicsGetImageFromCurrentImageContext();
    // pop the context
    UIGraphicsEndImageContext();
    if(newThumbnail == nil)
        NSLog(@"could not scale image");
    return newThumbnail;
}

-(void)ShowMessageBox:(NSString *)message  title:(NSString *)newtitle
{
    UIAlertView *alertbox =[[UIAlertView alloc] initWithTitle:newtitle message:message delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alertbox show];


}


-(NSString *)GetUserPhoto:(NSString *)username
{
    return [NSString stringWithFormat:@"http://www.loveatthemovies.com/UserPhotos/%@photo1.jpg",username];
}

-(NSString *)GetUserPhotoThumb:(NSString *)username
{
    return [NSString stringWithFormat:@"http://www.loveatthemovies.com/UserPhotosThumbs/%@photo1.jpg",username];
}


-(void)WebConnectStart:(NSString *)mes
{
    if (mes == nil)
    {
        mes =@"Retrieving Customer Info\nPlease Wait...";
    }
    
    alert = [[UIAlertView alloc] initWithTitle:mes message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // Adjust the indicator so it is up a few pixels from the bottom of the alert
    indicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 50);
    [indicator startAnimating];
    [alert addSubview:indicator];
    
}
-(void)WebConnectEnd
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}


-(void)ShowWaitingMessageStart:(NSString *)title
{
    
    alertwaiting = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alertwaiting show];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // Adjust the indicator so it is up a few pixels from the bottom of the alert
    indicator.center = CGPointMake(alertwaiting.bounds.size.width / 2, alertwaiting.bounds.size.height - 50);
    [indicator startAnimating];
    [alertwaiting addSubview:indicator];
    
    
}
-(void)ShowWaitingMessageEnd
{
    [alertwaiting dismissWithClickedButtonIndex:0 animated:YES];
    
}

-(NSString *)GetDateTime
{
	NSDate *now = [[NSDate alloc] init];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat: @"MM/dd/yyyy hh:mm a"];
	return [dateFormat stringFromDate:now];
    
	
}

-(NSString *)Trim:(NSString *)s
{
    return [s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

-(void) playSound:(NSString *)mp3
{
    CFBundleRef mainBundle=CFBundleGetMainBundle();
    CFURLRef soundFileURLRef;
    soundFileURLRef =CFBundleCopyResourceURL(mainBundle, (CFStringRef) CFBridgingRetain(mp3), CFSTR("mp3"), NULL);
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
    AudioServicesPlaySystemSound(soundID);
}


-(NSString *)StringAfter:(NSString *)str  stringtofind:(NSString *)sfind
{
    if (str == nil || sfind==nil)
    {
        return @"";
    }
    
    NSRange range1 = [str rangeOfString:sfind];
    if (range1.location == NSNotFound)
    {
        return @"";
    }
    
    return [str substringFromIndex:NSMaxRange(range1)];
    
    
}
-(NSString *)StringBefore:(NSString *)str  stringtofind:(NSString *)sfind
{
    if (str == nil || sfind==nil)
    {
        return @"";
    }
    
    NSRange range2 = [str rangeOfString:sfind];
    if (range2.location == NSNotFound)
    {
        return @"";
    }
    
    return [str substringWithRange:NSMakeRange(0, range2.location) ];
    
    
}

+(NSString *)RemoveDiacritics:(NSString *)str
{
    if (str == nil)
    {
        return @"";
    }
    return [[NSString alloc] initWithData:[str dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] encoding:NSASCIIStringEncoding];
    
}

+(NSString *)FormatForPhone:(NSString *)phone
{
    
    if (phone==nil || [phone length] !=10)
    {
        return @"";
    }
    
    return   [NSString stringWithFormat:@"%@-%@-%@",
              [phone substringWithRange:NSMakeRange(0, 3)],
              [phone substringWithRange:NSMakeRange(3, 3)],
              [phone substringWithRange:NSMakeRange(6, 4)]
              ];
    
}





@end
