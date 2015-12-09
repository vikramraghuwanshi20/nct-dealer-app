//
//  globals.h
//  DVDCatalog
//
//  Created by supermandt on 8/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "globals.h"
#import "GlobalStuff.h"

//#define POWERED_BY @"http://www.dashyapps.com"
#define POWERED_BY @"http://www.ncompassmarketing.com"


#define SETTINGS_FILE @"settings.data"

enum LOST_BY {
	kLostMummies,
	kLostScarab,
	kLostSnake
};



#define PADDLE_ROUND @"round"
#define PADDLE_SQUARE @"square"
	

@interface globals : NSObject
{
	

	
    NSString *txtName;
	NSString *txtStatus;
	NSString *txtCheckedin;
	NSString *txtExtra1;
	NSString *txtExtra2;
	NSString *adurl;
	NSString *facebook;
	NSString *twitter;	
	NSString *txtWebsite;
	NSString *txtPaddleNumber;
	NSString *txtPaddleChoice;
	NSString *txtBackgroundColor;
	NSString *txtBidNumberColor;
	BOOL bPaddleVisible;
	NSString *txtNotes;

	
	
}
@property BOOL bPaddleVisible;
@property(nonatomic,copy) NSString *facebook;
@property(nonatomic,copy) NSString *twitter;	

@property(nonatomic,copy) NSString *txtName;
@property(nonatomic, copy) NSString *txtStatus;
@property(nonatomic, copy) NSString *txtCheckedin;
@property(nonatomic, copy) NSString *txtExtra1;
@property(nonatomic, copy) NSString *txtExtra2;
@property(nonatomic, copy) NSString *adurl;
@property(nonatomic, copy) NSString *txtWebsite;
@property(nonatomic, copy) NSString *txtPaddleNumber;
@property(nonatomic, copy) NSString *txtPaddleChoice;
@property(nonatomic, copy) NSString *txtBackgroundColor;
@property(nonatomic, copy) NSString *txtBidNumberColor;
@property(nonatomic, copy) NSString *txtNotes;


@property(nonatomic,copy) NSUserDefaults *usrDef;

-(void)LoadSettings;
-(void)SaveSettings;
+ (NSString *)GetDataPath:(NSString *)filename;

-(UIImage *)LoadDefaultAd;
-(void)SaveDefaultAd:(UIImage *)img;


-(void)SaveDefaultBackgroundPhoto:(UIImage *)img;
-(UIImage *)LoadDefaultBackgroundPhoto;
+(NSString *)webQueryString:(NSString *)url;
+(BOOL)StringInString:(NSString *)str stringtofind:(NSString *)strfind;
+(UIImage *)GetImageFromWeb:(NSString *)path;
+(NSString *)GetTodaysDateMDY;


+(void)AddSparkle:(UIView *)vw  withFrame:(CGRect)rect withTag:(NSInteger)nTag;
+(void)RotatingView:(UIView *)vw;
+(void)LoadFile:(UIWebView *)web filename:(NSString *)file ext:(NSString *)extfile;
+(NSString *)PrefixWithHTTP:(NSString *)saddress;

+(void)SavePhotoToDisk:(UIImage *)img filename:(NSString *)fname;
+(UIImage *)LoadPhotoFromDisk:(NSString *)fname;
+(NSString *)GetStringBetween:(NSString *)s string1:(NSString *)s1 string2:(NSString *)s2;
+(NSString *)LoadAccountNumber;
+(void)SaveAccountNumber:(NSString *)cn;
+(NSString *)LoadFullName;
+(void)SaveFullName:(NSString *)cn;
+ (BOOL) is4InchRetina;


@end


//globals *oGlobals;