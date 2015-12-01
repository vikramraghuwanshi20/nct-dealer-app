//
//  globals.m
//  DVDCatalog
//
//  Created by supermandt on 8/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "globals.h"

#define DEFAULT_AD @"Default_AD.png"
#define DEFAULT_BACKGROUND_PHOTO @"DefaultBackPhoto.png"


@implementation globals

@synthesize usrDef;	
@synthesize txtName,txtStatus,txtCheckedin,txtExtra1,txtExtra2,adurl,facebook,twitter,txtWebsite,txtPaddleNumber,txtPaddleChoice,txtBackgroundColor,txtBidNumberColor;
@synthesize bPaddleVisible,txtNotes;

- (id) init
{
    if ((self = [super init]))
	{
		usrDef = [NSUserDefaults standardUserDefaults]; 
        [self LoadSettings];
        
        
        
	//	if ([self.txtChiro length] <= 1)
//		{
//			self.txtSponsoredby = @"Sponsored by:";
//			self.txtChiro = @"Tompkins Family Chiropractic";
//			self.txtWebsite = @"http://www.tompkinschiro.com";
//			self.txtExtra1 = @"Cumming,GA Office: 770-888-9027";
//			self.txtExtra2 = @"Dawsonville,GA Office: 706-265-7017";
//			self.logo = @"tomp.jpg";
//			[self SaveDefaultLogo:[UIImage imageNamed:@"tomp.jpg"]];
//			[self SaveSettings];
//		}
	}
    return self;
}

-(void)dealloc
{
//	[usrDef release];
	usrDef = nil;
//	[txtName release];
//	[txtStatus release];
//	[txtCheckedin release];
//	[txtExtra1 release];
//	[txtExtra2 release];
//	[adurl release];
//	[facebook release];
//	[twitter release];
//	[txtWebsite release];
//	[txtPaddleNumber release];
//	[txtPaddleChoice release];
//	[txtBackgroundColor release];
//	[txtBidNumberColor release];
//	[txtNotes release];
	
//	[super dealloc];
}


+(NSString *)LoadAccountNumber
{
    NSUserDefaults *usr = [NSUserDefaults standardUserDefaults];
    return [usr stringForKey:@"acctnumber"];
    
}
+(void)SaveAccountNumber:(NSString *)cn
{
    NSUserDefaults *usr = [NSUserDefaults standardUserDefaults];
	[usr setObject:cn forKey:@"acctnumber"];
}

+(NSString *)LoadFullName
{
    NSUserDefaults *usr = [NSUserDefaults standardUserDefaults];
    return [usr stringForKey:@"fullname"];
    
}
+(void)SaveFullName:(NSString *)cn
{
    NSUserDefaults *usr = [NSUserDefaults standardUserDefaults];
	[usr setObject:cn forKey:@"fullname"];
}




-(void)LoadSettings
{
	self.txtPaddleChoice = [usrDef stringForKey:@"paddlechoice"];
	self.txtPaddleNumber = [usrDef stringForKey:@"paddlenumber"];
	self.txtWebsite = 	[usrDef stringForKey:@"website"];
	self.txtName = [usrDef stringForKey:@"name"];
	self.adurl = [usrDef stringForKey:@"adurl"];
	self.txtBackgroundColor = [usrDef stringForKey:@"backgroundcolor"];
	self.txtBidNumberColor = [usrDef stringForKey:@"bidnumbercolor"];
	self.bPaddleVisible = [usrDef boolForKey:@"paddlevisible"];
	self.txtNotes = [usrDef stringForKey:@"notes"];
	


    
    
	if (self.txtPaddleChoice == nil ||
		[self.txtPaddleChoice length] <=1)
	{
		self.txtPaddleChoice = @"square";
	}
	
	if (self.txtPaddleNumber == nil ||
		[self.txtPaddleNumber length] == 0)
	{
		self.txtPaddleNumber = @"123";
	}

	if (self.txtName == nil)
	{
		self.txtName = @"TAP HERE TO ENTER YOUR NAME/COMPANY";
		self.bPaddleVisible = YES;
	}
	
	if (self.adurl == nil)
	{
		self.adurl = @"http://www.iPadPaddle.com/Advertisers/DashyAppsd.png";
		self.txtWebsite = @"http://www.dashyapps.com";
		//save to default image
	}

	if (self.txtBackgroundColor == nil)
	{
		self.txtBackgroundColor = @"Background1.png";
	}

	if (self.txtBidNumberColor == nil)
	{
		self.txtBidNumberColor = @"black";
	}


	
	
	
	//	self.txtExtra1 = [usrDef stringForKey:@"extra1"];
//	self.txtExtra2 = [usrDef stringForKey:@"extra2"];
//	self.logo = [usrDef stringForKey:@"logo"];
//	self.facebook = [usrDef stringForKey:@"facebook"];	
//	self.twitter = [usrDef stringForKey:@"twitter"];		

	
}



