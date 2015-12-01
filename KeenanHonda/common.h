/*
 *  common.h
 *  EgyptianNumbers
 *
 *  Created by supermandt on 11/6/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#import "globals.h"
#import "AppDelegate.h"

#define CreateDelegate() AppDelegate *dg = (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define INPUT_FONT [ UIFont systemFontOfSize:22.0]
#define BARBUTTON(TITLE, SELECTOR) 	[[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease]
#define NONULL(fld) (([fld length] == 0) || ([fld isEqualToString:@"(null)"])  ? @"":fld)
#define TRIM(fld) [fld stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
#define CHECK_NULL(nFld) (sqlite3_column_text(compiledStatement, nFld)==nil)?(char *)@"":((char *)sqlite3_column_text(compiledStatement, nFld))
// RETURNS STRING NSString* strId = [[UIDevice currentDevice] uniqueIdentifier];
#define GETUNIQUE_IDENT()  [[UIDevice currentDevice] uniqueIdentifier]
#define FIXQUOTES(str) [str stringByReplacingOccurrencesOfString:@"'" withString:@"''"]
#define SETTABLE_BACKGROUND() [UIColor groupTableViewBackgroundColor]
#define itootOPENWEBSITE(urlString) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]]
#define PATTERNBACKGROUND(myimage) [UIColor colorWithPatternImage: [UIImage imageNamed:myimage]]

#define IS_IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )

// example: 
//  UIButton *helpbutton;
//  itootPUSHBUTTON(helpbutton,@"HelpNormal.png",@"HelpOver.png");
#define itootPUSHBUTTON(btnName,imgNormal,imgOver) [btnName setBackgroundImage:[UIImage imageNamed:imgNormal] forState: UIControlStateNormal]; [btnName setBackgroundImage:[UIImage imageNamed:imgOver] forState: UIControlStateHighlighted]
#define itootDIALNUMBER(numbertodial) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:numbertodial]]
#define itootDIALPREFIX @"tel://"

// SEED random number generator
// example:
// itootRANDOMSEED();
#define itootRANDOMSEED srandom(time(NULL))


// Get a random number 
// Lets say between 1 and 12
// int num = itootRANDOMNUMBER(12);
#define itootRANDOMNUMBER(maxnum) random() % maxnum + 1 


// Get a random number 
// Lets say between 0 and 11
// int num = itootRANDOMNUMBER(12);
#define itootRANDOMNUMBERWITHZERO(maxnum) random() % maxnum  

// Get a random number - it bit more unique where randon number is more of a random number
// Lets say between 1 and 12
// int num = itootRANDOM(12);
#define itootRANDOM(maxnum) arc4random() % maxnum + 1 

// create a NSTimer
// example:
// lets create a timer that calls a decrement function every 2 seconds
// NSTimer *timer;
// timer = itootCREATETIMER(decrementfunc,2);
#define itootCREATETIMER(timerFunction,nseconds) [NSTimer scheduledTimerWithTimeInterval: nseconds target: self selector: @selector(timerFunction) userInfo: nil repeats: YES]

//Example:
// UIImage *buttonImageNormal;
// UIImage *buttonImagePressed;
// UIImage *stretchNomral;
// UIImage *stretchOver;
// 
// itootNEWDEFAULTNORMALBUTTON(helpbutton,buttonImageNormal,stretchNormal);

#define itootNEWDEFAULTNORMALBUTTON(btnname,buttonImageNormal,btnnormalpng,stretchNormal) buttonImageNormal = [UIImage imageNamed:btnnormalpng]; stretchNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0]; [btnname setBackgroundImage:stretchNormal forState:UIControlStateNormal]
#define itootNEWDEFAULTOVERBUTTON(btnname,buttonImagePressed,btnnoverpng,stretchOver) buttonImagePressed = [UIImage imageNamed:btnoverpng]; stretchOver = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];[bntname setBackgroundImage:stretchOver forState:UIControlStateHighlighted]
/*
 UIImage *buttonImageNormal = [UIImage imageNamed:@"whiteButton.png"];
 UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
 [doSomethingButton setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
 
 UIImage *buttonImagePressed = [UIImage imageNamed:@"blueButton.png"];
 UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
 [doSomethingButton setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];
 
 
 */

#define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 \
green:((c>>16)&0xFF)/255.0 \
blue:((c>>8)&0xFF)/255.0 \
alpha:((c)&0xFF)/255.0];

#define itootMESSAGEBOX(mes1,mes2,buttontitle) UIAlertView *alert =[[UIAlertView alloc] initWithTitle:mes1 message:mes2 delegate:nil cancelButtonTitle:buttontitle otherButtonTitles:nil];[alert show];	[alert release]


//#define itootNAVPUSH(dg,myview) [dg.navigationController pushViewController:myview animated:YES]
#define itootNAVPUSH(dg,myController,myView,nibName) myView = [[myController alloc] initWithNibName:nibName bundle:nil];  [dg.navigationController pushViewController:myView animated:YES]
#define itootNAVPOP(dg) [dg.navigationController popViewControllerAnimated:YES];

#define itootNAVMODALSHOW(controllerName,mycontroller,nibview) if( mycontroller == nil ) mycontroller = [[ controllerName alloc] initWithNibName:nibview bundle:nil];[[self navigationController] presentModalViewController:mycontroller animated:YES]
#define itootNAVMODALHIDE() [self dismissModalViewControllerAnimated:YES]

#define BARBUTTON(TITLE, SELECTOR) 	[[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease]
#define TRIM(fld) [fld stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]


