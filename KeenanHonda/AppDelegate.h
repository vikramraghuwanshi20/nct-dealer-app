//
//  AppDelegate.h
//  KeenanHonda
//
//  Created by Vikram on 4/16/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "oRewards.h"


#define NCWEBSITE @"http://www.ncompassmkt.com"
#define IMG_2DFILENAME  @"img_accountnumber.jpg"

@class oDealers;

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
NSTimer *parkingTimer;
 
}
@property(nonatomic,retain)  oDealers *dealer;

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic) int totalTime;

@property (strong, nonatomic) CLLocationManager *locationManager;




@property(nonatomic,retain)NSString *strTimeCounter;
@property(strong,nonatomic) NSString *latitude;
@property(strong,nonatomic) NSString *longitude;
-(void)startTimer;

@property (nonatomic, strong) oRewards *currentCustomer;

+(BOOL)isIPHONE;
+(BOOL)StringInString:(NSString *)str stringtofind:(NSString *)strfind;
+(AppDelegate *)current;

- (NSString *)UpdateFromWebWithAccountNumber:(NSString *)acctNo andZip:(NSString *)zip;

@end