-(void)SaveSettings
{
	[usrDef setObject:self.txtPaddleChoice forKey:@"paddlechoice"];
	[usrDef setObject:self.txtPaddleNumber forKey:@"paddlenumber"];
	[usrDef setObject:self.txtWebsite forKey:@"website"];
	[usrDef setObject:self.txtName forKey:@"name"];
	[usrDef setObject:self.adurl forKey:@"adurl"];
	[usrDef setObject:self.txtBackgroundColor forKey:@"backgroundcolor"];
	[usrDef setObject:self.txtBidNumberColor forKey:@"bidnumbercolor"];	
	[usrDef setBool:self.bPaddleVisible forKey:@"paddlevisible"];
	[usrDef setObject:self.txtNotes forKey:@"notes"];
	
	//	[usrDef setObject:self.txtExtra1 forKey:@"extra1"];
//	[usrDef setObject:self.txtExtra2 forKey:@"extra2"];
//	[usrDef setObject:self.logo forKey:@"logo"];
//	[usrDef setObject:self.facebook forKey:@"facebook"];	
//	[usrDef setObject:self.twitter forKey:@"twitter"];		
	
}

//////////////////////////////////////
+(UIImage *)GetImageFromWeb:(NSString *)path
{
	NSURL *url = [NSURL URLWithString:path];
	NSData *data = [NSData dataWithContentsOfURL:url];
	UIImage *img = [[UIImage alloc] initWithData:data];
	
	if (img != nil)
	{ // Image was loaded successfully.
		return img;
		
	}
    else
		return nil;
	
}

+(NSString *)GetStringBetween:(NSString *)s string1:(NSString *)s1 string2:(NSString *)s2
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




+(BOOL)StringInString:(NSString *)str stringtofind:(NSString *)strfind
{
	if (str == nil || [str length] ==0)
	{
		return FALSE;
	}
	NSRange rng = [str rangeOfString:strfind];
	return rng.length > 0;
	
}


+(NSString *)webQueryString:(NSString *)url
{
	
	//	 return [NSString stringWithContentsOfURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
	
	//	NSURL *theURL = [[NSURL alloc] initWithString: [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	NSString *encstring = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *theURL = [NSURL URLWithString:encstring];
	//get the data from the web page
	NSString *results = [NSString stringWithContentsOfURL:theURL encoding:NSUTF8StringEncoding error:nil];
	
	return results;
}

-(void)SaveDefaultAd:(UIImage *)img
{
		[UIImagePNGRepresentation(img) writeToFile:[globals GetDataPath:DEFAULT_AD] atomically:YES];
}
-(void)SaveDefaultBackgroundPhoto:(UIImage *)img
{
	[UIImagePNGRepresentation(img) writeToFile:[globals GetDataPath:DEFAULT_BACKGROUND_PHOTO] atomically:YES];
	//	[UIImageJPEGRepresentation(img,1.0) writeToFile:[globals GetDataPath:DEFAULT_FACE_PHOTO] atomically:YES];
}


+(void)SavePhotoToDisk:(UIImage *)img filename:(NSString *)fname
{

	[UIImageJPEGRepresentation(img,0.9) writeToFile:[globals GetDataPath:fname] atomically:YES];
}

+(UIImage *)LoadPhotoFromDisk:(NSString *)fname
{
	UIImage *img = [UIImage imageWithContentsOfFile:[globals GetDataPath:fname]];
	
	return img;
}

+ (BOOL) is4InchRetina
{
    BOOL isIPad = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return (!isIPad && screenRect.size.height == 568);
}




+ (NSString *)GetDataPath:(NSString *)filename
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:filename];
}


+(NSString *)GetTodaysDateMDY
{
	NSDate *now = [[NSDate alloc] init];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat: @"MM/dd/yyyy"]; // 2009-02-01 19:50:41 PST
	NSString *dateString = [dateFormat stringFromDate:now];
	return dateString;
	
}



-(UIImage *)LoadDefaultAd
{
	
	UIImage *img = [UIImage imageWithContentsOfFile:[globals GetDataPath:DEFAULT_AD]];
	
	if (img == nil)
	{
		return [UIImage imageNamed:@"DashyBanner.png"];
	}
	return img;
	
}


-(UIImage *)LoadDefaultBackgroundPhoto
{
	
	UIImage *img = [UIImage imageWithContentsOfFile:[globals GetDataPath:DEFAULT_BACKGROUND_PHOTO]];
	
	if (img == nil)
	{
		return [UIImage imageNamed:@"Background1.png"];
	}
	return img;
	
}


+(void)RotatingView:(UIView *)vw
{

//	CABasicAnimation* fullRotation = [CABasicAnimation  animationWithKeyPath:@"transform.rotation"];
//    fullRotation.fromValue = [NSNumber numberWithFloat:0];
//	fullRotation.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
//	fullRotation.duration = 3;
//	fullRotation.repeatCount = HUGE_VALF;
//    fullRotation.removedOnCompletion = NO;    
//    [vw.layer addAnimation:fullRotation forKey:@"spinAnimation"];
//    return;
    
    CABasicAnimation *fullRotation;
	fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	fullRotation.fromValue = [NSNumber numberWithFloat:0];
	fullRotation.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
	fullRotation.duration = 3;
	fullRotation.repeatCount = HUGE_VALF;
    fullRotation.removedOnCompletion = NO;
  //  [vw.layer  setAnchorPoint:CGPointMake( -0.5, -0.5 )];
	[vw.layer addAnimation:fullRotation forKey:@"360"];		
	

}


+(void)AddSparkle:(UIView *)vw  withFrame:(CGRect)rect withTag:(NSInteger)nTag
{
	CABasicAnimation *fullRotation;
	fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	fullRotation.fromValue = [NSNumber numberWithFloat:0];
	fullRotation.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
	fullRotation.duration = 3;
	fullRotation.repeatCount = HUGE_VALF;
	
	UIImageView *sparkle1 = (UIImageView *)[vw viewWithTag:nTag];
	if ( sparkle1 != nil)
	{
		[sparkle1.layer addAnimation:fullRotation forKey:@"360"];		
		return;
	}
	
	sparkle1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sparkle.png"]];
	sparkle1.frame = rect;
	sparkle1.tag = nTag;
	
    //	sparkle1.layer.anchorPoint = CGPointMake(-0.5,-0.5);
	[sparkle1.layer addAnimation:fullRotation forKey:@"360"];
	[vw addSubview:sparkle1];
	[vw bringSubviewToFront:sparkle1];
	
}



+(void)LoadFile:(UIWebView *)web filename:(NSString *)file ext:(NSString *)extfile
{
	
	NSString *urlAddress = [[NSBundle mainBundle] pathForResource:file ofType:extfile];
	
	NSURL *url = [NSURL fileURLWithPath:urlAddress];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[web loadRequest:requestObj];
	
}

+(NSString *)PrefixWithHTTP:(NSString *)saddress
{
    return [NSString stringWithFormat:@"http://%@",saddress]; 
}



@end
